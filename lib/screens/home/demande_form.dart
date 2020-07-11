import 'package:colocexam/models/user.dart';
import 'package:colocexam/partages/constantes.dart';
import 'package:colocexam/partages/loading.dart';
import 'package:colocexam/services/authService.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemandeForm extends StatefulWidget {
  @override
  _DemandeFormState createState() => _DemandeFormState();
}

class _DemandeFormState extends State<DemandeForm> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String _currentcorps;
  int _currentbudger;
  String _currentcordonnees;

  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);

    return StreamBuilder<UserDocument>(
        stream: DatabaseService(uid: usersData.uid).userDocument,
        builder:(context,snapshot) {
          if(snapshot.hasData){
            UserDocument mydocument = snapshot.data;
            return Scaffold(
                appBar:AppBar(
                  title: Text('nouvelle demande'),
                  backgroundColor: Colors.grey,
                  elevation: 0.0,
                  actions: <Widget>[
                    FlatButton.icon(onPressed: () async{ await _authService.logout(); }, icon: Icon(Icons.exit_to_app), label: Text('logout')),
                  ],
                ),
                resizeToAvoidBottomPadding: false,

                body : SingleChildScrollView(
                  child : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'Nom et prenom' ),
                            validator: (val) => val.isEmpty ? 'cordonnees is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _currentcordonnees = val;
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'budgé max' ),
                            validator: (val) => val.isEmpty  ? 'budgé is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _currentbudger = int.parse(val);
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'commentaire' ),
                            validator: (val) => val.isEmpty ? 'commentaire is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _currentcorps = val;
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          RaisedButton.icon(onPressed: () async {
                            if(_formkey.currentState.validate()) {
                              await DatabaseService(uid: usersData.uid).createDemande(
                                  _currentcordonnees ?? '',
                                  _currentcorps ?? '',
                                  _currentbudger ?? '',
                                  usersData.uid);
                              Navigator.pop(context);
                            }
                            //
                          }, label: Text('Envoyer') ,icon: Icon(Icons.send,textDirection: TextDirection.ltr,), color: Colors.orange[100], padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),)
                        ],
                      ),
                    ),
                  ),
                ),
            );
          }else {
            return Loading();
          }
        }
    );
  }
}

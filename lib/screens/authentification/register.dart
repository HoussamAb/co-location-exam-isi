import 'package:colocexam/Dao/database.dart';
import 'package:colocexam/partages/constantes.dart';
import 'package:colocexam/partages/loading.dart';
import 'package:colocexam/screens/home/home.dart';
import 'package:colocexam/screens/map/index.dart';
import 'package:colocexam/services/authService.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function view;

  const Register({Key key, this.view});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final ServiceDb _authService_api = ServiceDb();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String erreur = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[10],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        title: Text('Co-Location  | New user '),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Login'),
            onPressed: () {
              widget.view();
            },
          )
        ],
      ),

      drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new DrawerHeader(
                child:  new Text('Header'),
              ),
              FlatButton.icon( icon: Icon(Icons.map), label: Text('Maps') , onPressed: (){ return IndexMap();},),
              new Divider(),
              new ListTile(
                title: new Text('Crée une demande'),
                onTap: () { IndexMap();},
              ),
              new Divider(),
              new ListTile(
                title: new Text('Crée une annonce'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('Liste des demandes'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('Liste des annonces'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('About'),
                onTap: () {},
              ),
              new Divider(),

            ],
          )
      ),
          resizeToAvoidBottomPadding: false,

          body : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon_bg.png'),
                        scale: 4.0,
                        alignment: Alignment(0,-1)
                    )
                ),
                padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Align(
                          alignment: Alignment.centerLeft, child: new Text('Email :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                      TextFormField(
                        decoration: textFormDecor.copyWith(hintText: 'Enter votre email' ),
                        validator: (val) => val.isEmpty ? 'Enter votre email' : null,
                        onChanged: (val){
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0,),
                      Align(
                          alignment: Alignment.centerLeft, child: new Text('Password :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                      TextFormField(
                        decoration: textFormDecor.copyWith(hintText: 'Enter votre password' ),
                        validator: (val) => val.length < 8 ? '8 charactères requises au minimum' : null,
                        obscureText: true,
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 30.0,),
                      RaisedButton(
                        color: Colors.redAccent[200],
                        child: Text('Valider',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(_formkey.currentState.validate()){
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService_api.registerWithEmailAndPassword(email, password,'user_'+email.substring(0,5));
                            if(result == null ){
                              setState(() {
                                erreur = 'veillez entrer un email valide !';
                                loading = false;
                              });
                            }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => home()));

                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        erreur,
                        style: TextStyle(color: Colors.red,fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
          ),
    );
  }
}

import 'package:colocexam/partages/constantes.dart';
import 'package:colocexam/partages/loading.dart';
import 'package:colocexam/screens/map/index.dart';
import 'package:colocexam/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  final Function view;

  const SignIn({ this.view});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
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
        title: Text('Co-Location | Login'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Create'),
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
                        decoration: textFormDecor.copyWith(hintText: 'Enter votre email' , fillColor: Colors.white),
                        validator: (val) => val.isEmpty ? 'Enter votre email' : null,
                        onChanged: (val){
                          setState(() {
                            email = val.trim();
                          });
                        },
                      ),
                      SizedBox(height: 20.0,),
                      Align(
                          alignment: Alignment.centerLeft, child: new Text('Password :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                      TextFormField(
                        decoration: textFormDecor.copyWith(hintText: 'Enter votre password' , fillColor: Colors.white),
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
                        child: Text('Login',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if(_formkey.currentState.validate()){
                            setState(() {loading = true; });
                              dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                              if(result == null ){
                                setState(() {
                                  erreur = 'vos données de connexion sont incorrect  !';
                                  loading = false;
                                });
                              }
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

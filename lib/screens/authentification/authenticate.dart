
import 'package:colocexam/screens/authentification/register.dart';
import 'package:colocexam/screens/authentification/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();

}

class _AuthenticateState extends State<Authenticate>{

  bool signinpage = true;

  @override
  Widget build(BuildContext context){
    if(signinpage){
      return SignIn(view: toggleView);
    }else{
      return Register(view: toggleView);
    }
  }

  void toggleView(){
    setState(() {
      signinpage = !signinpage;
    });
}

}
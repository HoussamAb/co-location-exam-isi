import 'package:colocexam/models/user.dart';
import 'package:colocexam/screens/authentification/authenticate.dart';
import 'package:colocexam/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'map/index.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user != null){
      return home();
    }else {
      return Authenticate();
    }
  }
}

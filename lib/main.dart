import 'dart:async';

import 'package:colocexam/Dao/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/authService.dart';
import 'models/user.dart';
import 'screens/wrapper.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value:ServiceDb().user,
        child: MaterialApp(
          home: Wrapper(),
        )
    );
  }
}

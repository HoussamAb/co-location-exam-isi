import 'package:flutter/material.dart';

const textFormDecor = InputDecoration(
  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey,width: 1.0),),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pinkAccent,width: 1.0),
  ),

);
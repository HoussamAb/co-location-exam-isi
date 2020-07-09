import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/screens/home/annonce_ligne.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Annonces_list extends StatefulWidget {
  @override
  _Annonces_listState createState() => _Annonces_listState();
}

class _Annonces_listState extends State<Annonces_list> {
  @override
  Widget build(BuildContext context) {
    final listAnonnces = Provider.of<List<Annonce>>(context) ?? [];

    /// print(listAnonnces);
    return ListView.builder(
        itemCount: listAnonnces.length,
        itemBuilder: (context, index) {
          return annonce_ligne(annonce: listAnonnces[index]);
        }
    );
  }
}
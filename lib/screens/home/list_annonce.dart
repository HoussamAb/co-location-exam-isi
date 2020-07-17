import 'package:colocexam/Dao/database.dart';
import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/screens/home/annonce_ligne.dart';
import 'package:colocexam/services/authService.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Annonces_list extends StatefulWidget {
  @override
  _Annonces_listState createState() => _Annonces_listState();
}

class _Annonces_listState extends State<Annonces_list> {
  @override
  Widget build(BuildContext context) {


    List<Annonce> listAnonnces = ServiceDb.annonces ?? [];
    print('list annonce: ${listAnonnces.length}');

    /// print(listAnonnces);
    return ListView.builder(
        itemCount: listAnonnces.length,
        itemBuilder: (context, index) {
          return annonce_ligne(annonce: listAnonnces[index]);
        }
    );
  }
}


class ListAnnoonce extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Annonce>>.value(
      value: ServiceDb().usersAnnonce,
      child: Scaffold(

        body: Container(

          child:Annonces_list(),

        ),
      ),
    );
  }
}

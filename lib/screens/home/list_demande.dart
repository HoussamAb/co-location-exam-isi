import 'package:colocexam/Dao/database.dart';
import 'package:colocexam/models/demande.dart';
import 'package:colocexam/screens/home/demande_ligne.dart';
import 'package:colocexam/services/authService.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDemande extends StatefulWidget {
  @override
  _ListDemandeState createState() => _ListDemandeState();
}

class _ListDemandeState extends State<ListDemande> {
  @override
  Widget build(BuildContext context) {
    final listDemandes = Provider.of<List<Demande>>(context) ?? [];

    return  ListView.builder(
            itemCount: listDemandes.length,
            itemBuilder: (context, index) {
              return DemandeLigne(demande: listDemandes[index]);
            },
    );
  }
}

class ListDemds extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Demande>>.value(
      value: ServiceDb().usersDemande,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          title: Text('Liste demandes'),
          backgroundColor: Colors.grey,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async{ await _authService.logout(); }, icon: Icon(Icons.exit_to_app), label: Text('logout')),
          ],
        ),
        body: Container(

          child:ListDemande(),

        ),
      ),
    );
  }
}



class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Demande>>.value(
      value: ServiceDb().usersDemande,
        child: Scaffold(
            backgroundColor: Colors.orange[100],
            appBar: AppBar(
                title: Text('Liste des demandes'),
                backgroundColor: Colors.redAccent[100],
                elevation: 0.0,
                actions: <Widget>[
                FlatButton.icon(onPressed: () async{ await _authService.logout(); }, icon: Icon(Icons.exit_to_app), label: Text('logout')),
            ],
            ),
            body: Container(

              child:ListDemande(),

            ),
    ),
    );
  }
}


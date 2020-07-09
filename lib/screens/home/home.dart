import 'package:colocexam/screens/home/list_annonce.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Annonces'),
          backgroundColor: Colors.blueGrey[100],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon( icon:Icon(Icons.person), label: Text('profile')),
            FlatButton.icon( icon: Icon(Icons.exit_to_app), label: Text('logout')),
          ],
        ),
        body: Container(

          child:Annonces_list(),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey[100],
        ),
      ),
    );
  }
}

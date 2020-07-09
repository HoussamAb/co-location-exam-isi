import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class annonce_ligne extends StatefulWidget {
  final Annonce annonce;
  const annonce_ligne({this.annonce});
  @override
  _annonce_ligneState createState() => _annonce_ligneState();
}

class _annonce_ligneState extends State<annonce_ligne> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);
    String choix;
    final GlobalKey _menuKey = new GlobalKey();

    return StreamBuilder<UserDocument>(
        stream: DatabaseService(uid: usersData.uid).userDocument,
        builder:(context,snapshot) {
          return Padding (

            padding: EdgeInsets.only(top: 4.0),
            child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                  ),
                  title: Text(widget.annonce.title),
                  subtitle: Text('Objet : ${widget.annonce.details} '),
                  trailing: new PopupMenuButton(
                    key: _menuKey,
/*
                    onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem),
*/
/*
                    itemBuilder: (BuildContext context) => luckyNumbers,
*/
                    tooltip: "cliquer pour selectionner une action.",
                  ),
                  /// trailing: Icon(Icons.more_vert),
                  onTap: () {
                    dynamic popUpMenustate = _menuKey.currentState;
                    popUpMenustate.showButtonMenu();
                  },
                )
            ),
          );
        }
    );

  }
}

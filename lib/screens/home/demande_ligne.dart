import 'package:colocexam/models/demande.dart';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemandeLigne extends StatefulWidget {
  final Demande demande;
  const DemandeLigne({this.demande});
  @override
  _DemandeLigneState createState() => _DemandeLigneState();
}

class _DemandeLigneState extends State<DemandeLigne> {
  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);
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
                  title: Text(widget.demande.cordonnees),
                  subtitle: Text('Objet : ${widget.demande.commentaire} '),
                  /*trailing: new PopupMenuButton(
                    key: _menuKey,
*//*
                    onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem),
*//*
*//*
                    itemBuilder: (BuildContext context) => luckyNumbers,
*//*
                    tooltip: "cliquer pour selectionner une action.",
                  ),*/
                  /// trailing: Icon(Icons.more_vert),
                  onTap: () {

                  },
                )
            ),
          );
        }
    );
  }
}

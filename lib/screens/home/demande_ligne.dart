import 'package:colocexam/Dao/database.dart';
import 'package:colocexam/models/demande.dart';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/screens/home/demande_single.dart';
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
    final GlobalKey _menuKey = new GlobalKey();
    final usersData = Provider.of<User>(context);
    String choix;
    String _userphone = '';

    void handlePopUpChanged(String value, String phone) async {
      choix = value;
      if (choix == 'voir details') {
        _userphone = phone;
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Demandesingle(demande: widget.demande, phone: _userphone)));
      } else if (choix == 'supprimer') {
        if (usersData.uid == widget.demande.nuid) {
          await DatabaseService().deleteDemande(widget.demande.nuid);
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("vous ne pouvez pas supprimer cette demande"),
          ));
        }
      } else {

      }

      /// Log the selected lucky number to the console.

    }

    List<String> menuitems = ['voir details', 'supprimer'];
    List<PopupMenuItem> luckyNumbers = [];
    for (String item in menuitems) {
      luckyNumbers.add(
          new PopupMenuItem(
            child: new Text("$item"),
            value: item,
          )
      );
    }


    UserDocument mydocument = ServiceDb.currentUser;
    return Padding(

      padding: EdgeInsets.only(top: 4.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(

            title: Text(widget.demande.cordonnees),
            subtitle: Text(
                'Demande : ${widget.demande.commentaire} \nBudger Max : ${widget
                    .demande.budgesmax} Dh/mois '),
            trailing: new PopupMenuButton(
              key: _menuKey,
              onSelected: (selectedDropDownItem) =>
                  handlePopUpChanged(
                      selectedDropDownItem, mydocument.telephone),
              itemBuilder: (BuildContext context) => luckyNumbers,
              tooltip: "cliquer pour selectionner une action.",
            ),

            /// trailing: Icon(Icons.more_vert),
            onTap: () {

            },
          )
      ),
    );
  }
}


import 'package:colocexam/models/demande.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Demandesingle extends StatefulWidget {
  final Demande demande;
  final String phone;
  const Demandesingle({this.demande,this.phone});
  @override
  _DemandesingleState createState() => _DemandesingleState();
}

class _DemandesingleState extends State<Demandesingle> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title : Text("demande")
      ),
      resizeToAvoidBottomPadding: false,
      body:  SingleChildScrollView(
        child :Column(
          children: <Widget>[

            new Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Cordonnees :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.demande.cordonnees,
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Budger max :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.demande.budgesmax.toString() + " Dh/mois",
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Commentaire :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.demande.commentaire,
                    ),
                    enabled: false,
                  ),
                  RaisedButton(

                    color: Colors.redAccent[200],
                    child: Text('Contacter',
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),

                    onPressed: (){
                      launch("tel:"+widget.phone);
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

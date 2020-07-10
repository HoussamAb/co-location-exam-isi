import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/local.dart';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/screens/home/annonce_single.dart';
import 'package:colocexam/screens/map/mapMarkerManager.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/cupertino.dart';
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
    String _userphone = '';

    final List<String> imgList = [
      widget.annonce.images1,
      widget.annonce.images2,
      widget.annonce.images3
      ];

    void handlePopUpChanged(String value,String phone) async {
      choix =  value;
      if(choix == 'voir details'){
        _userphone = phone;
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnnonceSingle(annonce: widget.annonce,phone: _userphone)));
      }else if(choix == 'voir sur map'){
        dynamic position = widget.annonce.position.split(',');
        Monument monument = new Monument();
        monument.name = widget.annonce.title;
        monument.imagePath = Base64Decoder().convert(widget.annonce.images1);
        //print(double.parse(position[2]));
        monument.lat = double.parse(position[0]);
        monument.long = double.parse(position[1]);



        Navigator.push(context, MaterialPageRoute(builder: (context) => MarkerManager(monument: monument,)));
      }else{

      }
      /// Log the selected lucky number to the console.

    }

    List<String> menuitems = ['voir sur map','voir details'];
    List<PopupMenuItem> luckyNumbers = [];
    for (String item in menuitems) {
      luckyNumbers.add(
          new PopupMenuItem(
            child: new Text("$item"),
            value: item,
          )
      );
    }



    return StreamBuilder<UserDocument>(
        stream: DatabaseService(uid: usersData.uid).userDocument,
        builder:(context,snapshot) {
          UserDocument mydocument = snapshot.data;
          return  Padding (
              padding: EdgeInsets.only(top: 4.0),
              child: Card(
                  margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                  child: ListTile(

                      leading: SizedBox(
                        height: 300.0,
                        width: 50.0, // fixed width and height
                        child:
                          CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          autoPlayAnimationDuration: Duration(seconds: 2),
                        ),
                        items: imgList.map((item) => Container(
                          child: new Image.memory(Base64Decoder().convert(item),),
                          width: 100,
                          height: 100,

                        )).toList(),
                      ),
                      ),
                      title: Text(widget.annonce.title),
                      subtitle: Text('Details\t :\t ${widget.annonce.details} \nSupérfécie\t :\t ${widget.annonce.details} \nCapacité\t :\t ${widget.annonce.capacity} Personne(s) \nPrix\t :\t ${widget.annonce.prix} Dh/mois') ,
                       trailing: new PopupMenuButton(
                         key: _menuKey,
                         onSelected: (selectedDropDownItem) => handlePopUpChanged(selectedDropDownItem,mydocument.telephone),
                         itemBuilder: (BuildContext context) => luckyNumbers,
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
            /*Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                      ),
                      items: imgList.map((item) => Container(
                        child: new Image.memory(Base64Decoder().convert(widget.annonce.images)),
                      )).toList(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0.0, 2.0, 0.0),
                      child: Column(
                          children: <Widget>[
                            Text(widget.annonce.title,style: TextStyle(fontSize: 15.0)),
                            SizedBox(height: 10.0,),
                            Text(widget.annonce.details, textAlign: TextAlign.left, textDirection: TextDirection.ltr,),
                            SizedBox(height: 10.0,),
                            Text(widget.annonce.superficie, textAlign: TextAlign.left, textDirection: TextDirection.ltr,),
                            SizedBox(height: 10.0,),
                            Text(widget.annonce.address, textAlign: TextAlign.left, textDirection: TextDirection.ltr,),
                            SizedBox(height: 10.0,),


                          ],
                      )

                      */
            /*child: Annonce(
                        title: widget.annonce.title,
                        details: widget.annonce.details,
                        author: "",
                        superficie: widget.annonce.superficie,

                        publishDate: publishDate,
                        readDuration: readDuration,
                      ),
                    ),*/
            /*
                  ),
                  ),
                ],
              ),
            ),
          );*/



import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/local.dart';
import 'package:colocexam/screens/map/mapMarkerManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class AnnonceSingle extends StatefulWidget {
  final Annonce annonce;
  final String phone;
  const AnnonceSingle({this.annonce,this.phone});



  @override
  _AnnonceSingleState createState() => _AnnonceSingleState();
}

class _AnnonceSingleState extends State<AnnonceSingle> {


  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      widget.annonce.images1,
      widget.annonce.images2,
      widget.annonce.images3];

    return Scaffold(
      appBar: AppBar(
          title : Text(widget.annonce.title)
      ),
      resizeToAvoidBottomPadding: false,
      body:  SingleChildScrollView(
        child :Column(
         children: <Widget>[
          new CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlayAnimationDuration: Duration(seconds: 2),
              height: 200,
            ),
            items: imgList.map((item) => Container(
             child: new Image.memory(Base64Decoder().convert(item)),
          )).toList(),
        ),
          new Divider(),
          Padding(
            padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Supérficie :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.superficie + " m²",
                      ),
                        enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Capacité :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.capacity.toString() + " Personne(s)",
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('détails :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.details,
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Adresse :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.address,
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('rate :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.rate.toString(),
                      icon: Icon(Icons.star)
                    ),
                    enabled: false,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: new Text('Prix :', style: TextStyle(fontSize: 12.0, ),textAlign: TextAlign.left,)),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.annonce.prix.toString() + " Dh/mois",
                    ),
                    enabled: false,
                  ),
                  new Divider(),
                  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        RaisedButton(

                            color: Colors.blue[200],
                            child: Text('Localiser',
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),

                            onPressed: (){
                              dynamic position = widget.annonce.position.split(',');
                              Monument monument = new Monument();
                              monument.name = widget.annonce.title;
                              monument.imagePath = Base64Decoder().convert(widget.annonce.images1);
                              //print(double.parse(position[2]));
                              monument.lat = double.parse(position[0]);
                              monument.long = double.parse(position[1]);



                              Navigator.push(context, MaterialPageRoute(builder: (context) => MarkerManager(monument: monument,)));

                            },
                        ),

                        RaisedButton(

                          color: Colors.green[200],
                          child: Text('Contacter',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),

                          onPressed: (){
                            launch("tel:"+widget.phone);
                          },
                        ),
                            RaisedButton(

                          color: Colors.orange[200],
                          child: Text('itinéraire',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),

                          onPressed: (){
                            dynamic position = widget.annonce.position.split(',');
                            launch("https://maps.google.com/?q=" + position[0].toString() + "," + position[1].toString());
                          },
                        ),
                      ],
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

import 'dart:convert';
import 'dart:io';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/partages/constantes.dart';
import 'package:colocexam/partages/loading.dart';
import 'package:colocexam/screens/map/mapMarkerManager.dart';
import 'package:colocexam/services/authService.dart';
import 'package:colocexam/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class AnnonceForm extends StatefulWidget {
  @override
  _AnnonceFormState createState() => _AnnonceFormState();
}

class _AnnonceFormState extends State<AnnonceForm> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String _images1;
  String _images2;
  String _images3;
  String _title;
  int _prix;
  String _details;
  bool _stat;
  int _rate;
  String _address;
  int _capacity;
  String _superficie;
  String _position;

  File _image1;
  File _image2;
  File _image3;
  final picker = ImagePicker();

  Future getImage(int i) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (i == 1){
        _image1 = File(pickedFile.path);
        List<int> imageBytes = _image1.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        _images1 = base64Image;

      }else if(i==2){
        _image2 = File(pickedFile.path);
        List<int> imageBytes = _image2.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        _images2 = base64Image;
      }else if(i==3){
        _image3 = File(pickedFile.path);
        List<int> imageBytes = _image3.readAsBytesSync();
        String base64Image = base64Encode(imageBytes);
        _images3 = base64Image;
      }
    });
  }

  Geolocator geolocator = Geolocator();
  MapController controller = new MapController();
  bool _isGettingLocation;
  double lat,lon;

  void getCurrentLocation() async {

    Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    try {
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
        _isGettingLocation = false;
      });
    } on PlatformException catch (e) {
      print(e);

    }
    print('Current location lat long ' + position.latitude.toString() + " , " + position.longitude.toString());

  }


  @override
  Widget build(BuildContext context) {
    final usersData = Provider.of<User>(context);


    return StreamBuilder<UserDocument>(
        stream: DatabaseService(uid: usersData.uid).userDocument,
        builder:(context,snapshot) {
          if(snapshot.hasData){
            UserDocument mydocument = snapshot.data;
            return Scaffold(
              appBar:AppBar(
                title: Text('nouvelle annonce'),
                backgroundColor: Colors.grey,
                elevation: 0.0,
                actions: <Widget>[
                  FlatButton.icon(onPressed: () async{ await _authService.logout(); }, icon: Icon(Icons.exit_to_app), label: Text('logout')),
                ],
              ),
              resizeToAvoidBottomPadding: false,

              body : SingleChildScrollView(
                child : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'title' ),
                            validator: (val) => val.isEmpty ? 'title is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _title = val;
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'capacity' ),
                            validator: (val) => val.isEmpty  ? 'capacity is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _capacity = int.parse(val);
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'superficie' ),
                            validator: (val) => val.isEmpty  ? 'superficie is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _superficie = (val);
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'details' ),
                            validator: (val) => val.isEmpty  ? 'details is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _details = (val);
                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'address' ),
                            validator: (val) => val.isEmpty  ? 'address is emty' : null,
                            onChanged: (val){

                              setState(() {
                                _address = (val);

                              });
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'enter position(lat,lon)' ),
                            onChanged: (val){

                              setState(() {
                                _position = (val);

                              });
                            },
                          ),
                          RaisedButton(
                            child: Text('or click to Get current position'),
                            onPressed: (){
                              getCurrentLocation();
                              setState(() {
                                _position = lat.toString()+","+lon.toString();

                              });;
                            },
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            decoration: textFormDecor.copyWith(hintText: 'prix' ),
                            validator: (val) => val.isEmpty  ? 'prix is emty' : null,
                            onChanged: (val){
                              setState(() {
                                _prix = int.parse(val);
                              });
                            },
                          ),
                          SizedBox(height: 10.0,width: 0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                              RaisedButton(

                                child: Text(' image 1'),
                                onPressed: (){
                                  getImage(1);

                                },
                              ),

                              SizedBox(height: 10.0,),
                              RaisedButton(
                                child: Text(' image 2'),
                                onPressed: (){
                                  getImage(2);
                                },
                              ),
                              SizedBox(height: 10.0,),
                              RaisedButton(
                                child: Text(' image 3'),
                                onPressed: (){
                                  getImage(3);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          RaisedButton.icon(onPressed: () async {
                            if(_formkey.currentState.validate()) {
                              await DatabaseService(uid: usersData.uid).createAnnonce(
                                  _title ?? '',
                                  _images1 ?? '',
                                  _images2 ?? '',
                                  _images3 ?? '',
                                  _position ?? '',
                                  _details ?? '',
                                  _prix ?? 0,
                                  _rate ?? 0,
                                  _stat ?? true,
                                  _superficie ?? 0,
                                  _address ?? 0,
                                  _capacity ?? 0,
                                  usersData.uid);
                              Navigator.pop(context);
                            }
                            //
                            }, label: Text('Envoyer') ,icon: Icon(Icons.send,textDirection: TextDirection.ltr,), color: Colors.orange[100], padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),)
                        ],
                      ),
                    ),
                ),
              ),
            );
          }else {
            return Loading();
          }
        }
    );
  }
}

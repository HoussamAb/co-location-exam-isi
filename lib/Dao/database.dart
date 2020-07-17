import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/demande.dart';
import 'package:colocexam/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ServiceDb {
  final String uid;
  ServiceDb({this.uid});
  Dio dio = Dio();

  bool stat = false;
  static UserDocument currentUser;
  static List<Annonce> annonces ;
  static List<Demande> demandes ;

  StreamController<UserDocument> userController;
  StreamController<User> loginuser;


  String api = "http://studentcoloc.herokuapp.com/";


  Future test() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(api+'api/demandes');
    print(response.data.toString());
  }


  Future updateUserData (String username, String email, String telephone) async {
    return await dio.post(
        api+"/auth/update" ,
        data: {
          "username": username,
          "email": email,
          "telephone":telephone
        });
  }

  /////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////

  Future signInWithEmailAndPassword(String email,String password) async {
    try{
      FormData formData = new FormData.fromMap({
        "email": email,
        "password": password,
      });
      Response result =  await dio.post( api+"api/auth/login", data:formData,options: Options(contentType:Headers.formUrlEncodedContentType ));
      AllAnnonce();
      AllDemande();
      return _getuserfromrequest(result);
    }catch(ex){
      print(ex);
      return null;
    }
  }

  UserDocument _getuserfromrequest(Response response){
    print(response);
    dynamic json =  jsonDecode(response.toString());
    if(json.toString() == '{}'){
      return null;
    }else{
      stat = true;
      currentUser = UserDocument(
        uid:json['id'].toString(),
        email:json['email'],
        telephone:json['telephone'],
        username:json['username'],
      );
      loginuser.add(User(uid:currentUser.uid));
      _thisuser(currentUser);
      return currentUser;
    }

  }
  Stream<UserDocument> get userDocument {
    if(_stilllogedin()){
      final UserDocument myuser = currentUser;
      print(myuser.uid);
      return user.map((event) => myuser);
    }
    return null;
  }

  Future registerWithEmailAndPassword(String email,String password,String username) async {
    try{
      FormData formData = new FormData.fromMap({
        "username": username,
        "email": email,
        "password":password
      });
      Response result =  await dio.post( api+"api/auth/register",data:formData,options: Options(contentType:Headers.formUrlEncodedContentType ));
      print(result.toString());
      signInWithEmailAndPassword(email,password);
      return _getuserfromrequest(result);
    }catch(ex){
      print(ex);
      return null;

    }
  }

  User _thisuser(UserDocument user){
    return user != null ? User(uid: user.uid) : null;
  }


  bool _stilllogedin(){
    if(stat==true){
      return true;
    }
    return false;
  }

  loadDetails() {
    print('here1');
    if(_stilllogedin()==false){
      print(currentUser);
      final UserDocument myuser = currentUser;
      print(myuser);
      userController.add(myuser);
      print('here2');
      return myuser;
    }
    return null;
  }

  Stream<User> get user{
    if(_stilllogedin()){
      final User myuser = User(uid:currentUser.uid);
      print(myuser.uid);
      return user.map((event) => myuser);
    }
    return null;
  }

  bool ValidOrNo(Response response){
    print(response.toString());
    return true;
  }
  ///////////////////////////////////////////////////////////////////////////////////

  // Managing offers
  Future createAnnonce(String title, String images1 ,String images2 ,String images3 , String position , String details, int prix , int rate , bool stat, String superficie ,String address, int capacity,  String nuid) async {
    try{
      FormData formData = new FormData.fromMap({
        'title': title,
        'images1': images1,
        'images2': images2,
        'images3': images3,
        'position':position,
        'details':details,
        'prix':prix,
        'rate':rate,
        'stat': stat,
        'address':address,
        'capacity':capacity,
        'superfice':superficie,
        'user_id': nuid,
      });
      Response result =  await dio.post( api+"api/annonce", data:formData,options: Options(contentType:Headers.formUrlEncodedContentType ));
      return ValidOrNo(result);
    }catch(ex){
      print(ex);
      return null;
    }

  }
  // delete offers
  Future deleteAnnonce (String id) async {
    return await dio.get(api+"api/annonce/"+id);
  }

  Future AllAnnonce () async {
    dynamic allannonces = await dio.get(api+"api/annonces");
    final json =  jsonDecode(allannonces.toString());
    final items = (json['data'] as List).map((i) => new Annonce.fromJson(i));
    annonces = items.toList();
    print(annonces.length);
    return annonces;
  }
  // get the list of offers of user
  Stream<List<Annonce>> get usersAnnonce {
    AllAnnonce();
    return Stream.value(annonces);
  }
  // convert data to list of offers

// end managing offers

/////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////

  // Managing offers
  Future createDemande(String cordonnees, String commentaire ,int budgesmax ,String nuid) async {
    try{
      FormData formData = new FormData.fromMap({
        'cordonnees': cordonnees,
        'bdgesmax': budgesmax,
        'commentaire':commentaire,
        'user_id': nuid,
      });
      Response result =  await dio.post( api+"api/demande", data:formData,options: Options(contentType:Headers.formUrlEncodedContentType ));
      return ValidOrNo(result);
    }catch(ex){
      print(ex);
      return null;
    }

  }
  // delete offers
  Future deleteDemande (String id) async {
    return await dio.get(api+"api/demande/"+id);
  }

  Future  AllDemande() async {
    dynamic alldemandes = await dio.get(api+"api/demandes");
    final json =  jsonDecode(alldemandes.toString());
    final items = (json['data'] as List).map((i) => new Demande.fromJson(i));
    demandes =  items.toList();
    print(demandes.length);
    return demandes;
  }
  // get the list of offers of user
  Stream<List<Demande>> get usersDemande  {
    AllDemande();
    return  Stream.value(demandes);
  }
  // convert data to list of offers




  /*List<Demande> mapDemande(demande){
    print(demande[0]);
   // return (parsed[]["categoryList"] as List).map<Demande>((json) =>
   // new Photo.fromJson(json)).toList();

  }*/

// end managing offers

/////////////////////////////////////////////////////////////////////////////////////////
}
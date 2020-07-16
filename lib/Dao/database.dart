import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/demande.dart';
import 'package:colocexam/models/user.dart';
import 'package:dio/dio.dart';

class ServiceDb {
  final String uid;
  ServiceDb({this.uid});
  Dio dio = Dio();

  bool stat = false;
  static UserDocument currentUser;
  static List<Annonce> annonces = null;
  static List<Demande> demandes = null;

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
        'superficie':superficie,
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
    return await dio.get("api/annonce/"+id);
  }

  Future AllAnnonce () async {
    dynamic allannonces = await dio.get("api/annonces");
    annonces = mapAnnonce(allannonces);
    return annonces;
  }
  // get the list of offers of user
  Stream<List<Annonce>> get usersAnnonce {
    return Stream.value(annonces);
  }
  // convert data to list of offers
  List<Annonce> mapAnnonce(dynamic annonce){
    return annonce((e) {
      return Annonce(
        title: e['title'] ?? '',
        images1: e['images1'] ?? '',
        images2: e['images2'] ?? '',
        images3: e['images3'] ?? '',
        stat: e['stat'] ?? '',
        rate: e['rate'] ?? '',
        position: e['position'] ?? '',
        details: e['details'] ?? '',
        prix: e['prix'] ?? '',
        address: e['address'] ?? '',
        capacity: e['capacity'] ?? '',
        superficie: e['superficie'] ?? '',
        nuid: e['nuid'] ?? '',
      );
    }).toList();
  }
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
    return await dio.get("api/demande/"+id);
  }

  Future  AllDemande() async {
    Response alldemandes = await dio.get(api+"api/demandes");
    dynamic json =  jsonDecode(alldemandes.toString());
    alldemandes = json['data'];
    print(alldemandes);
    demandes = mapDemande(alldemandes);
    print(demandes);
    return demandes;
  }
  // get the list of offers of user
  Stream<List<Demande>> get usersDemande {
    AllDemande();
    return Stream.value(demandes);
  }
  // convert data to list of offers
  /*List<Demande> mapDemande(dynamic demande){
    dynamic d = jsonDecode(demande);
    print(d[0].toString());
    return d((e) {
      return Demande(
        cordonnees: e['cordonnees'] ?? '',
        budgesmax: e['budgesmax'] ?? '',
        commentaire: e['commentaire'] ?? '',
        nuid: e['nuid'] ?? '',
      );
    }).toList();
  }*/
  List<Demande> mapDemande(demande){
    final parsed = json.decode(demande.toString());
    print(parsed.toString());
   // return (parsed[]["categoryList"] as List).map<Demande>((json) =>
   // new Photo.fromJson(json)).toList();

  }

// end managing offers

/////////////////////////////////////////////////////////////////////////////////////////
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colocexam/models/annonce.dart';
import 'package:colocexam/models/demande.dart';
import 'package:colocexam/models/user.dart';
import 'package:colocexam/models/userData.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  var db = Firestore.instance;

  //collections refferences
  final CollectionReference annoncesCollection = Firestore.instance.collection('annonces');
  final CollectionReference demandeCollection = Firestore.instance.collection('demandes');
  final CollectionReference usersCollection = Firestore.instance.collection('users');


  Future updateUserData (String username, String email, String telephone) async {
    return await usersCollection.document(uid).setData({
      'username': username,
      'email':email,
      'telephone':telephone,
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////

  // Managing offers
  Future createAnnonce(String title, String images1 ,String images2 ,String images3 , String position , String details, int prix , int rate , bool stat, String superficie ,String address, int capacity,  String nuid) async {
    return await annoncesCollection.add({
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
      'nuid': nuid,
    });
  }
  // delete offers
  Future deleteAnnonce (String id) async {
    return await annoncesCollection.where("nuid", isEqualTo: id).getDocuments().then((snapshot){
      snapshot.documents.first.reference.delete();
    });
  }
  // get the list of offers of user
  Stream<List<Annonce>> get usersAnnonce {
    return annoncesCollection.snapshots()
        .map(convertSnapshotToAnnonce);
  }
  // convert data to list of offers
  List<Annonce> convertSnapshotToAnnonce(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return Annonce(
        title: e.data['title'] ?? '',
        images1: e.data['images1'] ?? '',
        images2: e.data['images2'] ?? '',
        images3: e.data['images3'] ?? '',
        stat: e.data['stat'] ?? '',
        rate: e.data['rate'] ?? '',
        position: e.data['position'] ?? '',
        details: e.data['details'] ?? '',
        prix: e.data['prix'] ?? '',
        address: e.data['address'] ?? '',
        capacity: e.data['capacity'] ?? '',
        superficie: e.data['superficie'] ?? '',
        nuid: e.data['nuid'] ?? '',
      );
    }).toList();
  }
  // end managing offers

  /////////////////////////////////////////////////////////////////////////////////////////

  // Managing demandes
  Future createDemande(String cordonnees, String commentaire ,int budgesmax ,String nuid) async {
    return await demandeCollection.add({
      'cordonnees': cordonnees,
      'budgesmax': budgesmax,
      'commentaire':commentaire,
      'nuid': nuid,
    });
  }
  // delete demandes
  Future deleteDemande (String id) async {
    return await demandeCollection.where("nuid", isEqualTo: id).getDocuments().then((snapshot){
      snapshot.documents.first.reference.delete();
    });
  }
  // get the list of offers of user
  Stream<List<Demande>> get usersDemande {
    return demandeCollection.snapshots()
        .map(convertSnapshotToDemande);
  }
  // convert data to list of demandes
  List<Demande> convertSnapshotToDemande(QuerySnapshot snapshot){
    return snapshot.documents.map((e) {
      return Demande(
        cordonnees: e.data['cordonnees'] ?? '',
        budgesmax: e.data['budgesmax'] ?? '',
        commentaire: e.data['commentaire'] ?? '',
        nuid: e.data['nuid'] ?? '',
      );
    }).toList();
  }
  // end managing demandes

  ////////////////////////////////////////////////////////////////////////////////////

  // list of the data of all user
  Stream<List<UserData>> get usersData {
    return usersCollection.snapshots()
        .map(convertSnapShotsToUserDara);
  }

  List<UserData> convertSnapShotsToUserDara(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        username: doc.data['username'] ?? '',
        telephone: doc.data['telephone'] ?? '',
        email: doc.data['email'] ?? '',
      );
    }).toList();
  }

  // current user data
  Stream<UserDocument> get userDocument {
    return usersCollection.document(uid).snapshots()
        .map(_userDocument);
  }

  UserDocument _userDocument(DocumentSnapshot documentSnapshot){
    return UserDocument(
      uid:uid,
      email:documentSnapshot.data['email'],
      telephone:documentSnapshot.data['telephone'],
      username:documentSnapshot.data['username'],
    );
  }
}

  ////////////////////////////////////////////////////////////////////////////////////////



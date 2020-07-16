import 'package:colocexam/Dao/database.dart';
import 'package:colocexam/screens/home/annonce_form.dart';
import 'package:colocexam/screens/home/demande_form.dart';
import 'package:colocexam/screens/home/list_annonce.dart';
import 'package:colocexam/screens/home/list_demande.dart';
import 'package:colocexam/screens/home/profile.dart';
import 'package:colocexam/screens/map/index.dart';
import 'package:colocexam/screens/map/mapMarkerManager.dart';
import 'package:colocexam/services/authService.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _authService = AuthService();
  final ServiceDb service = ServiceDb();


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Annonces'),
          backgroundColor: Colors.blueGrey[100],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon( icon:Icon(Icons.person), label: Text('profile'), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},),
            FlatButton.icon( icon: Icon(Icons.exit_to_app), label: Text('logout') , onPressed: (){ _authService.logout();},),
          ],
        ),
        drawer: new Drawer(
            child: new ListView(
              children: <Widget> [
                new DrawerHeader(
                  child:  new Text('Header'),
                ),
                FlatButton.icon( icon: Icon(Icons.map), label: Text('Maps') , onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => IndexMap()));},),
                new Divider(),
                new ListTile(
                  title: new Text('profile'),
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('Crée une demande'),
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => DemandeForm()));},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('Crée une annonce'),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AnnonceForm()));},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('Liste des demandes'),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ListDemds()));},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('Liste des annonces'),
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => home()));},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('Logout'),
                  onTap: () async {  await _authService.logout();},
                ),
                new Divider(),
                new ListTile(
                  title: new Text('About'),
                  onTap: () {},
                ),
                new Divider(),

              ],
            )
        ),

        body: Container(

          child:ListAnnoonce(),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //service.test();
            //service.signInWithEmailAndPassword("houssam@gmail.com", "12345678");
            Navigator.push(context, MaterialPageRoute(builder: (context) => AnnonceForm()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightGreen[200],
        ),
      ),
    );
  }
}

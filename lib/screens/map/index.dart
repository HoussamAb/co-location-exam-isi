import 'package:colocexam/screens/home/profile.dart';
import 'package:colocexam/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';


class IndexMap extends StatefulWidget {
  IndexMap({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _IndexMapState createState() => _IndexMapState();
}

class _IndexMapState extends State<IndexMap> {

  final AuthService _authService = AuthService();
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon( icon:Icon(Icons.person), label: Text('profile'), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},),
          FlatButton.icon( icon: Icon(Icons.exit_to_app), label: Text('logout') , onPressed: (){ _authService.logout();},),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          plugins: <MapPlugin>[PopupMarkerPlugin()],
          center: LatLng(48.857661, 2.295135),
          zoom: 13.0,
          interactive: true,
          onTap: (_) => _popupLayerController.hidePopup(),
        ),
        layers: <LayerOptions>[
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: <String>['a', 'b', 'c'],
          ),
          PopupMarkerLayerOptions(
            markers: <Marker>[
              MonumentMarker(
                monument: Monument(
                  name: 'Eiffel Tower',
                  imagePath:
                  'https://cdn.lifestyleasia.com/wp-content/uploads/2019/10/21224220/Winer-Parisienne.jpg',
                  lat: 48.857661,
                  long: 2.295135,
                ),
              ),
              Marker(
                anchorPos: AnchorPos.align(AnchorAlign.top),
                point: LatLng(48.859661, 2.305135),
                height: Monument.size,
                width: Monument.size,
                builder: (BuildContext ctx) => Icon(Icons.shop),
              ),
            ],
            popupController: _popupLayerController,
            popupBuilder: (_, Marker marker) {
              if (marker is MonumentMarker) {
                return MonumentMarkerPopup(monument: marker.monument);
              }
              return Card(child: const Text('Not a monument'));
            },
          ),
        ],
      ),
    );
  }
}

class Monument {
  static const double size = 25;

  Monument({this.name, this.imagePath, this.lat, this.long});

  final String name;
  final String imagePath;
  final double lat;
  final double long;
}

class MonumentMarker extends Marker {
  MonumentMarker({@required this.monument})
      : super(
    anchorPos: AnchorPos.align(AnchorAlign.top),
    height: Monument.size,
    width: Monument.size,
    point: LatLng(monument.lat, monument.long),
    builder: (BuildContext ctx) => Icon(Icons.camera_alt),
  );

  final Monument monument;
}

class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({Key key, this.monument}) : super(key: key);
  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(monument.imagePath, width: 200),
            Text(monument.name),
            Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}

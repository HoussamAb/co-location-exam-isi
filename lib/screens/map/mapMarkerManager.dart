import 'package:colocexam/models/local.dart';
import 'package:colocexam/screens/home/profile.dart';
import 'package:colocexam/screens/map/index.dart';
import 'package:colocexam/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';


class MarkerManager extends StatefulWidget {
  final String title;
  final Monument monument;
  MarkerManager({Key key, this.title , this.monument}) : super(key: key);

  @override
  _MarkerManagerState createState() => _MarkerManagerState();
}

class _MarkerManagerState extends State<MarkerManager> {

  final AuthService _authService = AuthService();
  final PopupController _popupLayerController = PopupController();
  final PopupController _popupController = PopupController();

  List<Marker> markers;
  int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.blueGrey[100],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon( icon:Icon(Icons.person), label: Text('profile'), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},),
          FlatButton.icon( icon: Icon(Icons.exit_to_app), label: Text('logout') , onPressed: () async { await _authService.logout();},),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          plugins: <MapPlugin>[PopupMarkerPlugin()],
          center: LatLng(widget.monument.lat, widget.monument.long),
          zoom: 15.0,
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
                  name: widget.monument.name,
                  imagePath: widget.monument.imagePath,
                  lat: widget.monument.lat,
                  long: widget.monument.long,
                ),
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




class MonumentMarker extends Marker {
  MonumentMarker({@required this.monument})
      : super(
    anchorPos: AnchorPos.align(AnchorAlign.top),
    height: Monument.size,
    width: Monument.size,
    point: LatLng(monument.lat, monument.long),
    builder: (BuildContext ctx) => Icon(Icons.room),
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
          Image.memory(monument.imagePath, width: 200),
            Text(monument.name),
            Text('${monument.lat}-${monument.long}'),
          ],
        ),
      ),
    );
  }
}


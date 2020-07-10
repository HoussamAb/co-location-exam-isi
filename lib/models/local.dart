import 'dart:typed_data';

class Monument {
  static const double size = 25;

  Monument({this.name, this.imagePath, this.lat, this.long});

   String name;
   Uint8List imagePath;
   double lat;
   double long;
}
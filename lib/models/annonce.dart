class Annonce{

  final String images1;
  final String images2;
  final String images3;
  final String title;
  final int prix;
  final String details;
  final bool stat;
  final int rate;
  final String address;
  final int capacity;
  final String superficie;
  final String position;
  final String nuid;

  Annonce({this.images1,this.images2,this.images3, this.title,this.position , this.prix,this.details,this.rate, this.stat, this.address,this.capacity,this.superficie, this.nuid});

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      title: json['title'] as String,
      images1: json['images1'] as String,
      images2: json['images2'] as String,
      images3: json['images3'] as String,
      details: json['details'] as String,
      address: json['address'] as String,
      superficie: json['superfice'].toString() as String,
      capacity: json['capacity'] as int,
      rate: json['rate'] as int,
      prix: json['prix'] as int,
      position: json['position'] as String,
      nuid: json['user_id'].toString() as String,
      stat: true,
    );
  }
}
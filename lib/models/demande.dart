class Demande{

  final String cordonnees;
  final int budgesmax;
  final String commentaire;
  final String nuid;

  Demande({this.cordonnees, this.budgesmax, this.commentaire, this.nuid});

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      cordonnees: json['cordonnees'] as String,
      budgesmax: json['bdgesmax'] as int,
      commentaire: json['commentaire'] as String,
      nuid: json['nuid'] as String,
    );
  }

}
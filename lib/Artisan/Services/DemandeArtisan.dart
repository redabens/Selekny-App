import 'package:cloud_firestore/cloud_firestore.dart';
class DemandeArtisan{
  final String datedebut;
  final String heuredebut;
  final String adresse;
  final String iddomaine;
  final String idprestation;
  final String idclient;
  final bool urgence;
  final double latitude;
  final double longitude;
  final Timestamp timestamp;
  DemandeArtisan({
  required this.datedebut,
  required this.heuredebut,
  required this.adresse,
  required this.iddomaine,
  required this.idprestation,
  required this.idclient,
  required this.urgence,
  required this.latitude,
  required this.longitude,
  required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'datedebut': datedebut,
      'heuredebut': heuredebut,
      'adresse': adresse,
      'iddomaine':iddomaine,
      'idprestation': idprestation,
      'idclient': idclient,
      'urgence': urgence,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
    };
  }
}

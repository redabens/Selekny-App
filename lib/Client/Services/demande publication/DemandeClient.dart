import 'package:cloud_firestore/cloud_firestore.dart';
class DemandeClient{
  final String datedebut;
  final String datefin;
  final String heuredebut;
  final String heurefin;
  final String adresse;
  final String iddomaine;
  final String idprestation;
  final String idclient;
  final String idartisan;
  final bool urgence;
  final double latitude;
  final double longitude;
  final Timestamp timestamp;

  DemandeClient({
    required this.datedebut,
    required this.datefin,
    required this.heuredebut,
    required this.heurefin,
    required this.adresse,
    required this.iddomaine,
    required this.idprestation,
    required this.idclient,
    required this.idartisan,
    required this.urgence,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'datedebut': datedebut,
      'datefin': datefin,
      'heuredebut': heuredebut,
      'heurefin': heurefin,
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

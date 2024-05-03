import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/Services/demande%20publication/Historique.dart';
import 'package:flutter/material.dart';
class HistoriqueService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendHistorique(String datedebut,
      String datefin,
      String heuredebut,
      String heurefin,
      String adresse,
      String iddomaine,
      String idprestation,
      String idclient,
      String idartisan,
      bool urgence,
      double latitude,
      double longitude,) async {
    Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    dateTime= dateTime.subtract(const Duration(hours: 1));
    timestamp = Timestamp.fromDate(dateTime);

    Historique newHistorique = Historique(
      datedebut: datedebut,
      datefin: datefin,
      heuredebut: heuredebut,
      heurefin: heurefin,
      adresse: adresse,
      iddomaine: iddomaine,
      idprestation: idprestation,
      idclient: idclient,
      idartisan: idartisan,
      urgence: urgence,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(idclient)
        .collection('Historique')
        .add(newHistorique.toMap());

    return Future.value(null);
  }

  Future<void> deleteHistorique(String demandeID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Historique').doc(demandeID).delete();
      print('demande $demandeID supprimé avec succes');
    } catch (e) {
      print('Erreur lors de la suppression la demande encours $e');
    }
    return Future.value(null);
  }
}
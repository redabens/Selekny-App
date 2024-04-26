import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Services/DemandeArtisan.dart';

class DemandeArtisanService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendDemandeArtisan(String datedebut,
  String heuredebut,
  String adresse,
  String iddomaine,
  String idprestation,
  String idclient,
  bool urgence,
  double latitude,
  double longitude,String recieverId)async{
    final Timestamp timestamp = Timestamp.now();

    DemandeArtisan newDemandeArtisan = DemandeArtisan(
        datedebut: datedebut,
        heuredebut: heuredebut,
        adresse: adresse,
        iddomaine : iddomaine,
        idprestation: idprestation,
        idclient: idclient,
        urgence: urgence,
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp);
    await _firestore
        .collection('users')
        .doc(recieverId)
        .collection('DemandeArtisan')
        .add(newDemandeArtisan.toMap());

    return Future.value(null);

  }

  Stream<QuerySnapshot> getDemandeArtisan(String artisanId){

    return _firestore
        .collection('users')
        .doc(artisanId).collection('DemandeArtisan')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }
}
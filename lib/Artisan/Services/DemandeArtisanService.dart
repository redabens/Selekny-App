import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Services/DemandeArtisan.dart';

class DemandeArtisanService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendDemandeArtisan(String datedebut,
  String datefin,
  String heuredebut,
  String heurefin,
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
        datefin: datefin,
        heuredebut: heuredebut,
        heurefin: heurefin,
        adresse: adresse,
        iddomaine : iddomaine,
        idprestation: idprestation,
        idclient: idclient,
        urgence: urgence,
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp,
        );
    await _firestore
        .collection('users')
        .doc(recieverId)
        .collection('DemandeArtisan')
        .add(newDemandeArtisan.toMap());

    return Future.value(null);

  }
  Future<void> sendRendezVous(String datedebut,
      String datefin,
      String heuredebut,
      String heurefin,
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
        datefin: datefin,
        heuredebut: heuredebut,
        heurefin: heurefin,
        adresse: adresse,
        iddomaine : iddomaine,
        idprestation: idprestation,
        idclient: idclient,
        urgence: urgence,
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp,);
    await _firestore
        .collection('users')
        .doc(recieverId)
        .collection('RendezVous')
        .add(newDemandeArtisan.toMap());

    return Future.value(null);

  }
  Future<void> deleteDemandeArtisan(Timestamp timestamp,String recieverId)async {
    final firestore = FirebaseFirestore.instance;

    // Get the subcollection reference
    CollectionReference<Map<String, dynamic>> subcollectionRef =
    firestore.collection('users').doc(recieverId).collection('DemandeArtisan');

    // Construct the timestamp query
    Query<Map<String, dynamic>> timestampQuery =
    subcollectionRef.where('timestamp', isEqualTo: timestamp);

    // Perform the delete operation
    timestampQuery.get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((documentSnapshot) {
          print('${documentSnapshot.data()}');
          documentSnapshot.reference.delete();
        });
      }
    });
    print('delete avec success art');
    return Future.value(null);
  }
  Stream<QuerySnapshot> getDemandeArtisan(String artisanId){

    return _firestore
        .collection('users')
        .doc(artisanId).collection('DemandeArtisan')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }
  Stream<QuerySnapshot> getRendezVous(String artisanId){

    return _firestore
        .collection('users')
        .doc(artisanId).collection('RendezVous')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }
  Future<void> deleteRendezVous(Timestamp timestamp,String recieverId)async {
    final firestore = FirebaseFirestore.instance;

    // Get the subcollection reference
    CollectionReference<Map<String, dynamic>> subcollectionRef =
    firestore.collection('users').doc(recieverId).collection('RendezVous');

    // Construct the timestamp query
    Query<Map<String, dynamic>> timestampQuery =
    subcollectionRef.where('timestamp', isEqualTo: timestamp);

    // Perform the delete operation
    timestampQuery.get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((documentSnapshot) {
          print('${documentSnapshot.data()}');
          documentSnapshot.reference.delete();
        });
      }
    });
    print('delete avec success art');
    return Future.value(null);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeClient.dart';

class DemandeClientService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendDemandeClient(String datedebut,
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
      double longitude)async{
    final Timestamp timestamp = Timestamp.now();

    DemandeClient newDemandeClient = DemandeClient(
        datedebut: datedebut,
        heuredebut: heuredebut,
        adresse: adresse,
        iddomaine : iddomaine,
        idprestation: idprestation,
        idclient: idclient,
        idartisan: idartisan,
        urgence: urgence,
        latitude: latitude,
        longitude: longitude,
        timestamp: timestamp,
        datefin: datefin,
        heurefin: heurefin,);
    await _firestore
        .collection('users')
        .doc(idclient)
        .collection('DemandeClient')
        .add(newDemandeClient.toMap());

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
      String idartisan,
      bool urgence,
      double latitude,
      double longitude,)async{
    final Timestamp timestamp = Timestamp.now();

    DemandeClient newDemandeClient = DemandeClient(
      datedebut: datedebut,
      datefin: datefin,
      heuredebut: heuredebut,
      heurefin: heurefin,
      adresse: adresse,
      iddomaine : iddomaine,
      idprestation: idprestation,
      idclient: idclient,
      idartisan: idartisan,
      urgence: urgence,
      latitude: latitude,
      longitude: longitude,
      timestamp: timestamp,);
    await _firestore
        .collection('users')
        .doc(idclient)
        .collection('RendezVous')
        .add(newDemandeClient.toMap());

    return Future.value(null);

  }
  Future<void> deleteDemandeClient(Timestamp timestamp,String recieverId)async {
    final firestore = FirebaseFirestore.instance;

    // Get the subcollection reference
    CollectionReference<Map<String, dynamic>> subcollectionRef =
    firestore.collection('users').doc(recieverId).collection('DemandeClient');

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
    print('delete avec success cli');
    return Future.value(null);
  }
  Stream<QuerySnapshot> getDemandeClient(String clientId){

    return _firestore
        .collection('users')
        .doc(clientId).collection('DemandeClient')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }
  Stream<QuerySnapshot> getRendezVous(String clientId){

    return _firestore
        .collection('users')
        .doc(clientId).collection('RendezVous')
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
    print('delete avec success cli');
    return Future.value(null);
  }
}
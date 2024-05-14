
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Services/demande%20publication/Rendezvous.dart';

class RendezVousService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      double longitude,String artisanId, String recieverId)async{
    Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    dateTime= dateTime.subtract(const Duration(hours: 1));
    timestamp = Timestamp.fromDate(dateTime);

    RendezVous newDemandeArtisan = RendezVous(
      datedebut: datedebut,
      datefin: datefin,
      heuredebut: heuredebut,
      heurefin: heurefin,
      adresse: adresse,
      iddomaine : iddomaine,
      idprestation: idprestation,
      idclient: idclient,
      idartisan: artisanId,
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
  Future<void> deleteRendezVousID(String demandid)async {
    final firestore = FirebaseFirestore.instance;

    // Get the subcollection reference
    final subcollectionRef =
    firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('RendezVous').doc(demandid);

    // Perform the delete operation
    subcollectionRef.get().then((querySnapshot) {
      if (querySnapshot.exists) {
        querySnapshot.reference.delete();
      }
    });
    print('delete avec success art');
    return Future.value(null);
  }
}

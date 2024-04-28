import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DemandeEncoursService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDemandesEnCours() {
    final String currentUserId =  _firebaseAuth.currentUser!.uid;
//'IiRyRcvHOzgjrRX8GgD4M5kAEiJ3';
    return FirebaseFirestore.instance
        .collection('Demandes')
        .orderBy('timestamp', descending: true)
        .where('id_Client', isEqualTo: currentUserId)
        .snapshots();
  }
  Future<void> deleteDemande(Timestamp timestamp)async {
    final firestore = FirebaseFirestore.instance;

    // Get the subcollection reference
    CollectionReference<Map<String, dynamic>> subcollectionRef =
    firestore.collection('Demandes');

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
      else{
        print('deja suprimmer ou bien n''existe pas');
      }
    });
    print('delete avec success Demande');
    return Future.value(null);
  }
}
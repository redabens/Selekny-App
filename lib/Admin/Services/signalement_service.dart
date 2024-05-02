import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignalementsService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendSignalement(String raison,String signlantId,String userId) async {
    CollectionReference signalements = _firestore.collection(
        'Signalements');

    if (userId != '') {
      final Timestamp timestamp = Timestamp.now();
      await signalements.add({
        'id_signaleur': userId,
        'id_signalant': signlantId,
        'timestamp': timestamp,
        'raison': raison,
      });
      print('signalement effectue');
    } else {
      print('User is not authenticated');
    }
   await Future.value(null);
  }

  Stream<QuerySnapshot> getAllSignalements() {
    return _firestore
        .collection('Signalements')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }

  Future<void> deleteSignalement(String signalementID) async {
    try {
      final DocumentReference signalementRef =
      _firestore.collection('Signalements').doc(signalementID);
      final DocumentSnapshot signalementDoc = await signalementRef.get();
      if (signalementDoc.exists) {
        await signalementRef.delete();
        print('!!!!!!!!!!!!! Signalement avec ID $signalementID supprimé avec succès.');
      } else {
        print('!!!!!!!!!!!!!! Le signalement avec ID $signalementID n\'existe pas.');
      }
    } catch (e) {
      print('!!!!!!!!!! Erreur lors de la suppression du signalement $signalementID: $e');
    }
  }
}
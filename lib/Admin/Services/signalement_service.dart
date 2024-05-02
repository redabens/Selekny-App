import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignalementsService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

<<<<<<< HEAD
  Future<void> sendSignalement(String signlantId, String raison) async {
    CollectionReference signalements = _firestore.collection(
        'Signalements');
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      final String userId = 'CRC4DVGi7HM73WwS8gdM9DC3lah1';//user.uid;
=======
  Future<void> sendSignalement(String raison,String signlantId,String userId) async {
    CollectionReference signalements = _firestore.collection(
        'Signalements');

    if (userId != '') {
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
      final Timestamp timestamp = Timestamp.now();
      await signalements.add({
        'id_signaleur': userId,
        'id_signalant': signlantId,
        'timestamp': timestamp,
        'raison': raison,
      });
<<<<<<< HEAD
      print('ffffffffff signalement effectue');
=======
      print('signalement effectue');
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
    } else {
      print('User is not authenticated');
    }
   await Future.value(null);
  }

  Stream<QuerySnapshot> getAllSignalements() {
    return _firestore
        .collection('Signalements')
<<<<<<< HEAD
        .orderBy('timestamp')
=======
        .orderBy('timestamp',descending: true)
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
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
<<<<<<< HEAD
        print('!!!!!!!!! Le signalement avec ID $signalementID n\'existe pas.');
=======
        print('!!!!!!!!!!!!!! Le signalement avec ID $signalementID n\'existe pas.');
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
      }
    } catch (e) {
      print('!!!!!!!!!! Erreur lors de la suppression du signalement $signalementID: $e');
    }
  }
}
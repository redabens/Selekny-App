import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DemandeEncoursService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDemandesEnCours() {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
//'IiRyRcvHOzgjrRX8GgD4M5kAEiJ3';
    return FirebaseFirestore.instance
        .collection('Demandes')
        .orderBy('timestamp', descending: true)
        .where('id_Client', isEqualTo: currentUserId)
        .snapshots();
  }

  Future<void> deleteDemande(String demandeID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Demandes').doc(demandeID).delete();
      print('demande $demandeID supprimé avec succes');
    } catch (e) {
      print('Erreur lors de la suppression la demande encours $e');
    }
    return Future.value(null);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DomainesService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getDomaines() {
    return _firestore
        .collection('Domaine')
        .snapshots();
  }
  Stream<QuerySnapshot> getPrestations(String domaineId) {
    return _firestore
        .collection('Domaine')
        .doc(domaineId)
        .collection('Prestations')
        .snapshots();
  }
}
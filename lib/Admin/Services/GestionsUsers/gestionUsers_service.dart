import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GestionUsersService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return _firestore.collection('users').snapshots();
  }

  Stream<QuerySnapshot> getAllArtisans() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'artisan')
        .snapshots();
  }

  Stream<QuerySnapshot> getAllClients() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'client')
        .snapshots();
  }
}

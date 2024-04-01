import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PrestationsService extends ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Stream<QuerySnapshot> getPrestations(String domainId){

    return _firestore
        .collection('Artisans')
        .doc(domainId).collection('Commentaires')
        .orderBy('timestamp',descending: true)
        .snapshots();
  }
}
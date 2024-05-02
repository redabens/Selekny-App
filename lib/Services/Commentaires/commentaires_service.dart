import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'commentaire.dart';

  class CommentaireService extends ChangeNotifier{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> sendCommentaire(String recieverId,String comment, int starRating)async{
      final currentUserId=_firebaseAuth.currentUser!.uid;
      final DateTime now = DateTime.now();
      final Timestamp timestamp = Timestamp.fromDate(now);

      Commentaire newCommentaire = Commentaire(
          userID: currentUserId,
          starRating: starRating,
          comment: comment,
          timestamp: timestamp,
      );
      await _firestore
          .collection('users')
          .doc(recieverId)
          .collection('Commentaires')
          .add(newCommentaire.toMap());
      print('commentaires envoyee');
      return Future.value(null);
    }

    Stream<QuerySnapshot> getCommentaires(String artisanId){

      return _firestore
          .collection('users')
          .doc(artisanId).collection('Commentaires')
          .orderBy('timestamp',descending: true)
          .snapshots();
    }
  }
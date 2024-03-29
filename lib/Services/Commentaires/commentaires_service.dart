import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'commentaire.dart';

  class CommentaireService extends ChangeNotifier{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> sendCommentaire(String recieverId,String comment, int starRating)async{
      final currentUserId = "eOILQzRtIQlxwCGKhFMy";
      final Timestamp timestamp = Timestamp.now();

      Commentaire newCommentaire = Commentaire(
          userID: currentUserId,
          starRating: starRating,
          comment: comment,
          timestamp: timestamp,
      );
      await _firestore
          .collection('Artisans')
          .doc(recieverId)
          .collection('Commentaires')
          .add(newCommentaire.toMap());

      return Future.value(null);

    }

    Stream<QuerySnapshot> getCommentaires(String ArtisanId){

      return _firestore
          .collection('Artisans')
          .doc(ArtisanId).collection('Commentaires')
          .orderBy('timestamp',descending: true)
          .snapshots();
    }
  }
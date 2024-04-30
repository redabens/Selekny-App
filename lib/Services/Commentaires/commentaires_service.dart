import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'commentaire.dart';

  class CommentaireService extends ChangeNotifier{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> sendCommentaire(String recieverId,String comment, int starRating)async{
      final currentUserId=_firebaseAuth.currentUser!.uid;
      final Timestamp timestamp = Timestamp.now();

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

      return Future.value(null);

    }

    Stream<QuerySnapshot> getCommentaires(String artisanId){
      return _firestore
          .collection('users')
          .doc(artisanId).collection('Commentaires')
          .orderBy('timestamp',descending: true)
          .snapshots();
    }

    Future<void> updateRating(String artisanID, int ratingClient) async {
      try {
        // Reference to the artisan document
        DocumentReference artisanRef = _firestore.collection('users').doc(artisanID);

        // Transaction to ensure atomicity of the read-modify-write cycle
        return _firestore.runTransaction<void>((transaction) async {
          DocumentSnapshot artisanSnapshot = await transaction.get(artisanRef);

          if (!artisanSnapshot.exists) {
            throw Exception("Artisan with ID $artisanID not found");
          }

          // Explicit casting of the data to Map<String, dynamic>
          var data = artisanSnapshot.data() as Map<String, dynamic>;
          double currentRating = (data['rating'] as num?)?.toDouble() ?? 0.0;
          int nbRating = (data['nbRating'] as num?)?.toInt() ?? 0;
          double newRating = (currentRating * nbRating + ratingClient) / (nbRating + 1);

          // Updating the document within the transaction
          transaction.update(artisanRef, {
            'rating': newRating,
            'nbRating': FieldValue.increment(1),
          });
        });
      } catch (e) {
        print("Error updating artisan rating: $e");
      }
    }


  }

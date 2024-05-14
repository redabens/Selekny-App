import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class ChatListService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /*Stream<QuerySnapshot> getConversations(String currentUserId) {
    // Combine multiple where conditions with '||' (OR)
    return _firestore
        .collection('Conversations')
        .where('user1', isEqualTo: currentUserId)
        .orWhere('user2', isEqualTo: currentUserId) // Add 'orWhere'
        .snapshots();
  }*/
  /*Stream<QuerySnapshot> getConversations(String currentUserId) {
    print("snapshots received §§§§§§");
    final Stream<QuerySnapshot> user1Stream = _firestore
        .collection('Conversations')
        .where('user1', isEqualTo: currentUserId)
    //.orderBy('timestamp', descending: false)
        .snapshots();
    final Stream<QuerySnapshot> user2Stream = _firestore
        .collection('Conversations')
        .where('user2', isEqualTo: currentUserId)
    // .orderBy('timestamp', descending: false)
        .snapshots();
    //return user2Stream.mergeWith([user1Stream]);
    return Rx.merge([user2Stream,user1Stream]);

  }*/
  Stream<List<QueryDocumentSnapshot>> getConversations(String currentUserId) {
    print("snapshots received §§§§§§");

    final Stream<QuerySnapshot> user1Stream = _firestore
        .collection('Conversations')
        .where('user1', isEqualTo: currentUserId)
        .snapshots();

    final Stream<QuerySnapshot> user2Stream = _firestore
        .collection('Conversations')
        .where('user2', isEqualTo: currentUserId)
        .snapshots();

    return Rx.combineLatest2(
      user1Stream,
      user2Stream,
          (QuerySnapshot user1Snapshot, QuerySnapshot user2Snapshot) {
        final List<QueryDocumentSnapshot> mergedSnapshots = [];
        mergedSnapshots.addAll(user1Snapshot.docs);
        mergedSnapshots.addAll(user2Snapshot.docs);

        mergedSnapshots.sort((a, b) {
          Timestamp timestampA = a['timestamp'];
          Timestamp timestampB = b['timestamp'];
          return timestampB.compareTo(timestampA); // Descending order by timestamp
        });

        return mergedSnapshots;
      },
    );
  }
/* Stream<QuerySnapshot> getConversations(String currentUserId) {
    // Construct a query to get relevant conversations
    final conversationsRef = _firestore
        .collection('Conversations')
        .where((document) => document['id'].split('_').contains(currentUserId));

    // Return stream of conversation snapshots
    return conversationsRef.snapshots();
  }*/
}
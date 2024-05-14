
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class ChatListService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


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
          return timestampB.compareTo(timestampA);
        });

        return mergedSnapshots;
      },
    );
  }
}

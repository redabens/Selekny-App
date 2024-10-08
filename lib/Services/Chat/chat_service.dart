
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'message.dart'; // Assuming this defines the Message class

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message
  Future<void> sendMessage(String recieverId, String message) async {
    User? user = _firebaseAuth.currentUser;
    String currentUserEmail = user?.email ?? "";
    final querySnapshot1 = await _firestore
        .collection('users')
        .where('email', isEqualTo: currentUserEmail)
        .limit(1)
        .get();
    String currentUserId = querySnapshot1.docs[0].id;

    final DateTime now = DateTime.now();
    final Timestamp timestamp = Timestamp.fromDate(now);

    // Create new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      timestamp: timestamp,
      message: message,
    );

    // Construct chat room ID sorted
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore.collection('Conversations').doc(chatRoomId).set({
      'user1': currentUserId,
      'user2': recieverId,
      'timestamp': timestamp,
    }, SetOptions(merge: true)); // Merge to avoid overwriting messages

    // Add new message to DB
    await _firestore
        .collection('Conversations')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
    notifyListeners(); // Call notify after successful operations
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('Conversations')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void notifyMessageSent() {
    notifyListeners();
  }
}

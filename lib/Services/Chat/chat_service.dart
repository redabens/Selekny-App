import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send a message
  Future<void> sendMessage(String recieverId,String message)async{
    //current user info
    final currentUser = FirebaseAuth.instance.currentUser;

    final currentUserId ='hskvyxfATXnpgG8vsZlc';
    final String currentUserEmail = 'mm_bensemane@esi.dz';
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message (
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      recieverId: recieverId,
      timestamp: timestamp,
      message: message,
    );

    //construire chat room id sorted
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add new message to DB
    await _firestore
        .collection('Conversations')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());

    return Future.value(null);
  }

  Stream<QuerySnapshot> getMessages(String userId,  String otherUserId){
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId =  ids.join("_");

    return _firestore
        .collection('Conversations')
        .doc(chatRoomId).collection('messages')
        .orderBy('timestamp',descending: false)
        .snapshots();
  }

}
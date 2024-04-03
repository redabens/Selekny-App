//this is a model for one element in the list of conversations
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatListElement{
  final String user1;
  final String user2;

  ChatListElement({
    required this.user1,
    required this.user2,
  });

  Map<String, dynamic> toMap(){
    return{
      'user1':user1,
      'user2':user2,
    };
  }

}
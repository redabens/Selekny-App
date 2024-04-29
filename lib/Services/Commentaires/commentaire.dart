import 'package:cloud_firestore/cloud_firestore.dart';
class Commentaire{
  final String userID;
  final int starRating;
  final String comment;
  final Timestamp timestamp;

  Commentaire({
    required this.userID,
    required this.starRating,
    required this.comment,
    required this.timestamp,
  });

  Map<String, dynamic> toMap(){
    return{
      'userID':userID,
      'starRating':starRating,
      'comment':comment,
      'timestamp':timestamp,
    };
  }

}
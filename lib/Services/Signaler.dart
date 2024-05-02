import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class SignalerService extends ChangeNotifier {
  Future<void> Signaler(String TextArea, String Id_a_signaler,
      String Id_qui_signale) async {
    try {
      //acces a la collection signalement
      CollectionReference Signalement = FirebaseFirestore.instance
          .collection('Signalements');
      Timestamp timestamp = Timestamp.now();
      return await Signalement.add({
        'User_id': Id_qui_signale,
        'User_a_signaler_id': Id_a_signaler,
        'TextArea': TextArea,
        'timestamp': timestamp,
      }).then((value) => print('Signaler avec Succés'))
          .catchError((error) =>
          print("erreur lors de l'ajout du Signalement: $error"));
    } catch (e) {
      print("Erreur lors du Signalement : $e");
    }
  }
}
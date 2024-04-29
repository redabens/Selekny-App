import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> Signaler(String TextArea,String nomASignaler,String prenomASignaler) async{
  try{
    //id_de l'utilisateur qui signale
    User? user = FirebaseAuth.instance.currentUser;
    String email = user?.email ?? "";
    final querySnapshot1 = await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    String userId = querySnapshot1.docs[0].id;
    //id_a_signaler
    final querySnapshot2 = await FirebaseFirestore.instance
        .collection('User')
        .where('Nom', isEqualTo: nomASignaler)
        .where('Prenom', isEqualTo: prenomASignaler)
        .limit(1)
        .get();
    String userASignalerId = querySnapshot2.docs[0].id;
    //acces a la collection signalement
    CollectionReference Signalement = FirebaseFirestore.instance
        .collection('Signalement');
    return await Signalement.add({
      'User_id':userId,
      'User_a_signaler_id':userASignalerId,
      'TextArea': TextArea
    }).then((value) => print('Signaler avec Succés'))
      .catchError((error) => print("erreur lors de l'ajout du Signalement: $error"));
  } catch(e){
    print("Erreur lors du Signalement : $e");
  }
}
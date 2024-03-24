import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> Signaler(String TextArea,String Nom_a_signaler,String Prenom_a_Signaler) async{
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
        .where('Nom', isEqualTo: Nom_a_signaler)
        .where('Prenom', isEqualTo: Prenom_a_Signaler)
        .limit(1)
        .get();
    String user_a_signaler_id = querySnapshot2.docs[0].id;
    //acces a la collection signalement
    CollectionReference Signalement = await FirebaseFirestore.instance
        .collection('Signalement');
    return await Signalement.add({
      'User_id':userId,
      'User_a_signaler_id':user_a_signaler_id,
      'TextArea': TextArea
    }).then((value) => print('Signaler avec Succés'))
      .catchError((error) => print("erreur lors de l'ajout du Signalement: $error"));
  } catch(e){
    print("Erreur lors du Signalement : $e");
  }
}
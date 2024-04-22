import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'getMateriel.dart';

Future <void> publierDemandeinit(String prestationId,bool urgent,
    String datededebut, String datedefin, String heurededebut, String heuredefin) async{
  CollectionReference demande = await FirebaseFirestore.instance.collection('Demandes');
  /*User? user = FirebaseAuth.instance.currentUser;
  String email = user?.email ?? "";
  final querySnapshot1 = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  String userId = querySnapshot1.docs[0].id;*/
  //List<bool> etat = [true,false,false,false,false,false,false,false];
  await demande.add({
    'id_Client': "",
    'id_Artisan': "",
    'id_Prestation': prestationId,
    'urgence': urgent,
    'date_debut':datededebut,
    'date_fin': datedefin,
    'heure_debut':heurededebut,
    'heure_fin':heuredefin,
    'longitude': 3.1991359,
    'latitude': 36.7199646,
    //'etat':etat
  });
}
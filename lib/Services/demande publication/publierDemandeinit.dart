import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'getMateriel.dart';

Future <void> publierDemandeinit(String domaine,String prestation ,bool Urgent,
    String datededebut, String datedefin, String heurededebut, String heuredefin,List<bool> etat) async{
  CollectionReference Demande = await FirebaseFirestore.instance.collection('Demandes');
  User? user = FirebaseAuth.instance.currentUser;
  String email = user?.email ?? "";
  final querySnapshot1 = await FirebaseFirestore.instance
      .collection('User')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  String userId = querySnapshot1.docs[0].id;
  String prestationId = await getPrestationId(domaine, prestation);
  await Demande.add({
    'id_Client': userId,
    'id_Artisan': "",
    'id_Prestation': prestationId,
    'urgence': Urgent,
    'date_debut':datededebut,
    'date_fin': datedefin,
    'heure_debut':heurededebut,
    'heure_fin':heuredefin,
    'etat':etat
  });
}
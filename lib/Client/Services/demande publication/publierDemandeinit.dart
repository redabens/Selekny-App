import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future <void> publierDemandeinit(String domaineId,String prestationId,bool urgent,
    String datededebut, String datedefin, String heurededebut, String heuredefin) async{
  CollectionReference demande = FirebaseFirestore.instance.collection('Demandes');
  User? user = FirebaseAuth.instance.currentUser;
  String email = user?.email ?? "";
  final querySnapshot1 = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
  String userId = querySnapshot1.docs[0].id;
  final double longitude = querySnapshot1.docs[0].data()['longitude'];
  final double latitude = querySnapshot1.docs[0].data()['latitude'];
  final String adresse = querySnapshot1.docs[0].data()['adresse'];
  final Timestamp timestamp = Timestamp.now();
  await demande.add({
    'adresse':adresse,
    'id_Client': userId,
    'id_Domaine':domaineId,
    'id_Prestation': prestationId,
    'urgence': urgent,
    'date_debut':datededebut,
    'date_fin': datedefin,
    'heure_debut':heurededebut,
    'heure_fin':heuredefin,
    'longitude': longitude,
    'latitude': latitude,
    'timestamp':timestamp,
  });
}
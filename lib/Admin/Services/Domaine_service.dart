import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DomainesService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getDomaines() {
    return _firestore
        .collection('Domaine')
        .snapshots();
  }
  Stream<QuerySnapshot> getPrestations(String domaineId) {
    return _firestore
        .collection('Domaine')
        .doc(domaineId)
        .collection('Prestations')
        .snapshots();
  }
  Future<void> ajouterDomaine(String nomdomaine,String imagepath) async {
    Map<String, dynamic> domaine = {'Nom': nomdomaine, 'Image': imagepath};
    await FirebaseFirestore.instance.collection("Domaine").add(domaine);
    await Future.value(null);
  }
  Future<void> ajouterPrestation(String nomPrestation,int prixmax,int prixmin,String unite,String materiel,String imagepath,String domaineid) async {

    Map<String, dynamic> prestation = {
      'image': imagepath,
      'nom_prestation': nomPrestation,
      'prixmax': prixmax,
      'prixmin': prixmin,
      'unite': unite,
      'materiel': materiel
    };
    // await FirebaseFirestore.instance.collection("Domaine").add(prestation);

    await FirebaseFirestore.instance
        .collection('Domaine')
        .doc(domaineid)
        .collection('Prestations')
        .add(prestation);
  }
}
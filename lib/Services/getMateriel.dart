import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/firebase_options.dart';

Future<String> getMateriel(String domaine, String prestation) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Domaine')
        .where('Nom', isEqualTo: domaine)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String domaineId = querySnapshot.docs[0].id;
      final prestationsSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(domaineId)
          .collection('Prestations')
          .where('nom_prestation', isEqualTo: prestation)
          .limit(1)
          .get();
      String prestationId = prestationsSnapshot.docs[0].id;
      print(prestationId);
      if (prestationsSnapshot.docs.isNotEmpty) {
        var materiel = prestationsSnapshot.docs[0].data()['materiel'] as String?;
        print('ici');
        return materiel ?? ''; // Retourne la valeur de 'materiel' ou une chaîne vide si 'materiel' est null
      } else {
        print('here');
        return ''; // Aucun document trouvé dans la sous-collection 'Prestations' pour la prestation spécifiée
      }
    } else {
      print('las-bas');
      return ''; // Aucun document trouvé dans la collection 'Domaine' pour le domaine spécifié
    }
  } catch (e) {
    print("Erreur lors de la recherche de matériel : $e");
    return ''; // Retourne une chaîne vide en cas d'erreur
  }
}
Future<String> getPrix(String domaine, String prestation) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Domaine')
        .where('Nom', isEqualTo: domaine)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String domaineId = querySnapshot.docs[0].id;
      final prestationsSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(domaineId)
          .collection('Prestations')
          .where('nom_prestation', isEqualTo: prestation)
          .limit(1)
          .get();
      String prestationId = prestationsSnapshot.docs[0].id;
      print(prestationId);
      if (prestationsSnapshot.docs.isNotEmpty) {
        var materiel = prestationsSnapshot.docs[0].data()['prix'] as String?;
        print('ici');
        return materiel ?? ''; // Retourne la valeur de 'prix' ou une chaîne vide si 'prix' est null
      } else {
        print('here');
        return ''; // Aucun document trouvé dans la sous-collection 'Prestations' pour la prestation spécifiée
      }
    } else {
      print('las-bas');
      return ''; // Aucun document trouvé dans la collection 'Domaine' pour le domaine spécifié
    }
  } catch (e) {
    print("Erreur lors de la recherche de matériel : $e");
    return ''; // Retourne une chaîne vide en cas d'erreur
  }
}
Future<String> getPrestationId(String domaine, String prestation) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Domaine')
        .where('Nom', isEqualTo: domaine)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String domaineId = querySnapshot.docs[0].id;
      final prestationsSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(domaineId)
          .collection('Prestations')
          .where('nom_prestation', isEqualTo: prestation)
          .limit(1)
          .get();
      String prestationId = prestationsSnapshot.docs[0].id;
      return prestationId;
    } else {
      print('las-bas');
      return ''; // Aucun document trouvé dans la collection 'Domaine' pour le domaine spécifié
    }
  } catch (e) {
    print("Erreur lors de la recherche de matériel : $e");
    return ''; // Retourne une chaîne vide en cas d'erreur
  }
}
Future<List<String>> getPrestations(String domaine) async{
  try {
    List<String> listeprestations = [];
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Domaine')
        .where('Nom', isEqualTo: domaine)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String domaineId = querySnapshot.docs[0].id;
      final prestationsSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(domaineId)
          .collection('Prestations')
          .get();
      prestationsSnapshot.docs.forEach((doc) {
        listeprestations.add(doc['nom_prestation']);
      });
    } else {
      print('las-bas');
       // Aucun document trouvé dans la collection 'Prestations' pour le domaine spécifié
    }
    return listeprestations;
  } catch (e) {
    print("Erreur lors de la recherche de Prestations : $e");
    return []; // Retourne une chaîne vide en cas d'erreur
  }
}
// code test
/*
// Get the materiel for a specific prestation in a specific domain
  String materiel = await getMateriel('Nettoyage','Ponçage carrelage');
  // Print the materiel
  print(materiel);
// get liste Prestation
List<String> listeprestations = await getPrestations('Nettoyage');
  print(listeprestations);
*/
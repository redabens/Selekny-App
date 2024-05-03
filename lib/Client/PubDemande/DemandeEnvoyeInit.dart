import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/components/Demande.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Services/notifications.dart';
late String nomPrestation;

Future<void> getNomPrestationById(String idDomaine, String idPrestation) async {
  try {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Domaine').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      if (doc.id == idDomaine && doc.exists) {
        QuerySnapshot prestationsSnapshot =
        await doc.reference.collection('Prestations').get();

        prestationsSnapshot.docs.forEach((prestationDoc) async {
          if (prestationDoc.id == idPrestation && prestationDoc.exists) {
            nomPrestation = prestationDoc['nom_prestation'];
          }
        });
      }
    }
  } catch (e) {
    print("Erreur lors de la récupération des prestations: $e");
  }
}
double radians(double degrees) => degrees * pi / 180;
double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371.01; // Rayon de la Terre en km

  double dLat = radians(lat2 - lat1);
  double dLon = radians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(lat1)) * cos(radians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance en km
}
class DemandeEnvoye extends StatefulWidget {
  final String prestationID;
  final String domaineId;
  final Demande demande;
  const DemandeEnvoye({
    super.key,
    required this.prestationID,
    required this.domaineId,
    required this.demande,
  });

  @override
  DemandeEnvoyeState createState() => DemandeEnvoyeState();
}
class DemandeEnvoyeState extends State<DemandeEnvoye> {
  final db = FirebaseFirestore.instance;
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
  bool empty = false; // Consider using a Stream to handle emptiness dynamically

  @override
  void initState() {
    super.initState();
    _checkArtisansForLatestDemande();
  }
  Future<void> _checkArtisansForLatestDemande() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final demandecol = FirebaseFirestore.instance.collection('Demandes');
    final demandeDoc = await demandecol.where('checked',isEqualTo: false).orderBy('timestamp', descending: true).get();
    if (demandeDoc.docs.isEmpty) {
      // Handle empty list scenario (optional: show a message to the user)
      print('Aucune demande en attente');
      return;
    }
    final demandeData = demandeDoc.docs.first;
    final demandeLat = demandeData['latitude'];
    final demandeLong = demandeData['longitude'];
    String domainenom = '';
    // Filtrer les artisans à proximité
    final artisansInRange = <DocumentSnapshot>[];
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(demandeData['id_Domaine'])
          .get();
      if (documentSnapshot.exists) {
        domainenom = documentSnapshot.data()?['Nom'];
      } else {
        print('Aucun document trouvé dans la collection');
        domainenom = '';
        // Aucun document trouvé dans la collection 'Prestations' pour le domaine spécifié
      }
    } catch (e) {
      print("Erreur lors de la recherche de nom domaine : $e"); // Retourne une chaîne vide en cas d'erreur
    }
    final artisansRef = db.collection('users').where('role',isEqualTo: 'artisan');

    await artisansRef.get().then((QuerySnapshot artisansSnapshot) async {
      if(artisansSnapshot.docs.isEmpty){
        print('Votre Demande n''a trouver aucun artisan');
      }
      for (int i=0;i< artisansSnapshot.docs.length;i++) {
        final artisanData = artisansSnapshot.docs[i].data() as Map<String, dynamic>;
        final artisanLat = artisanData['latitude'];
        final artisanLong = artisanData['longitude'];
        final artisanDomaine = artisanData['domaine'];
        if( artisanDomaine == domainenom){
          final distance = haversineDistance(demandeLat, demandeLong, artisanLat, artisanLong);
          if (distance <= 30.0) {
            print(artisansSnapshot.docs[i].id);
            _demandeArtisanService.sendDemandeArtisan(demandeData['date_debut'], demandeData['date_fin'],
                demandeData['heure_debut'], demandeData['heure_fin'],
                demandeData['adresse'], demandeData['id_Domaine'],
                demandeData['id_Prestation'], demandeData['id_Client'],
                demandeData['urgence'], demandeData['latitude'],
                demandeData['longitude'], artisansSnapshot.docs[i].id,demandeData.id); String typeService;
            if (demandeData['urgence']) {
              typeService = "(urgent)";
            } else {
              typeService = "(non urgent)";
            }
            String token = await UserRepository.instance
                .getTokenById(artisansSnapshot.docs[i].id);

            print("Token de l'artisan $i : $token");

            await getNomPrestationById(
            demandeData['id_Domaine'], demandeData['id_Prestation']);

            print("Voici le service publie : $nomPrestation");
            NotificationServices.sendPushNotification(
                token, "Offre d'un service $typeService", nomPrestation);
          }
        }
      }
    });
    // Update the 'checked' value for the latest request after processing artisans
    await demandecol.doc(demandeData.id).update({'checked': true});
    print('success');
    await Future.value(null);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/envoye.png', // corrected asset name
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Votre demande a été envoyée',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'Veuillez patienter pendant que nous trouvons .',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
            const Text(
              'un artisan disponible pour vous',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Retour à l\'accueil',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
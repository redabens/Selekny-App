import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/NotifDemande.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/Services/demande%20publication/publierDemandeinit.dart';
import 'package:reda/Client/components/Demande.dart';

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
  late DocumentSnapshot? latestDemande;
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
  late bool empty=false;

  @override
  void initState() {
    super.initState();
    _listenForDemandes(); // Start listening for new demands
  }

  void _listenForDemandes() {
    final demandeRef = db.collection('Demandes');
    demandeRef.snapshots().listen((querySnapshot) {
      if (querySnapshot.docChanges.isNotEmpty) {
        final addedDoc = querySnapshot.docChanges.firstWhere((change) => change.type == DocumentChangeType.added);
        if (addedDoc != null) {
          latestDemande = addedDoc.doc;
          _checkArtisansForLatestDemande();
        }
      }
    }, onError: (error) {
      // Handle errors appropriately, e.g., show a snackbar or log the error
      print("Error listening to demandes: $error");
    });
  }

  Future<void> _checkArtisansForLatestDemande() async {
    if (latestDemande == null) {
      return; // No latest demande yet, so skip processing
    }

    final demandeData = latestDemande!.data() as Map<String, dynamic>;
    final demandeLat = demandeData['latitude'];
    final demandeLong = demandeData['longitude'];

    // Filtrer les artisans à proximité
    final artisansInRange = <DocumentSnapshot>[];
    final artisansRef = db.collection('users').where('role',isEqualTo: 'artisan');

    await artisansRef.get().then((QuerySnapshot artisansSnapshot) {
      for (var artisanDoc in artisansSnapshot.docs) {
        final artisanData = artisanDoc.data() as Map<String, dynamic>;
        final artisanLat = artisanData['latitude'];
        final artisanLong = artisanData['longitude'];

        final distance = haversineDistance(demandeLat, demandeLong, artisanLat, artisanLong);
        if (distance <= 30.0) {
          print(artisanDoc.id);
          artisansInRange.add(artisanDoc);
        }
      }
    });
    if (artisansInRange.isNotEmpty){
      for(var artisanDoc in artisansInRange){
        _demandeArtisanService.sendDemandeArtisan(demandeData['date_debut'], demandeData['heure_debut'],
            demandeData['adresse'], demandeData['id_Domaine'], demandeData['id_Prestation'],
            demandeData['id_Client'], demandeData['urgence'], demandeData['latitude'],
            demandeData['longitude'], artisanDoc.id);
      }
    }
    else{
      empty=true;
    }
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
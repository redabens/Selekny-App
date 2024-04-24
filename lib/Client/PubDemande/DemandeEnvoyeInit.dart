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
  bool empty = false; // Consider using a Stream to handle emptiness dynamically

  @override
  void initState() {
    super.initState();
    _listenForDemandes(); // Start listening for new demands
  }

  void _listenForDemandes() async {
    // Stream subscription for more efficient handling
    final demandeStream = db.collection('Demandes').snapshots();
    final subscription = demandeStream.listen((querySnapshot) {
      
      print('here');
      if (querySnapshot.docChanges.isNotEmpty) {
        final addedDoc = querySnapshot.docChanges.firstWhere(
              (change) => change.type == DocumentChangeType.added,
        );
        if (addedDoc != null) {
          latestDemande = addedDoc.doc;
          _checkArtisansForLatestDemande();
        }
      }
    }, onError: (error) {
      // Handle errors appropriately, e.g., show a snackbar or log the error
      print("Error listening to demandes: $error");
    },);
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
      for (int i=0;i< artisansSnapshot.docs.length;i++) {
        final artisanData = artisansSnapshot.docs[i].data() as Map<String, dynamic>;
        final artisanLat = artisanData['latitude'];
        final artisanLong = artisanData['longitude'];

        final distance = haversineDistance(demandeLat, demandeLong, artisanLat, artisanLong);
        if (distance <= 30.0) {
          print(artisansSnapshot.docs[i].id);
          /*artisansInRange.add(artisansSnapshot.docs[i]);
        }
      }
    });
    if (artisansInRange.isNotEmpty){
      for(int i=0;i< artisansInRange.length;i++){*/
        _demandeArtisanService.sendDemandeArtisan(demandeData['date_debut'], demandeData['heure_debut'],
            demandeData['adresse'], demandeData['id_Domaine'], demandeData['id_Prestation'],
            demandeData['id_Client'], demandeData['urgence'], demandeData['latitude'],
            demandeData['longitude'], artisansSnapshot.docs[i].id);
      }
    }
    });
    print('success');
  }
  /*Future<void> _checkArtisansForLatestDemande() async {
    if (latestDemande == null) {
      return; // No latest demande yet, so skip processing
    }

    // Fetch latest demande data directly (avoid unnecessary .get())
    final demandeData = await latestDemande!.data() as Map<String, dynamic>;

    final demandeLat = demandeData['latitude'];
    final demandeLong = demandeData['longitude'];

    // Filter artisans in range
    final artisansInRange = <DocumentSnapshot>[];
    final artisansRef = db.collection('users').where('role', isEqualTo: 'artisan');

    await artisansRef.get().then((QuerySnapshot artisansSnapshot) {
      for (int i=0;i< artisansSnapshot.docs.length;i++) {
        final artisanData = artisansSnapshot.docs[i].data() as Map<String, dynamic>;
        final artisanLat = artisanData['latitude'];
        final artisanLong = artisanData['longitude'];

        final distance = haversineDistance(demandeLat, demandeLong, artisanLat, artisanLong);
        if (distance <= 30.0) {
          artisansInRange.add(artisansSnapshot.docs[i]);
        }
      }
    });
    for(int i=0;i< artisansInRange.length;i++){
      print(artisansInRange[i].id);
    }
    if (artisansInRange.isNotEmpty) {
      for (var artisanDoc in artisansInRange) {
        final artisanId = artisanDoc.id;
        final artisanRef = db.collection('users').doc(artisanId);
        final transaction = await db.runTransaction((transaction) async {
          final artisanDoc = await transaction.get(artisanRef);
          if (!artisanDoc.exists) {
            return; // Artisan document doesn't exist
          }

          final artisanData = artisanDoc.data() as Map<String, dynamic>;
          final notifiedArtisans = artisanData['notifiedDemandes'] ?? []; // Check for existing notifiedDemandes field

          if (notifiedArtisans.contains(demandeData['id'])) {
            return; // Artisan already notified for this demand (optimistic locking)
          }

          // Update artisan document to include notified demand ID
          transaction.update(artisanDoc.reference, {
            'notifiedDemandes': FieldValue.arrayUnion([demandeData['id']]),
          });

          // Send demand to artisan
          await _demandeArtisanService.sendDemandeArtisan(
              demandeData['date_debut'],
              demandeData['heure_debut'],
              demandeData['adresse'],
              demandeData['id_Domaine'],
              demandeData['id_Prestation'],
              demandeData['id_Client'],
              demandeData['urgence'],
              demandeLat,
              demandeLong,
              artisanId);
        });

        if (transaction != null) {
          print('Demande envoyée à l\'artisan $artisanId');
        } else {
          print('Échec de l\'envoi de la demande à l\'artisan $artisanId (conflit)');
        }
      }
    } else {
      print('Aucun artisan disponible dans la zone');
    }
  }*/

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
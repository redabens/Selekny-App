import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/Services/demande%20publication/Historique.dart';
import 'package:reda/Client/Services/demande%20publication/HistoriqueServices.dart';
import 'package:reda/Client/components/RendezVous_container.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Services/ModifPrix.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({
    super.key,
  });
  @override
  State<RendezVousPage> createState() => _RendezVousPageState();
}
class _RendezVousPageState extends State<RendezVousPage> {
  //---------------LES FONCTION GETTERS---------------------------------------------------
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DemandeClientService _DemandeAccepteeService = DemandeClientService();
  final HistoriqueService _historiqueService = HistoriqueService();
  final ModifPrixService _modifPrixService = ModifPrixService();

  // get le nom domaine de la demande acceptee
  Future<String> getDomaineDemande(String domaineID) async {
    final _firestore = FirebaseFirestore.instance;

    final domaineDoc = await _firestore.collection('Domaine').doc(domaineID).get();
    if (domaineDoc.exists) {
      final domainName = domaineDoc.data()!['Nom'];
      print(' Nom domaine : $domainName');
      return domainName;
    } else {
      return 'Domaine introuvable';
    }
  }

  //get nom prestation de la demande acceptee
  Future<String> getPrestationDemande(String domaineID,String PrestationID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try{
      DocumentSnapshot domaine = await firestore.collection('Domaine').doc(domaineID).get();
      if (!domaine.exists) {
        throw Exception("Domaine non trouvé");
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(PrestationID).get();
      if (!prestation.exists) {
        throw Exception("Prestation non trouvée");
      }
      Map<String,dynamic> data = prestation.data() as Map<String, dynamic>;
      print('bien');
      return data['nom_prestation'];
    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      return 'Erreur: $e';
    }
  }
  //get image user
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      String pathImage = userDoc['pathImage'];
      // Retourner le PathImage
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      try {
        // Get the download URL for the user image
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } catch (error) {
        print("Error fetching user image URL: $error");
        return ''; // Default image on error
      }
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return '';
    }
  }
  //-----------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // espace fo9 titre de la page
          const SizedBox(height: 20.0),
          AppBar(
            elevation: 0.0,
            // Remove default shadow
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(
              'Rendez-Vous',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 18),
          _buildTitleAndDescription(), // le petit texte du début
          const SizedBox(height: 10),
          const SizedBox(height: 2),
          Expanded(
            child: _buildRendezVousList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
      );
  }

  Widget _buildRendezVousList(){
    return StreamBuilder(
      stream: _DemandeAccepteeService.getRendezVous(_firebaseAuth.currentUser!.uid), //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        final documents = snapshot.data!.docs;

        // Print details of each document
        for (var doc in documents) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(snapshot.data!.docs.map((document) => _buildRendezVousItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading demandes encours:  ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                      'Vous n''avez aucun Rendez-vous.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    )
                )
              );
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  }

  Future<Widget> _buildRendezVousItem(DocumentSnapshot document) async {
    if (document.data() != null) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Extract values from the data map using null check operator
      String demandeID = document.id;
      String userID = _firebaseAuth.currentUser!.uid; // 'IiRyRcvHOzgjrRX8GgD4M5kAEiJ3';
      String domaineID = data['iddomaine']; // Handle null with an empty string
      String PrestationID = data['idprestation']; // Handle null with an empty string
      String artisanID = data['idartisan']; // Handle null with an empty string
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(artisanID).get();
      Map<String, dynamic> datas = userDoc.data() as Map<String, dynamic>;
      String domaine = await getDomaineDemande(domaineID);//'Plombrie';
      print(domaine);
      String prestation = await getPrestationDemande(domaineID, PrestationID);
      print(prestation);
      bool urgence = data['urgence']; // Handle null with a default value
      print(urgence);
      String date = data['datedebut']; // Handle null with an empty string
      String heure = '${data['heuredebut']} - ${data['heurefin']}'; // Handle null with empty strings
      String prix = await _modifPrixService.getPrixPrestation(domaineID, PrestationID); // Handle null with an empty string
      String location = data['adresse']; // Handle null with an empty string
      String imageUrl = await getUserPathImage(artisanID); // 'https://firebasestorage.googleapis.com/v0/b/selekny-app.appspot.com/o/Prestations%2FLPsJnqkVdXQUf6iBcXn0.png?alt=media&token=44ac0673-f427-43cf-9308-4b1213e73277';
      print(imageUrl);
      String nomArtisan = datas['nom']; // Handle null with an empty string
      double rating = datas['rating']; // Handle null with a default value
      bool vehicule = datas['vehicule']; // Handle null with a default value
      int workcount = datas['workcount']; // Handle null with a default value
      String adresseartisan = datas['adresse']; // Handle null with an empty string
      String phone = datas['numTel']; // Handle null with an empty string
      //----
      String datefin = data['datefin'];
      String heureDebut = data['heuredebut'];
      String heureFin = data['heurefin'];
      double latitude = data['latitude'];
      double longitude = data['longitude'];
      Timestamp timestamp = data['timestamp'];
      // ... rest of your code using the extracted values
      return RendezVousClient(
        domaine: domaine,
        location: location,
        date: date,
        heure: heure,
        prix: prix,
        prestation: prestation,
        imageUrl: imageUrl,
        nomArtisan: nomArtisan,
        rating: rating,
        phone: phone,
        urgence: urgence,
        datedebut: date,
        datefin: datefin,
        iddomaine: domaineID,
        idprestation: PrestationID,
        idclient: userID,
        heuredebut: heureDebut,
        heurefin: heureFin,
        latitude: latitude,
        longitude: longitude,
        idartisan: artisanID,
        timestamp: timestamp,
        adresseartisan: adresseartisan,
        workcount: workcount,
        vehicule: vehicule,
      );
    } else {
      // Handle the case where the document is null
      print('Error: Document is null for document ID: ${document.id}');
      return Center(
          child: Text(
              'Vous n''avez aucun Rendez-Vous.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              )
          )
      );; // or some placeholder widget
    }
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '• ',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text:
                  ' Vous pouvez ici consulter vos Rendez-Vous.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final DemandeClientService _DemandeAccepteeService = DemandeClientService();
  final ModifPrixService _modifPrixService = ModifPrixService();

  // get le nom domaine de la demande acceptee
  Future<String> getDomaineDemande(String domaineID) async {
    final firestore = FirebaseFirestore.instance;

    final domaineDoc = await firestore.collection('Domaine').doc(domaineID).get();
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
      String demandeID = document.id;
      String userID = _firebaseAuth.currentUser!.uid;
      String domaineID = data['iddomaine'];
      String PrestationID = data['idprestation'];
      String artisanID = data['idartisan'];
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(artisanID).get();
      Map<String, dynamic> datas = userDoc.data() as Map<String, dynamic>;
      String domaine = await getDomaineDemande(domaineID);//'Plombrie';
      String prestation = await getPrestationDemande(domaineID, PrestationID);
      bool urgence = data['urgence'];
      String date = data['datedebut'];
      String heure = '${data['heuredebut']} - ${data['heurefin']}';
      String prix = await _modifPrixService.getPrixPrestation(domaineID, PrestationID);
      String location = data['adresse'];
      String imageUrl = await getUserPathImage(artisanID);
      String nomArtisan = datas['nom'];
      double rating = datas['rating'];
      bool vehicule = datas['vehicule'];
      int workcount = datas['workcount'];
      String adresseartisan = datas['adresse'];
      String phone = datas['numTel'];
      //----
      String datefin = data['datefin'];
      String heureDebut = data['heuredebut'];
      String heureFin = data['heurefin'];
      double latitude = data['latitude'];
      double longitude = data['longitude'];
      Timestamp timestamp = data['timestamp'];
      return Column( // Wrap in a Column for vertical spacing
        children: [
        RendezVousClient(
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
      ),
          const SizedBox(height: 10), // Add spacing between containers
        ],
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
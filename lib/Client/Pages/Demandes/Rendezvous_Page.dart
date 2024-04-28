import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/components/RendezVous_container.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';
import 'package:google_fonts/google_fonts.dart';

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
      return prestation.get('nom_prestation');
    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      return 'Erreur: $e';
    }
  }

  //get prix demande
  Future<String> getPrixDemande(String domaineID,String PrestationID) async {
    try {
      DocumentSnapshot domaine = await _firestore.collection('Domaine').doc(domaineID).get();
      if (!domaine.exists) {
        throw Exception("Domaine non trouvé");
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(PrestationID).get();
      if (!prestation.exists) {
        throw Exception("Prestation non trouvée");
      }
      return prestation.get('prix');
    } catch (e) {
      print('Erreur lors de prix prestation: $e');
      return 'Erreur: $e';
    }
  }
  //get le nom de lartisan
  Future<String> getNameUser(String userID) async {
    final userDoc = await _firestore.collection('users').doc(userID).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String userName = userDoc.data()!['nom'] as String;
    return userName;
  }
//get phone number de l'artisan
  Future<String> getPhoneUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String phone = userDoc.data()!['numTel'] as String;
    return phone;
  }

  //get image user
  Future<String> getUserPathImage(String userID) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userID).get();
    if (userDoc.exists) {
      String pathImage = userDoc['pathImage'];
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      final url = await reference.getDownloadURL();
      return url;
    } else {
      return 'default_image_url';
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
              return ListView(children: snapshot.data!);
            });
      },
    );
  }

  Future<Widget> _buildRendezVousItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String demandeID = document.id;
    String userID = _firebaseAuth.currentUser!.uid;//'IiRyRcvHOzgjrRX8GgD4M5kAEiJ3';
    String domaineID = data['iddomaine'];
    String PrestationID = data['idprestation'];
    String artisanID = data['idartisan'];
    String domaine = await getDomaineDemande(domaineID);//'Plombrie';
    String prestation = await getPrestationDemande(domaineID, PrestationID);
    bool urgence = data['urgence'];

    String date = data['datedebut'];
    String heure = '${data['heuredebut']} - ${data['heurefin']}';
    String prix = await getPrixDemande(domaineID, PrestationID);
    String location = data['adresse'];
    String imageUrl = await getUserPathImage(artisanID);//'https://firebasestorage.googleapis.com/v0/b/selekny-app.appspot.com/o/Prestations%2FLPsJnqkVdXQUf6iBcXn0.png?alt=media&token=44ac0673-f427-43cf-9308-4b1213e73277';
    String nomArtisan = await getNameUser(artisanID);
    String rating = '4.5';
    String phone = await getPhoneUser(artisanID);
    //----
    String datefin = data['datefin'];
    String heureDebut = data['heuredebut'];
    String heureFin = data['heurefin'];
    double latitude = data['latitude'];
    double longitude = data['longitude'];
    Timestamp timestamp = data['timestamp'];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RendezVousClient(domaine: domaine,
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
            datefin:datefin ,
            iddomaine: domaineID,
            idprestation: PrestationID,
            idclient: userID,
            heuredebut: heureDebut ,
            heurefin: heureFin,
            latitude: latitude,
            longitude: longitude,
            idartisan: artisanID,
            timestamp: timestamp,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
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
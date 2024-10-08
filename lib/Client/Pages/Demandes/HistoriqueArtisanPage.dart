import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/Services/demande%20publication/HistoriqueServices.dart';
import 'package:reda/Client/components/HistoriqueArtisan_container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Services/ModifPrix.dart';

class HistoriqueArtisanPage extends StatefulWidget {
  const HistoriqueArtisanPage({
    super.key,
  });
  @override
  State<HistoriqueArtisanPage> createState() => _HistoriqueArtisanPageState();
}
class _HistoriqueArtisanPageState extends State<HistoriqueArtisanPage> {
  //---------------LES FONCTION GETTERS---------------------------------------------------
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final HistoriqueService _historiqueService = HistoriqueService();
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
  Future<String> getTokenById(String id) async {
    late String? token;
    Map<String, dynamic> userData = {};
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (documentSnapshot.exists) {
        userData = documentSnapshot.data()!;
        token = userData['token'];
        print("Get token by id : ${token}");
      }
      if (token != null) {
        return token;
      } else {
        return '';
      }
    } catch (e) {
      print("Erreur lors de la recuperation du token du user : ${e}");
    }

    return '';
  }
  //-----------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
              'Historique',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
          ),
          SizedBox(height:screenHeight*0.02),
          _buildTitleAndDescription(), // le petit texte du début
          SizedBox(height:screenHeight*0.01),
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
      stream: _historiqueService.getHistorique(_firebaseAuth.currentUser!.uid), //_firebaseAuth.currentUser!.uid
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
                        'Vous n\'avez aucun Historique.',
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
    final screenHeight = MediaQuery.of(context).size.height;
    if (document.data() != null) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String domaineID = data['iddomaine'];
      String PrestationID = data['idprestation'];
      String clientID = data['idclient'];
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(clientID).get();
      Map<String, dynamic> datas = userDoc.data() as Map<String, dynamic>;
      String domaine = await getDomaineDemande(domaineID);//'Plombrie';
      String prestation = await getPrestationDemande(domaineID, PrestationID);
      bool urgence = data['urgence'];
      String date = data['datedebut'];
      String heure = '${data['heuredebut']} - ${data['heurefin']}';
      String prix = await _modifPrixService.getPrixPrestation(domaineID, PrestationID);
      String location = data['adresse'];
      String imageUrl = await getUserPathImage(clientID);
      String nomClient = datas['nom'];
      bool vehicule = datas['vehicule'];
      String phone = datas['numTel'];
      String datefin = data['datefin'];
      String heureDebut = data['heuredebut'];
      String heureFin = data['heurefin'];
      String tokenArtisan = await getTokenById(data['idartisan']);
      String tokenClient = await getTokenById(data['idclient']);
      String nomArtisan = await getUserPathImage(data['idartisan']);
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HistoriqueArtisan(
                domaine: domaine,
                location: location,
                date: date,
                heure: heure,
                prix: prix,
                prestation: prestation,
                imageUrl: imageUrl,
                nomClient: nomClient,
                phone: phone,
                urgence: urgence,
                idclient: clientID,
                datefin: datefin,
                heuredebut: heureDebut,
                heurefin: heureFin,
                vehicule: vehicule, tokenClient: tokenClient,
              tokenArtisan: tokenArtisan,nomArtisan: nomArtisan,),
            SizedBox(height: screenHeight*0.015,),
          ]
      );
    } else {
      // Handle the case where the document is null
      print('Error: Document is null for document ID: ${document.id}');
      return Center(
          child: Text(
              'Vous n''avez aucun Historique.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              )
          )
      ); // or some placeholder widget
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
                  ' Vous pouvez ici consulter votre historique de demandes.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
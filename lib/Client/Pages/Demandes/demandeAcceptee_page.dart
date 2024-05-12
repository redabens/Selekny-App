import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/Pages/Demandes/demandeEncours_page.dart';
import 'package:reda/Client/components/demandeAcceptee_container.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Services/ModifPrix.dart';
import '../../profile/profileClient.dart';
import '../Home/home.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

class DemandeAccepteePage extends StatefulWidget {
  const DemandeAccepteePage({
    super.key,
  });
  @override
  State<DemandeAccepteePage> createState() => _DemandeAccepteePageState();
}
class _DemandeAccepteePageState extends State<DemandeAccepteePage> {
  int _currentIndex = 1;

  void _onItemTap(bool isEnCours) {
    setState(() {
      isEnCoursSelected = isEnCours;
    });
  }

  bool isEnCoursSelected = false;

  //---------------LES FONCTION GETTERS---------------------------------------------------
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DemandeClientService _DemandeAccepteeService = DemandeClientService();
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
        print('aucun domaine trouve');
        return '';
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(PrestationID).get();
      if (!prestation.exists) {
        print('aucune prestations trouve');
        return '';
      }
      return prestation.get('nom_prestation');
    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      return 'Erreur: $e';
    }
  }
  //get image user
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      String pathImage = userDoc['pathImage'];
      print(pathImage);
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            elevation: 0.0,
            // Remove default shadow
            backgroundColor: Colors.white,
            title: Text(
              'Demandes',
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
          _buildSelectionRow(),
          SizedBox(height: screenHeight*0.02),
          Expanded(
            child: _buildDemandeAccepteeList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage(),),
                );
              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/accueil.png',
                  color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DemandeEncoursPage(),),
                );


              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/demandes.png',
                  color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 1,),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/messages.png',
                  color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilClientPage(),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/profile.png',
                  color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildDemandeAccepteeList(){
    return StreamBuilder(
      stream: _DemandeAccepteeService.getDemandeClient(_firebaseAuth.currentUser!.uid), //_firebaseAuth.currentUser!.uid
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
            future: Future.wait(snapshot.data!.docs.map((document) => _buildDemandeAccepteeItem(document))),
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
                      'Vous n''avez aucune demande acceptée.',
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

  Future<Widget> _buildDemandeAccepteeItem(DocumentSnapshot document) async {
    final screenHeight = MediaQuery.of(context).size.height;
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetDemandeAcceptee(
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
          SizedBox(height: screenHeight*0.015,),
        ]
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
      ); // or some placeholder widget
    }
  }

//---------------------------------------------------------------------------------------------------
 Widget _buildSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => const DemandeEncoursPage())),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'En-cours',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 4 : 1, // Épaisseur de la ligne
                  color: isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _onItemTap(false),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'Acceptées',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: !isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 1 : 4, // Épaisseur de la ligne
                  color: !isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
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
                  ' Vous pouvez ici consulter vos demandes en cours, en attente, et celles qui sont confirmées pour la date du rendez-vous.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/ajouterDomaine.dart';
import 'package:reda/Pages/authentification/creationArtisan.dart';
import 'package:reda/Admin/Services/signalement_service.dart';
import 'package:reda/Admin/components/signalements_component.dart';
import 'package:intl/intl.dart';
import 'package:reda/Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import 'package:reda/Pages/authentification/connexion2.dart';


class AllSignalementsPage extends StatefulWidget {
  const AllSignalementsPage({super.key});

  @override
  AllSignalementsPageState createState() => AllSignalementsPageState();

}

class AllSignalementsPageState extends State<AllSignalementsPage> {
  int _currentIndex = 0;


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SignalementsService _SignalementsService = SignalementsService();

  //-----------------FONCTUIONS---------------------------------------
  Future<String> getNameUser(String userID) async {
    final userDoc = await _firestore.collection('users').doc(userID).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String userName = userDoc.data()!['nom'] as String;
    return userName;
  }

  Future<int> getNbSignalementUser(String userID) async {
    final userDoc = await _firestore.collection('users').doc(userID).get();
    if (!userDoc.exists) {
      return 0;
    }
    final int nb = userDoc.data()!['nbsignalement'] as int;
    return nb;
  }


  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      print('here');
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

  String getFormattedTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return 'à $formattedTime ';
  }

  String getFormattedDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return 'le $formattedDate ';
  }

  Future<String> getUserJob(String userId) async {
    try {
      // Access the Firestore collection 'users' and get the document with userId
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          String? role = userData['role'] as String?;
          if (role == 'artisan') {
            String? domaine = userData['domaine'] as String?;
            return domaine ?? '';
          } else {
            return 'Client';
          }
        } else {
          return 'Client';
        }
      } else {
        return 'client';
      }
    } catch (e) {

      print('Error fetching user job: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 20.0),

          AppBar(
            leading: IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const LoginPage2()),
              );
            },
              icon: Image.asset(
                'assets/deconexion.png',
                fit: BoxFit.cover,
                color: const Color(0xFF3E69FE),
              ),

            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              'Signalements',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 18),//========================================================================SPAAAACE
          Expanded(
            child: _buildSignalList(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllSignalementsPage(),),
                );
              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'icons/signalement.png',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GestionArtisansPage(),),
                );


              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'icons/gestion.png',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreationArtisanPage(domaine: 'Electricité',),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'icons/ajoutartisan.png',
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DomainServicePage(),)
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'icons/ajoutdomaine.png',
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


  Widget _buildSignalList() {

    return StreamBuilder(
      stream: _SignalementsService.getAllSignalements(), //_firebaseAuth.currentUser!.uid
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
            future: Future.wait(snapshot.data!.docs.map((document) => _buildSignalItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading signalements ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'Vous n\'avez aucun signalement',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  }

  Future<Widget> _buildSignalItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String signalementID = document.id;
    String signaleurID = data['id_signaleur'];
    String signalantID = data['id_signalant'];
    String raison = data['raison'];
    Timestamp timestamp = data['timestamp'];

    String signaleurUrl = await getUserPathImage(signaleurID);
    String signalantUrl = await getUserPathImage(signalantID);
    String signaleurName = await getNameUser(signaleurID);
    String signalantName =  await getNameUser(signalantID);
    String date = getFormattedDate(timestamp);
    String heure = getFormattedTime(timestamp);
    String signalantJob = await getUserJob(signalantID);
    String signaleurJob = await getUserJob(signaleurID);
    int nbsignalement = await getNbSignalementUser(signalantID);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetSignalement(signalementID: signalementID ,signaleurId: signaleurID,signalantId: signalantID,signaleurName:signaleurName, signalantName: signalantName, leDate: date, aHeure: heure,signaleurJob: signaleurJob,signalantJob: signalantJob,raison: raison,signaleurUrl: signaleurUrl,signalantUrl: signalantUrl,nbsignalement: nbsignalement,),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
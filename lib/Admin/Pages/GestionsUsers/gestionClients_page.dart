

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/ajouterDomaine.dart';
import 'package:reda/Admin/Services/GestionsUsers/gestionUsers_service.dart';
import 'package:reda/Admin/components/GestionsUsers/gestionUsers_container.dart';
import 'package:reda/Pages/authentification/creationArtisan.dart';
import '../../../Pages/authentification/connexion2.dart';
import '../deconnexion.dart';
import 'gestionArtisans_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/profilClientAdmin.dart';

class GestionClientsPage extends StatefulWidget {
  const GestionClientsPage({
    super.key,
  });

  @override
  State<GestionClientsPage> createState() => _GestionClientsPageState();
}

class _GestionClientsPageState extends State<GestionClientsPage> {
  int _currentIndex = 1;
  bool isEnCoursSelected = false;
  String searchText = '';

  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> allResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getClientsStream();
  }

  void _onItemTap(bool isEnCours) {
    setState(() {
      isEnCoursSelected = isEnCours;
    });
  }

  void _onSearchChanged() {
    // Filter results when search text changes
    setState(() {
      searchText = _searchController.text;
    });
  }

  getClientsStream() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: "client")
        .orderBy('nom')
        .get();

    setState(() {
      allResults = data.docs;
    });
  }

  final GestionUsersService _GestionUsersService = GestionUsersService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // espace fo9 titre de la page
          const SizedBox(height: 10.0),
          AppBar(
            leading: IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const Deconnecter()),
              );
            },
              icon: Image.asset(
                'assets/deconexion.png',
                fit: BoxFit.cover,
                color: const Color(0xFF3E69FE),
              ),

            ),
            elevation: 0.0, // Remove default shadow
            backgroundColor: Colors.white,
            title: Text(
              'Gestion des utilisateurs',
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 18),
          _buildSelectionRow(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 26, right: 26),
            child: Container(
              width: screenWidth*0.9 ,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: Colors.grey[300] ?? Colors.grey,
                  width: 2.0,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Recherche des clients...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500, // Semi-bold
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: _buildGestionUsersList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex:
        _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
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
                  MaterialPageRoute(
                    builder: (context) => const AllSignalementsPage(),
                  ),
                );
              },
              child: Container(
                height: screenHeight*0.042,
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
                  MaterialPageRoute(
                    builder: (context) => const GestionArtisansPage(),
                  ),
                );
              },
              child: Container(
                height: screenHeight*0.042,
                child: Image.asset(
                  'icons/gestion.png',
                  color: _currentIndex == 1
                      ? const Color(0xFF3E69FE)
                      : Colors.black,
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
                  MaterialPageRoute(
                    builder: (context) => const CreationArtisanPage(domaine: 'Electricité',),
                  ),
                );
              },
              child: Container(
                height:screenHeight*0.042,
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
                    MaterialPageRoute(
                      builder: (context) => const DomainServicePage(),
                    ));
              },
              child: Container(
                height: screenHeight*0.042,
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

  Widget _buildGestionUsersList() {
    return StreamBuilder(
      stream: _GestionUsersService.getAllClients(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        final documents = snapshot.data!.docs;
        final filteredDocuments = documents.where((document) {
          final userData = document.data() as Map<String, dynamic>;
          final userName = userData['nom'] as String;
          return userName.toLowerCase().contains(searchText.toLowerCase());
        }).toList();
        return FutureBuilder<List<Widget>>(
          future: Future.wait(filteredDocuments
              .map((document) => _buildGestionUsersItem(document))),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error loading users: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(children: snapshot.data!);
          },
        );
      },
    );
  }

  Future<Widget> _buildGestionUsersItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String userID = document.id;
    String profileImage = ""; // Default image
    String userName = "??????";
    String job = "?????";
    String phone = '0000';
    try {
      userName = data['nom'];
      job = 'Client';
      phone = data['numTel'];
      profileImage = await getUserPathImage(userID);
      print("l'url :$profileImage");
    } catch (error) {
      print("Error fetching user image: $error");
    }
    return GestureDetector(
      onTap: () {
        // Handle tap here (e.g., navigate to a new screen, show a dialog)

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage1CoteAdmin(
                  image: profileImage,
                  nomClient: userName,
                  phone: phone,
                  adress: data['adresse'],
                  idclient: userID,
                  isVehicled: data['vehicule'])
          ),
        );
      },
      child:Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DetGestionUsers(
                userName: userName, job: job, profileImage: profileImage),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GestionArtisansPage())),
            child: Column(
              // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'Mes Artisans',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isEnCoursSelected
                        ? const Color(0xFFF5A529)
                        : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 4 : 1, // Épaisseur de la ligne
                  color:
                  isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _onItemTap(false);
              searchText = ''; // Clear search text when switching to clients
              _searchController.clear(); // Clear text field
            },
            child: Column(
              // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'Mes Clients',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
}
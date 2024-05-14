

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/AjoutPrestation/AjoutPrestationAunDomaine.dart';
import 'package:reda/Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:reda/Admin/Services/Domaine_service.dart';
import 'package:reda/Pages/authentification/creationArtisan.dart';
import '../deconnexion.dart';
import 'ajouterbox.dart';
import 'detaildubox.dart';
import 'importerphoto.dart';

class DomainServicePage extends StatefulWidget {
  const DomainServicePage({super.key});

  @override
  DomainServicePageState createState() => DomainServicePageState();
}

class DomainServicePageState extends State<DomainServicePage> {
  int _currentIndex = 3;
  final DomainesService _domainesService = DomainesService();
  Future<String> getDomainePathImage(String pathImage) async {

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
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
        title:Text(
          'Domaine Service',
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.06,// Taille de la police
            fontWeight: FontWeight.w600,
            color: Colors.black, // Couleur du texte
          ),
        ),

        backgroundColor: Colors.white, // Couleur de fond de l'AppBar
        elevation: 0, // Supprimer l'ombre de l'AppBar
      ),
      backgroundColor: Colors.white, // Couleur de fond du Scaffold

      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Espacement général
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligner le texte au début
          children: [
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: _buildDomaineGrid(),
            ),
          ],
        ),
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
  Widget _buildDomaineGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: _domainesService.getDomaines(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }

        final documents = snapshot.data!.docs;

        // Print details of each document
        for (var doc in documents) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(snapshot.data!.docs.map((document) => _buildDomaineItem(document))),
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
                        'Vous n''avez aucun Domaine.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        )
                    )
                );
              }
              // Intercalate additional widgets between domain items
              final children = snapshot.data!.map((domainItem) => domainItem).toList();
              children.add(
                // Your additional widget here (GestureDetector with PlusIconBox)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Importer(), // Navigue vers la page "Importer"
                      ),
                    );
                  },
                  child: const PlusIconBox(),
                ),
              );
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: screenHeight * 0.01,
                crossAxisSpacing: screenWidth * 0.04,
                children: children,
              );
            });
      },
    );
  }
  Future<Widget> _buildDomaineItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String imageUrl = await getDomainePathImage(data['Image']);
    print("nom: ${data['Nom']} et image : $imageUrl");
    return DomainPhotoWidget(
      domainName: data['Nom'],
      imagePath: imageUrl,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AjoutPrestationAunDomaine(idDomaine: document.id,
            nomDomaine: data['Nom'],),
          ),
        );

      },
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Today.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Artisan/Pages/Profil/partie1Artisan.dart';
import 'package:reda/Artisan/Pages/Profil/partie2Artisan.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
class ProfilArtisanPage extends StatefulWidget {
  const ProfilArtisanPage({super.key});

  @override
  State<ProfilArtisanPage> createState() => _ProfilArtisanPageState();
}

class _ProfilArtisanPageState extends State<ProfilArtisanPage> {
  int _currentIndex = 3;
  String email = FirebaseAuth.instance.currentUser!.email ?? '';
  String? nomartisan = '';
  String? domaine = '';
  String? imageUrl = '';
  bool? vehicule;
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

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
  Future<String> getNomArtisan(String artisanId)async{
    try{
      final artisandoc = await FirebaseFirestore.instance.collection('users').doc(artisanId).get();
      Map<String,dynamic> data = artisandoc.data() as Map<String,dynamic>;
      return data['nom'];
    } catch(e){
      print("error : $e");
      return " ";
    }
  }
  Future<String> getDomaineArtisan(String artisanId)async{
    try{
      final artisandoc = await FirebaseFirestore.instance.collection('users').doc(artisanId).get();
      Map<String,dynamic> data = artisandoc.data() as Map<String,dynamic>;
      return data['domaine'];
    } catch(e){
      print("error : $e");
      return " ";
    }
  }
  Future<bool> getVehiculeArtisan(String artisanId)async{
    try{
      final artisandoc = await FirebaseFirestore.instance.collection('users').doc(artisanId).get();
      Map<String,dynamic> data = artisandoc.data() as Map<String,dynamic>;
      return data['vehicule'];
    } catch(e){
      print("error : $e");
      return false;
    }
  }
  Future<ProfileData> _fetchProfileData() async {
    // Combine data fetching logic from getNomArtisan, getUserPathImage, etc.
    String nomartisan = await getNomArtisan(FirebaseAuth.instance.currentUser!.uid);
    String imageUrl = await getUserPathImage(FirebaseAuth.instance.currentUser!.uid);
    String domaine = await getDomaineArtisan(FirebaseAuth.instance.currentUser!.uid);
    bool vehicule = await getVehiculeArtisan(FirebaseAuth.instance.currentUser!.uid);
    return ProfileData(nomartisan, email, imageUrl, domaine, vehicule);
  }
  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.08, // Taille proportionnelle
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[100]!, // Gris clair en haut
              Colors.white, // Blanc en bas
            ],
            stops: const [0.5, 0.5], // Transition nette
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              FutureBuilder<ProfileData>(
                future: _fetchProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.hasData) {
                    final profileData = snapshot.data!;
                    return Column(
                      children: [
                        ProfileArtisanSection(
                          nom: profileData.nomartisan,
                          email: profileData.email,
                          imageUrl: profileData.imageUrl,
                          domaine: profileData.domaine,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SettingsArtisanSection(vehicule: profileData.vehicule),
                      ],
                    );
                  }

                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator()),],
                  );

                },
              ),
            ],
          ),
        ),
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
                  MaterialPageRoute(builder: (context) => const ActiviteToday()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotifUrgente()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 2)),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilArtisanPage()),
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
}
class ProfileData {
  final String nomartisan;
  final String email;
  final String imageUrl;
  final String domaine;
  final bool vehicule;

  ProfileData(this.nomartisan, this.email, this.imageUrl, this.domaine, this.vehicule);
}


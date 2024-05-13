import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import 'BloquerArtisan.dart';

class ProfileBody2CoteAdmin extends StatefulWidget {
  final String userID;
  final String adresse;
  final String photoPath;
  final String name;
  final String domaine;
  final String phone;
  final bool isVehicled;
  final double rating;
  final int workCount;
  final VoidCallback onContact;
  final VoidCallback onReport;
  final VoidCallback onComment;
  final VoidCallback onPrestation;

  const ProfileBody2CoteAdmin({super.key,
    required this.photoPath,
    required this.name,
    required this.domaine,
    required this.phone,
    required this.isVehicled,
    required this.onContact,
    required this.onReport,
    required this.rating,
    required this.workCount,
    required this.onComment,
    required this.onPrestation, required this.userID, required this.adresse,
  });

  @override
  _ProfileBody2CoteAdminState createState() => _ProfileBody2CoteAdminState();
}
  class _ProfileBody2CoteAdminState extends State<ProfileBody2CoteAdmin> {
  late bool bloque = false ;
  Future<void> getBloqueStatut(String userID) async {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await firestore.collection('users').doc(userID).get();
        if (userDoc.exists) {
          setState(() {
            bloque = userDoc.get('bloque');
          });
        } else {
          print("User not found");
        }
      } catch (e) {
        print("Error fetching bloqued status: $e");
      }
    await Future.value(Null);
  }
  Future<void> bloqueDebloque(String userID) async {

    DocumentReference userRef =
    FirebaseFirestore.instance.collection('users').doc(userID);
    DocumentSnapshot userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      bool currentBloque = userSnapshot['bloque'] ?? false;

      await userRef.update({'bloque': !currentBloque});
    } else {
      throw Exception('User document not found');
    }
  }

  @override
  void initState() {
    super.initState();
    getBloqueStatut(widget.userID);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran

    return SingleChildScrollView( // Pour éviter le débordement si l'écran est petit
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.photoPath != ''
              ? ClipRRect(
            borderRadius: BorderRadius.circular(
                50), // Ajout du BorderRadius
               child: Image.network(
                 widget.photoPath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            )
              : Icon(
            Icons.account_circle,
            size: 65,
            color: Colors.grey[400],
          ),
          SizedBox(height: screenHeight * 0.02), // Espacement proportionnel
          Text(
            widget.name,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.05, // Taille de police proportionnelle
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            widget.domaine,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Nouvelle section avec dimensionnement proportionnel
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.1, // Ajustement proportionnel
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Centrage vertical
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: screenWidth * 0.1),
                          Text(
                            widget.rating.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Note",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  endIndent: 2,

                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/jobsnbr.png',
                            width: screenWidth * 0.1,
                            height: screenWidth * 0.1,
                          ),
                          Text(
                            widget.workCount.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        "Travaux traités",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.055,
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              border: Border.all(color: Colors.blue),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/tel.png', width: screenWidth * 0.05, height: screenWidth * 0.1),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  widget.phone,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: widget.onPrestation,
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.055,
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/prestation.png', width: screenWidth * 0.05, height: screenWidth * 0.1),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Prestation',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.black, size: screenWidth * 0.04),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: widget.onComment,
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.055,
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/commentaire.png', width: screenWidth * 0.05, height: screenWidth * 0.1),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Commentaire',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.black, size: screenWidth * 0.04),
                ],
              ),
            ),
          ),
          // Section "Véhiculé"
          SizedBox(height: screenHeight * 0.03),
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.055,
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              border: Border.all(color: Colors.blue),
              color: widget.isVehicled ? const Color(0xFF7CF6A5) : Colors.red.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/Car.png', // Car icon
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Véhiculé',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             /* GestureDetector(
                onTap: onContact,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E69FE),
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenWidth * 0.04),
                  child: Text(
                    'Contacter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.06),*/
              GestureDetector(
                onTap: () {
                  if (bloque) {
                    bloqueDebloque(widget.userID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GestionArtisansPage(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Bloquer(
                          adresse: widget.adresse,
                          idartisan: widget.userID,
                          imageurl: widget.photoPath,
                          nomartisan: widget.name,
                          phone: widget.phone,
                          domaine: widget.domaine,
                          rating: widget.rating,
                          workcount: widget.workCount,
                          vehicule: widget.isVehicled,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: bloque ? Colors.green : const Color(0xFFFF0000), // Vert pour débloquer, Rouge pour bloquer
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenWidth * 0.04),
                  child: Text(
                    bloque ? 'Débloquer' : 'Bloquer', // Texte change selon l'état de blocage
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

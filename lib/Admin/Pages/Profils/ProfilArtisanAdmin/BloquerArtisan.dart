
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import 'package:reda/Admin/Pages/Profils/ProfilArtisanAdmin/profilArtisanAdmin.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';



class Bloquer extends StatefulWidget {
  final String adresse;
  final String idartisan;
  final String imageurl;
  final String nomartisan;
  final String phone;
  final String email;
  final String domaine;
  final double rating;
  final int workcount;
  final bool vehicule;

  const Bloquer({Key? key, required this.adresse, required this.email,required this.idartisan, required this.imageurl, required this.nomartisan, required this.phone, required this.domaine, required this.rating, required this.workcount, required this.vehicule,}) : super(key: key);

  @override
  _BloquerState createState() => _BloquerState();
}

class _BloquerState extends State<Bloquer> {
  final TextEditingController _commentController = TextEditingController();

  void changeBloque(String userid){
    final userref = FirebaseFirestore.instance.collection('users').doc(userid);
    try {
      userref.update({'bloque': true});
    }catch(e){
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Return to the previous page
        },
        child: Stack(
          children: [
             ProfilePage2CoteAdmin(idartisan: widget.idartisan,email: widget.email, imageurl: widget.imageurl, nomartisan: widget.nomartisan, phone: widget.phone, domaine: widget.domaine, rating: widget.rating, adresse: widget.adresse, workcount: widget.workcount, vehicule: widget.vehicule,), // Background page
            Container(
              color: Color.fromRGBO(128, 128, 128, 0.7), // Semi-transparent gray overlay
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.08),
                width: screenWidth * 0.8,
                height: screenHeight *0.25,// Proportional width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'êtes vous sur de bloquer : ${widget.nomartisan} ?',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeBloque(widget.idartisan);
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                  builder: (context) =>
                                  const GestionArtisansPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(screenWidth * 0.04),
                              border:Border.all(color:Colors.red,width: 2.0 ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: screenWidth * 0.03,
                            ),
                            child: Text(
                              'OUI',
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.06),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Return to the previous page when "NON" is clicked
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05,
                              vertical: screenWidth * 0.03,
                            ),
                            child: Text(
                              'NON',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


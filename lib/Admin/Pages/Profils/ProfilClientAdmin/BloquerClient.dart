
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/profilClientAdmin.dart';



class BloquerClient extends StatefulWidget {
  final String idclient;
  final String image;
  final String nomClient;
  final String email;
  final String phone;
  final String adress;
  final bool isVehicled;

  const BloquerClient({Key? key, required this.idclient,  required this.email,required this.image, required this.nomClient, required this.phone, required this.adress, required this.isVehicled,}) : super(key: key);

  @override
  _BloquerClientState createState() => _BloquerClientState();
}

class _BloquerClientState extends State<BloquerClient> {
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
            ProfilePage1CoteAdmin(image: widget.image, nomClient: widget.nomClient, phone: widget.phone, adress: widget.adress, idclient: widget.idclient, isVehicled: widget.isVehicled, email: widget.email,),
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
                      'êtes vous sur de bloquer : ${widget.nomClient} ?',
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
                            changeBloque(widget.idclient);
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
                            Navigator.pop(context);
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


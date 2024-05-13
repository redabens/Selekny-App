import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../GestionsUsers/gestionClients_page.dart';
import 'BloquerClient.dart';

class ProfileBodyClientCoteAdmin extends StatefulWidget {
  final String userID;
  final String photoPath;
  final String name;
  final String phone;
  final String address;
  final bool isVehicled;
  final VoidCallback onContact;
  final VoidCallback onReport;

  ProfileBodyClientCoteAdmin({
    required this.photoPath,
    required this.name,
    required this.phone,
    required this.address,
    required this.isVehicled,
    required this.onContact,
    required this.onReport, required this.userID,
  });
  @override
  _ProfileBodyClientCoteAdminState createState() => _ProfileBodyClientCoteAdminState();
}
class _ProfileBodyClientCoteAdminState extends State<ProfileBodyClientCoteAdmin> {
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
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Column(
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
        SizedBox(height: screenHeight * 0.04),
        Text(
          widget.name,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.1),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/tel.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
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
        SizedBox(height: screenHeight * 0.04),
        Container(
          width: screenWidth * 0.9,

          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/localisation.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  widget.address,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
            color: widget.isVehicled ? const Color(0xFF7CF6A5) : Colors.white,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/Car.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                'Vehiculé',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.07),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*GestureDetector(
              onTap: widget.onContact,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical:12),
                child: Center(
                  child: Text(
                    'Contact',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),*/
            SizedBox(width: screenWidth * 0.05),
            GestureDetector(
              onTap: () {
                if (bloque) {
                  bloqueDebloque(widget.userID);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GestionClientsPage(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BloquerClient(idclient: widget.userID, image: widget.photoPath, nomClient: widget.name, phone: widget.phone, adress: widget.address, isVehicled: widget.isVehicled,),
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
    );
  }
}

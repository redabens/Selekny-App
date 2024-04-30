import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBody extends StatelessWidget {
  final String photoPath;
  final String name;
  final String phone;
  final String address;
  //final bool isVehicled;
  final VoidCallback onContact;
  final VoidCallback onReport;

  const ProfileBody({super.key,
    required this.photoPath,
    required this.name,
    required this.phone,
    required this.address,
    //required this.isVehicled,
    required this.onContact,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        photoPath != ''
            ? ClipRRect(
          borderRadius: BorderRadius.circular(
              50), // Ajout du BorderRadius
          child: Image.network(
            photoPath,
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
    SizedBox(height: screenHeight * 0.04), // Espacement proportionnel
    Text(
    name,
    style: GoogleFonts.poppins(
    fontSize: screenWidth * 0.05,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: screenHeight * 0.1), // Espacement entre les éléments
    Container(
    width: screenWidth * 0.9, // Largeur proportionnelle
    height: screenHeight * 0.06, // Hauteur proportionnelle
    padding: EdgeInsets.all(screenWidth * 0.03),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(screenWidth * 0.05),
    border: Border.all(color: Colors.blue),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // Centrage horizontal
    children: [
    Image.asset('assets/tel.png', width: screenWidth * 0.07, height: screenWidth * 0.07),
    SizedBox(width: screenWidth * 0.03),
    Text(
    phone,
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
    height: screenHeight * 0.06,
    padding: EdgeInsets.all(screenWidth * 0.03),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(screenWidth * 0.05),
    border: Border.all(color: Colors.blue),
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset('assets/localisation.png', width: screenWidth * 0.07, height: screenWidth * 0.07),
    SizedBox(width: screenWidth * 0.03),
    Text(
    address,
    style: GoogleFonts.poppins(
    fontSize: screenWidth * 0.04,
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    ),
    SizedBox(height: screenHeight * 0.04),
    /*Container(
    width: screenWidth * 0.9,
    height: screenHeight * 0.06,
    padding: EdgeInsets.all(screenWidth * 0.03),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(screenWidth * 0.05),
    border: Border.all(color: Colors.blue),
    color: isVehicled ? const Color(0xFF7CF6A5) : Colors.white,
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(
    'assets/Car.png', // Icône de voiture
    width: screenWidth * 0.07,
    height: screenWidth * 0.07,
    ),
    SizedBox(width: screenWidth * 0.03),
    Text(
    'Véhiculé',
    style: GoogleFonts.poppins(
    fontSize: screenWidth * 0.04,
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    ),*/
    SizedBox(height: screenHeight * 0.1),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    GestureDetector(
    onTap: onContact,
    child: Container(
    decoration: BoxDecoration(
    color: Color(0xFF3E69FE),
    borderRadius: BorderRadius.circular(screenWidth * 0.05),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Center(
    child: Text(
    'Contacter',
    style: GoogleFonts.poppins(
    color: Colors.white,
    ),
    ),
    ),
    ),
    ),
    SizedBox(width: screenWidth * 0.04), // Espacement entre les boutons
    GestureDetector(
    onTap: onReport,
    child: Container(
    decoration: BoxDecoration(
    color: Colors.red.withOpacity(0.7),
    borderRadius: BorderRadius.circular(screenWidth * 0.05),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    child: Text(
    'Signaler',
    style: GoogleFonts.poppins(
    color: Colors.white,
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
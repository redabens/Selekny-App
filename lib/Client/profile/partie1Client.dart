import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileClientSection extends StatelessWidget {
  final String nom;
  final String email;
  final String imageUrl;
  const ProfileClientSection({super.key,
    required this.nom,
    required this.email,
    required this.imageUrl,});

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageUrl.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(
                75), // Ajout du BorderRadius
            child: Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ): Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[400],
          ),
          SizedBox(height: screenHeight * 0.02), // Espacement proportionnel
          Text(
            nom,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05, // Taille proportionnelle
            ),
          ),
          Text(
            email,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.04, // Taille proportionnelle
            ),
          ),
        ],
      ),
    );
  }
}
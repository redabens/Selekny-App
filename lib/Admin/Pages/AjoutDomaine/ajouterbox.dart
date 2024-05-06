import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PlusIconBox extends StatelessWidget {
  const PlusIconBox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    final screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: screenHeight * 0.125,
          width: screenWidth * 0.5, // Hauteur proportionnelle
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: screenWidth * 0.008, // Épaisseur proportionnelle
            ),
            borderRadius: BorderRadius.circular(screenWidth * 0.04), // Rayon proportionnel
          ),
          child: Center(
            child: Container(
              width: screenWidth * 0.1, // Taille proportionnelle
              height: screenWidth * 0.1, // Taille proportionnelle
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: screenWidth * 0.008, // Épaisseur proportionnelle
                ),
              ),
              child:  Icon(
                Icons.add,
                color: Colors.grey,
                size: screenWidth * 0.06, // Taille proportionnelle
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // Espace proportionnel
        Text(
          "Ajouter",
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.04, // Taille proportionnelle
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
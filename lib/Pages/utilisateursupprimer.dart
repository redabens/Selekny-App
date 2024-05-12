import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Pages/retourAuth.dart';
class Supprimer extends StatelessWidget {
  const Supprimer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.05), // Utilisation d'une valeur relative pour le rayon de bordure
              child: Image.asset(
                'assets/envoye.png', // corrected asset name
                width: screenWidth * 0.5, // Utilisation d'une valeur relative pour la largeur de l'image
                height: screenHeight * 0.25, // Utilisation d'une valeur relative pour la hauteur de l'image
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // Utilisation d'une valeur relative pour l'espace
            Text(
              'Utilisateur Bloque',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05), // Utilisation d'une taille de police adaptative
            ),
            Text(
              'avec succès',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05), // Utilisation d'une taille de police adaptative
            ),
            SizedBox(height: screenHeight * 0.05), // Utilisation d'une valeur relative pour l'espace
            GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RetourAuth()),
                );
              },
              child: Container(
                width: screenWidth * 0.5, // Utilisation d'une valeur relative pour la largeur du bouton
                height: screenHeight * 0.05, // Utilisation d'une valeur relative pour la hauteur du bouton
                decoration: BoxDecoration(
                  color: const Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03), // Utilisation d'une valeur relative pour le rayon de bordure
                ),
                child: Center(
                  child: Text(
                    'Retour',
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: screenWidth * 0.04), // Utilisation d'une taille de police adaptative
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
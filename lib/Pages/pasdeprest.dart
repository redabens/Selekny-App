import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pasdeprestation extends StatelessWidget {
  const Pasdeprestation({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Prestations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Image positionnée au centre de l'écran
          Positioned(
            top: screenHeight * 0.15, // Ajustez la position verticale de l'image
            left: screenWidth * 0.25, // Ajustez la position horizontale de l'image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              child: Image.asset(
                'assets/erreur.jpg',
                width: screenWidth * 0.52,
                height: screenHeight * 0.27,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Texte "Oups !" positionné sous l'image
          Positioned(
            top: screenHeight * 0.41, // Ajustez la position verticale du texte
            left: screenWidth * 0.42, // Ajustez la position horizontale du texte
            child: Text(
              'Oups !',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05,
              ),
            ),
          ),
          // Texte "Pas de prestation pour le moment" positionné sous "Oups !"
          Positioned(
            top: screenHeight * 0.45,
            left: screenWidth * 0.15,
            child: Text(
              'Pas de prestation pour le moment',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
          // Texte "Veuillez choisir un autre domaine pour effectuer" positionné sous "Pas de prestation pour le moment"
          Positioned(
            top: screenHeight * 0.49,
            left: screenWidth * 0.071,
            child: Text(
              'Veuillez choisir un autre domaine pour effectuer',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          // Texte "votre demande" positionné sous "Veuillez choisir un autre domaine pour effectuer"
          Positioned(
            top: screenHeight * 0.52, // Ajustez la position verticale du texte
            left: screenWidth * 0.36, // Ajustez la position horizontale du texte
            child: Text(
              'votre demande',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
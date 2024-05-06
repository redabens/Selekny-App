import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//Details de chaque box de domaine

class DomainPhotoWidget extends StatelessWidget {
  final String domainName;
  final String imagePath;
  final VoidCallback onTap;

  const DomainPhotoWidget({
    super.key,
    required this.domainName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.04), // Rayon proportionnel
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  height: screenWidth * 0.28, // Hauteur proportionnelle
                  width: screenWidth * 0.6, // Largeur proportionnelle
                ),
              ),
              Positioned(
                top: screenWidth * 0.27 - 32, // Position proportionnelle
                right: screenWidth * 0.03, // Position proportionnelle
                child: Container(
                  width: screenWidth * 0.07, // Taille proportionnelle
                  height: screenWidth * 0.07, // Taille proportionnelle
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: screenWidth * 0.04, // Taille proportionnelle
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02), // Espacement proportionnel
          Text(
            domainName,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.045, // Taille proportionnelle
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
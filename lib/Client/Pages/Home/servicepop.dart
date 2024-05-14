

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';

class Servicepop extends StatelessWidget {
  const Servicepop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 19, 0), // Ajouter un padding uniforme à gauche et à droite
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services populaires',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600 , fontSize: 20),
          ),
          const SizedBox(height: 10), // Espace entre le texte et les images
          Row(

            children: [
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailsDemande(domaineID: 'ajEON4X1fduQVsdVoqFJ', prestationID: 'janPLX2db6cNnXcHHYF5', nomprestation: 'Installation robinet') ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/robinet.jpg',
                            height: screenHeight*0.12,
                            width: screenWidth*0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Espace entre l'image et le texte
                    Text(
                      'Installation de robinet',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10), // Espace entre les images
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailsDemande(domaineID: 'ynoP8TEQxtGUdTY0Ffld', prestationID: '3bbkgMkE4RM52jWGuzmp', nomprestation: 'Nettoyage des sols') ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/nettoyagesol.jpg',
                            height: screenHeight*0.12,
                            width: screenWidth*0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Espace entre l'image et le texte
                    Text(
                      'Nettoyage des sols',
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

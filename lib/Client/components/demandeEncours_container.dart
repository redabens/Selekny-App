import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetDemandeEncours extends StatelessWidget {
  final String domaine;
  final String prestation;
  final String date;
  final String heure;
  final String prix;
  final String sync;
  final bool urgence;

  const DetDemandeEncours({
    super.key,
    required this.domaine,
    required this.prestation,
    required this.date,
    required this.heure,
    required this.prix,
    required this.sync,
    required this.urgence
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    final screenHeight = MediaQuery.of(context).size.height; //
    return Padding(
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
      ),

      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10), // Espacement entre les boxes
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      domaine,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10), // Correction de l'espace
                    Expanded(
                      child: Text(
                        prestation,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      'icons/calendrier.png', // Chemin de l'image
                      height: 20,             // Taille de l'image
                    ),
                    Text(
                      " $date",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),   // Ajoute de l'espace entre les éléments
                    Text(
                      urgence ? "Urgente" : heure, // Affiche "Urgente" si urgence est vrai, sinon affiche l'heure
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: urgence ? Colors.red : null, // Couleur rouge si urgence est vrai
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      prix,
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(), // Ajoute de l'espace
                    Text(
                      sync,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
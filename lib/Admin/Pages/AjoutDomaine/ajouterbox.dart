import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Creation du box ajouter
class PlusIconBox extends StatelessWidget {
  const PlusIconBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Garde la taille minimale pour le contenu
      children: [
        Container(
          height:100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, // Couleur de la bordure
              width: 3.0, // Épaisseur de la bordure
            ),
            borderRadius: BorderRadius.circular(15), // Rayon des coins
          ),
          child: Center(
            child: Container(
              width: 40, // Taille du cercle intérieur
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white, // Couleur du cercle intérieur
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey, // Couleur de la bordure du cercle intérieur
                  width: 3.0, // Épaisseur de la bordure intérieure
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.grey, // Couleur du signe plus
                size: 24, // Taille du signe plus
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Espace entre le box et le texte
        Text(
          "Ajouter", // Texte à afficher sous le box
          style: GoogleFonts.poppins(
            fontSize: 16, // Taille du texte
            color: Colors.grey, // Couleur du texte
          ),
        ),
      ],
    );
  }
}

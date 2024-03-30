import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 2), // Ajustement de la marge verticale
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.2), // Ajustement du padding vertical
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
            spreadRadius: 5, // Rayon de diffusion de l'ombre
            blurRadius: 7, // Rayon de flou de l'ombre
            offset: const Offset(0, 3), // Décalage de l'ombre
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/Search_alt.png', width: 24, height: 24), // Remplacer 'votre_image.png' par le chemin de votre image
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Chercher un service...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.4),
                ),
                border: InputBorder.none, // Supprime la bordure du champ de saisie
              ),
            ),
          ),
        ],
      ),
    );
  }
}
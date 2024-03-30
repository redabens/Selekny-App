import 'package:flutter/material.dart';
import 'package:selek/pages/help/help.dart';

class Header extends StatelessWidget {
  const Header({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selekny',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(), // Pour ajouter un espace flexible entre les éléments
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
            icon: Image.asset(
              'assets/Question.png', // Remplacez 'votre_image.png' par le chemin de votre image dans le dossier assets
              width: 30, // Largeur de l'image
              height: 30, // Hauteur de l'image
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Home/search.dart';
import 'package:reda/Pages/help.dart';

class Header extends StatelessWidget {
  const Header({super.key, Key});

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
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CustomSearch());
                  print('Barre de recherche appuyée');
                },
                icon: Image.asset(
                  'assets/Search_alt.png', // Remplacez 'votre_image.png' par le chemin de votre image de recherche
                  width: 30, // Largeur de l'image
                  height: 30, // Hauteur de l'image
                ),
              ),
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
        ],
      ),
    );
  }
}

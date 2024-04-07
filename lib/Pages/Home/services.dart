import 'package:flutter/material.dart';
import 'package:reda/Pages/Home/datails.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, // Hauteur fixe pour contenir les images agrandies
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 5), // Espacement initial
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 7), // Espacement entre les images
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 7), // Espacement entre les images
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 5), // Espacement final
        ],
      ),
    );
  }
}
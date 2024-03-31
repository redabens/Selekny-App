import 'package:flutter/material.dart';
import 'package:reda/Pages/Home/datails.dart';

class ImageList2 extends StatelessWidget {
  final List<String> imagePaths = [
    "assets/Plomberie.png",
    "assets/electricite.png",
    "assets/macon.png",
    "assets/menuisier.png",
  ];

  final List<String> texts = [
    "Plombier",
    "Electricien",
    "Maçon",
    "Menuisier",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top:10, left:2), // Ajout de padding au haut de la liste
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(imagePaths.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DetailPage()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      imagePaths[index],
                      width: 79,
                      height: 79,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      texts[index],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
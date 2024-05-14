
import 'package:flutter/material.dart';
import 'package:reda/Pages/pasdeprest.dart';
import 'package:reda/Pages/prestation_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageList extends StatelessWidget {
  final int type;
  ImageList({
    super.key,
    required this.type
  });
  final List<String> imagePaths = [
    "assets/peintre.png",
    "assets/carreleur.png",
    "assets/serrurier.png",
    "assets/menuisier.png",
  ];

  final List<String> texts = [
    "Peintre",
    "Carreleur",
    "Serrurier",
    "Menuiserie",
  ];
  final List<String> ID = [
    "default",
    "default",
    "default",
    "default",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top:10, left:1), // Ajout de padding au haut de la liste
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(imagePaths.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pasdeprestation(),
                  ),
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
                      style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
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

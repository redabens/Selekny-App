import 'package:flutter/material.dart';
import 'package:reda/Pages/prestation_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageList2 extends StatelessWidget {
  final int type;
  ImageList2({
    super.key,
    required this.type
  });
  final List<String> imagePaths = [
    "assets/Plomberie.png",
    "assets/electricite.png",
    "assets/macon.png",
    "assets/femme de menage.png",


  ];

  final List<String> texts = [
    "Plomberie",
    "Electricité",
    "Maçonnerie",
    "Ménage",


  ];
  final List<String> ID = [
    "ajEON4X1fduQVsdVoqFJ",
    "KYsR4cj4mdVoDlrbyZbB",
    "s5Nry8HGyjjAgFsAxoum",
    "ynoP8TEQxtGUdTY0Ffld",


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
                  MaterialPageRoute(builder: (context) => PrestationPage(domaineID: ID[index],indexe: 2, type: type,)),
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
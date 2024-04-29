import 'package:flutter/material.dart';
import 'package:reda/Pages/prestation_page.dart';

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
    "assets/femme de menage.png",
  ];

  final List<String> texts = [
    "Peintre",
    "Carreleur",
    "Serrurier",
    "Ménage",
  ];
  final List<String> ID = [
    "default",
    "default",
    "default",
    "FhihjpW4MAKVi7oVUtZq",
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

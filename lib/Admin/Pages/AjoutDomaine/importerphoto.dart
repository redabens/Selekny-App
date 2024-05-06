import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ajouter demande.dart';

class Importer extends StatefulWidget {
  const Importer({super.key});

  @override
  _ImporterState createState() => _ImporterState();
}

class _ImporterState extends State<Importer> {
  final TextEditingController _textController = TextEditingController(); // Champ de saisie pour le nom du domaine

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context,MaterialPageRoute(
            builder: (context) => const DomainServicePage(),
          ),); // Retour à la page précédente
        },
        child: Stack(
          children: [
            const DomainServicePage(),
            Container(
              color: const Color.fromRGBO(128, 128, 128, 0.7), // Overlay gris semi-transparent
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.08),
                width: screenWidth * 0.9, // Largeur proportionnelle
                height: screenHeight * 0.4, // Hauteur proportionnelle
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Champ de saisie avec un texte d'indication
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ajouter le nom du domaine',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // Espace entre les éléments
                    Row(
                      children: [
                        // Conteneur gris pour l'image
                        Expanded(
                          child: Container(
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Couleur grise
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Image.asset(
                                'icons/ajoutimage.png', // Icône de l'image
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05), // Espace entre les éléments
                        // Bouton pour importer une image
                        GestureDetector(
                          onTap: () {
                            // Action à effectuer lors de l'importation
                          },
                          child: Container(
                            height: screenHeight * 0.05,
                            width : screenWidth * 0.4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E69FE), // Couleur bleue
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Importer image',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(), // Ajoute de l'espace entre les éléments et le bouton "Terminer"
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Retour à la page principale
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.25, // Largeur du bouton "Terminer"
                        decoration: BoxDecoration(
                          color: const Color(0xFF3E69FE), // Couleur bleue
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Terminer',
                            style: GoogleFonts.poppins(
                              color: Colors.white, // Couleur du texte
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
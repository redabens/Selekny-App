import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConditionsGeneralesPage extends StatelessWidget {
  const ConditionsGeneralesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        title: Text(
          'Conditions Générales',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: screenWidth*0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white, // Fond blanc
          padding: const EdgeInsets.all(16), // Espacement autour du contenu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conditions à respecter', // Texte en gras
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth*0.05,
                ),
              ),
              SizedBox(height:screenHeight*0.010), // Espace entre les éléments
              Row(
                children: [
                  Image.asset(
                    'assets/important.png', // Chemin vers l'image
                    width: 30, // Largeur de l'image
                    height: 50, // Hauteur de l'image
                  ),
                  const SizedBox(width: 10), // Espace entre l'image et le texte
                  Expanded(
                    child: Text(
                      'Vous devez respecter toutes les conditions suivantes pour ne pas avoir de problèmes avec l\'administration.',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth*0.027,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espace intérieur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Vous devez mettre à jour régulièrement votre disponibilité sur l\'application.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height:screenHeight*0.010), // Espacement entre les éléments
              // Autres conteneurs avec du texte et bordure bleue
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Il est important d\'indiquer clairement les heures de travail et les jours disponibles.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height:screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Vous devez définir des tarifs clairs et transparents pour vos services.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height:screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Les frais supplémentaires éventuels doivent être communiqués au client avant la prestation. ',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height:screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'En cas de retard, une communication préalable avec le client est nécessaire.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Vous devez  respecter la confidentialité des informations personnelles des clients.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.010), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Vous devez respecter les délais convenus pour la réalisation des travaux.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.01), // Espace entre le texte et la bordure
              Container(
                padding: const EdgeInsets.all(10), // Espacement à l'intérieur du conteneur
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.withOpacity(0.4)), // Bordure bleue
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                ),
                child: Text(
                  'Vous n\'avez aucun droit d\'annuler une demande après son acceptation sauf si dans des cas critiques qui nécessitent une justification.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.04,
                  ),
                ),
              ),// Ajoutez d'autres éléments au besoin
            ],
          ),
        ),
      ),
    );
  }
}
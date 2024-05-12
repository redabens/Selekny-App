import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';

import 'contacter.dart';
class PageAnnulationRendezVous extends StatelessWidget {
  const PageAnnulationRendezVous({super.key});

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
        backgroundColor: Colors.white,
        title: const Text('Un prestataire a annulé un rendez-vous?'),
        leading: IconButton(
          icon: Image.asset('assets/retour.png'), // Remplacez 'assets/back_arrow.png' par le chemin de votre image
          onPressed: () {
            Navigator.of(context).pop(); // Revenir à la page précédente lorsque l'image est cliquée
          },
        ),
      ),
      backgroundColor: Colors.white, // Définit le fond de la page en blanc
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                border: Border.all(
                  color: const Color(0xFF3E69FE).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [ Text(
                'Si un artisan a annulé un rendez-vous sans justification, vous pouvez le signaler.\n\n'
                    'Comment signaler un artisan ?\n\n'
                    'Pour signaler un artisan :\n'
                    '- Accéder au profil de l\'artisan concerné \n'
                    '- Cliquez sur le bouton "Signaler" \n'
                    '- Justifiez votre signalement et cliquez sur "Envoyer".\n ',
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),),
                const SizedBox(height:10),
                GestureDetector(
                  onTap: () {
                    // Naviguer vers une autre page lorsque le texte est cliqué
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ContactUsPage()));
                  },
                  child: Text(
                    'Contactez-nous',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.04,
                      color: const Color(0xFF3E69FE),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(
                          0xFF3E69FE), // Couleur du soulignement
                    ),
                  ),
                ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Image.asset('assets/rdv.jpg', width: screenWidth*0.9, height:screenHeight*0.28),
          ],
        ),
      ),
    );
  }}
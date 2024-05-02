import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Demandes/Rendezvous_Page.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selekny',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(), // Pour ajouter un espace flexible entre les éléments
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RendezVousPage()),
              );
            },
            icon: Image.asset(
              'assets/Ademandes.png', // Remplacez 'votre_image.png' par le chemin de votre image dans le dossier assets
              width: 30, // Largeur de l'image
              height: 30, // Hauteur de l'image
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Demandes/Rendezvous_Page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/Pages/Home/search.dart';
import 'package:reda/Pages/retourAuth.dart';

class Header extends StatelessWidget {
  final int type;
  const Header({super.key, required this.type});

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
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(// Pour ajouter un espace flexible entre les éléments
          children:[
            IconButton(
              onPressed: () {
                if(type == 1){
                  showSearch(context: context, delegate: CustomSearch());
                  print('Barre de recherche appuyée');
                }
              },
              icon: Image.asset(
                'assets/Search_alt.png', // Remplacez 'votre_image.png' par le chemin de votre image dans le dossier assets
                width: 30, // Largeur de l'image
                height: 30, // Hauteur de l'image
              ),
            ),
            const SizedBox(width: 5,),
            IconButton(
            onPressed: () {
              if(type == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RendezVousPage()),
                );
              }
              else{
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
                );
              }
            },
            icon: Image.asset(
              'assets/Ademandes.png', // Remplacez 'votre_image.png' par le chemin de votre image dans le dossier assets
              width: 30, // Largeur de l'image
              height: 30, // Hauteur de l'image
            ),
          ),
          ],),
        ],
      ),
    );
  }
}
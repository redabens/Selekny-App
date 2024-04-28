import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Lieu extends StatelessWidget {
  final String adresse;
  const Lieu({super.key, required this.adresse});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 20,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(

              'assets/lieu.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          const SizedBox(width: 7),
          Text(
            adresse,
            style: GoogleFonts.poppins(
              color: const Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}
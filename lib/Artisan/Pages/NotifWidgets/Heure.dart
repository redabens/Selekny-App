import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Heure extends StatelessWidget {
  final String heuredebut;
  const Heure({super.key, required this.heuredebut});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 20,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 7),
          Container(
            height: 17,
            width: 17,
            child: Image.asset(

              'assets/heure.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          const SizedBox(width: 7),
          Text(
            heuredebut,
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
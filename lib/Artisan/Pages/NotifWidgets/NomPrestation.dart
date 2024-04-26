import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class NomPrestation extends StatelessWidget {
  final String nomprestation;
  const NomPrestation({
    super.key,
    required this.nomprestation
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 30,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            child: Image.asset(
              'assets/cle.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          const SizedBox(width: 10),
          Text(
            nomprestation,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}
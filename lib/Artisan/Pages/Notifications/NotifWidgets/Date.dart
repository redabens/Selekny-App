import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Date extends StatelessWidget {
  final String datedebut;
  final int type;
  final bool urgence;
  const Date({super.key, required this.datedebut, required this.type, required this.urgence});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 20,
      color: Colors.white,
      child: type == 1 ? Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(

              'assets/date.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          const SizedBox(width: 7),
          Text(
            datedebut,
            style: GoogleFonts.poppins(
              color: const Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ): !urgence ? Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(

              'assets/date.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          const SizedBox(width: 7),
          Text(
            datedebut,
            style: GoogleFonts.poppins(
              color: const Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ) : const SizedBox(),
      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
    );
  }
}
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Date extends StatelessWidget {
  final String datedebut;
  final bool urgence;
  const Date({super.key, required this.datedebut, required this.urgence});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.71,
      //height: 20,
      child:Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
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
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
    );
  }
}
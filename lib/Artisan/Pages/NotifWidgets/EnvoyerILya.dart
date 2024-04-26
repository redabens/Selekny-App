import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Envoyerilya extends StatelessWidget {
  const Envoyerilya({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      //color: Colors.yellow,
      child: Align(
        alignment: const Alignment(0.0, 0.5), // Centrage par rapport à Y

        child: Text(
          'Envoyé il y a 5 min',
          style: GoogleFonts.poppins(
            color: const Color(0xFF3E69FE),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),


    );
  }

}
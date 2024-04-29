import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Envoyerilya extends StatelessWidget {
  final Timestamp timestamp;
  const Envoyerilya({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
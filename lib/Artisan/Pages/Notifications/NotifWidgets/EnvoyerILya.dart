import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Envoyerilya extends StatelessWidget {
  final Timestamp timestamp;
  final String sync;
  const Envoyerilya({super.key, required this.timestamp, required this.sync});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      child: Align(
        alignment: const Alignment(0.0, 0.5), // Centrage par rapport à Y

        child: Text(
          sync,
          style: GoogleFonts.poppins(
            color: const Color(0xFF3E69FE),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),


    );
  }

}
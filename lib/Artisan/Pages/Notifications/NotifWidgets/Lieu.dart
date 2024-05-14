

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Lieu extends StatelessWidget {
  final String adresse;
  const Lieu({super.key, required this.adresse});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      //height: MediaQuery.of(context).size.height * 0.03,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
        crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
        children: [
          const SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(
              'assets/lieu.png', // Replace with your image path
            ),
          ),
          const SizedBox(width: 7),
          Expanded( // Expand text to fill available space
            child: RichText(// Enable ellipsis at overflow
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: adresse,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12, // Adjust font size as needed
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

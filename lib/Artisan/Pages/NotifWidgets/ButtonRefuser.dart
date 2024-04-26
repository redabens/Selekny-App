import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buttonrefuser extends StatefulWidget {
  const buttonrefuser({super.key});

  @override
  buttonrefuserState createState() => buttonrefuserState();
}

class buttonrefuserState extends State<buttonrefuser> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed:() {

        },// hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'refuser',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: const ImageIcon(
                AssetImage('assets/close.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
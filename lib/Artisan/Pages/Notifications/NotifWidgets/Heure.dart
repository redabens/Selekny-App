
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Heure extends StatelessWidget {
  final String heuredebut;
  final bool urgence;
  const Heure({super.key,
    required this.heuredebut,
    required this.urgence});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth*0.72,
      // color: Colors.yellow,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width:screenWidth*0.01),
          Container(
            height: 17,
            width: 17,
            child: Image.asset(

              'assets/heure.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width:screenWidth*0.013),
          Text(
            heuredebut,
            style: GoogleFonts.poppins(
              color: const Color(0xFF757575),
              fontSize: screenWidth*0.03,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              Container(
                width: 80,
                //height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6B940),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20,),
                    Text(
                      'Urgent',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/components/Demande.dart';
import 'heuredebut.dart';
import 'heurefin.dart';





class Heure extends StatelessWidget {
  final Demande demande;
  const Heure({
    super.key,
    required this.demande,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.15,
      width: screenWidth*0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEBE5E5),
          width: 2.0,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'icons/heure.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              SizedBox(width:screenWidth*0.03),
              Text(
                'L\'Heure',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize:screenWidth*0.03,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight*0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth*0.07),
              Text(
                'Selectionner l\'heure qui vous convient ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: screenWidth*0.03,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth*0.06, height: screenHeight*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth*0.06),
              De(demande: demande,),
              SizedBox(width: screenWidth*0.03),
              Jusqua(demande: demande),

            ],


          ),


          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'Jourdebut.dart';
import 'moisdebut.dart';
import 'anneedebut.dart';
import 'JourFin.dart';
import 'moisFin.dart';
import 'anneeFin.dart';





class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      width: 325,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFFEBE5E5),
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(10),
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
                  'icons/date.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Date',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 30),
              Text(
                'Selectionner la date de début et la fin de la \n prestation ',
                style: GoogleFonts.poppins(
                  color: Color(0xFF6D6D6D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(width: 25, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 33),
              Text(
                'Début',
                style: GoogleFonts.poppins(
                  color: Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          SizedBox(width: 15, height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 25),
              JourDebut(),
              SizedBox(width: 9),
              MoisDebut(),
              SizedBox(width: 9),
              AnneeDebut(),
            ],


          ),
          SizedBox(width: 25, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 33),
              Text(
                'Fin',
                style: GoogleFonts.poppins(
                  color: Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          SizedBox(width: 15, height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 25),
              JourFin(),
              SizedBox(width: 9),
              MoisFin(),
              SizedBox(width: 9),
              AnneeFin(),
            ],


          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}
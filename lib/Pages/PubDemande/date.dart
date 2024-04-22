import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/components/Date.dart';
import 'package:reda/components/Demande.dart';
import 'Jourdebut.dart';
import 'moisdebut.dart';
import 'anneedebut.dart';
import 'JourFin.dart';
import 'moisFin.dart';
import 'anneeFin.dart';





class Dates extends StatelessWidget {
  final Date datedebut;
  final Date datefin;
  const Dates({
    super.key,
    required this.datedebut,
    required this.datefin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      width: 325,
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
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  'icons/date.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              const SizedBox(width: 10),
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              Text(
                'Selectionner la date de début et la fin de la \n prestation ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 25, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 33),
              Text(
                'Début',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          const SizedBox(width: 15, height: 5,),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 25),
              JourDebut(datedebut: datedebut,),
              const SizedBox(width: 9),
              MoisDebut(datedebut: datedebut,),
              const SizedBox(width: 9),
              AnneeDebut(datedebut: datedebut,),
            ],


          ),
          const SizedBox(width: 25, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 33),
              Text(
                'Fin',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          const SizedBox(width: 15, height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 25),
              JourFin(datefin: datefin,),
              const SizedBox(width: 9),
              MoisFin(datefin: datefin,),
              const SizedBox(width: 9),
              AnneeFin(datefin: datefin,),
            ],


          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}
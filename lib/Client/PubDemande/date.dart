import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/components/Date.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.3,
      width: screenWidth* 0.8,
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
              const SizedBox(width: 10),
            Expanded(
             child: Text(
                'Selectionner la date de début et la fin de la prestation ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
    ),

            ],
          ),
          const SizedBox(width: 25, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Text(
                'Début :',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          const SizedBox( height: 5,),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              JourDebut(datedebut: datedebut,),
              SizedBox(width: screenWidth*0.02),
              MoisDebut(datedebut: datedebut,),
              SizedBox(width: screenWidth*0.02),
              AnneeDebut(datedebut: datedebut,),
            ],

          ),
          const SizedBox(width: 10, height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               const SizedBox(width: 10),
              Text(
                'Fin :',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],


          ),
          const SizedBox( height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              JourFin(datefin: datefin,),
              SizedBox(width: screenWidth*0.02),
              MoisFin(datefin: datefin,),
              SizedBox(width: screenWidth*0.02),
              AnneeFin(datefin: datefin,),
            ],


          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}
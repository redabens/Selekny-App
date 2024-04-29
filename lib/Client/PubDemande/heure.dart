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
    return Container(
      height: 133,
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
                  'icons/heure.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'L\'Heure',
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
                'Selectionner l\'heure qui vous convient ',
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
              De(demande: demande,),
              const SizedBox(width: 10),
              Jusqua(demande: demande),

            ],


          ),


          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}
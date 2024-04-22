import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Pages/PubDemande/DemandeEnvoyeInit.dart';
import 'package:reda/Services/demande%20publication/publierDemandeinit.dart';
import 'package:reda/components/Date.dart';
import 'package:reda/components/Demande.dart';

class Suivant extends StatelessWidget {
  final String prestationID;
  final Demande demande;
  final Date datedebut;
  final Date datefin;
  const Suivant({
    super.key,
    required this.prestationID,
    required this.demande,
    required this.datedebut,
    required this.datefin,
  });

 // final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:
            [
              const SizedBox(width: 220,),

      ElevatedButton(

      onPressed:() {
        demande.setDateDebut(datedebut.toString());
        demande.setDateFin(datefin.toString());
        publierDemandeinit(prestationID,
            demande.urgence,
            demande.date_debut.toString(),
            demande.date_fin.toString(),
            demande.heure_debut,
            demande.heure_fin);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DemandeEnvoye()),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF3E69FE)),
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 16)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

           Text(
            'Suivant',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 16),

        ],
      ),
    )
    ],
    ),
    );

  }
}

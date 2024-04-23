import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/PubDemande/DemandeEnvoyeInit.dart';
import 'package:reda/Client/components/Date.dart';
import 'package:reda/Client/components/Demande.dart';
import 'package:reda/Client/Services/demande%20publication/publierDemandeinit.dart';

class Suivant extends StatelessWidget {
  final String prestationID;
  final String domaineId;
  final Demande demande;
  final Date datedebut;
  final Date datefin;
  const Suivant({
    super.key,
    required this.prestationID,
    required this.demande,
    required this.datedebut,
    required this.datefin,
    required this.domaineId,
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
        publierDemandeinit(domaineId,prestationID,
            demande.urgence,
            demande.date_debut.toString(),
            demande.date_fin.toString(),
            demande.heure_debut,
            demande.heure_fin);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DemandeEnvoye(prestationID: prestationID, domaineId: domaineId, demande: demande,)),
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

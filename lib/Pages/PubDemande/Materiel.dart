import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';





class Materiel extends StatelessWidget {
  final String materiel;
  const Materiel({
    super.key,
    required this.materiel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.17,
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
              Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'icons/materiel.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Le matériel nécessaire :',
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
                materiel,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}
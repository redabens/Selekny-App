

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';







class Prix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.02,
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
                  'icons/prix.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Prix approximatif :',
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
                '600 DA-1000 DA',
                style: GoogleFonts.poppins(
                  color: Color(0xFF3E69FE),
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

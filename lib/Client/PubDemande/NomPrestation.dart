

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NomPrestation extends StatelessWidget {
  final String nomprestation;
  const NomPrestation({super.key,
   required this.nomprestation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            const SizedBox(width: 30,height: 30,),
            Text(
              nomprestation,
              style: GoogleFonts.poppins(
                color: const Color(0xFF3E69FE),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
      ),
    );
  }
}

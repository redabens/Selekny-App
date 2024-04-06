

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NomPrestation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          children: [
            SizedBox(width: 30,height: 30,),
            Text(
              'Installation des robinets',
              style: GoogleFonts.poppins(
                color: Color(0xFF3E69FE),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
      ),
    );
  }
}

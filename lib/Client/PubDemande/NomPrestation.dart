

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class NomPrestation extends StatelessWidget {
  final String nomprestation;
  const NomPrestation({super.key,
   required this.nomprestation,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
          children: [
             SizedBox(width: screenWidth*0.08,height: screenHeight*0.02,),
            Expanded(child:
            Text(
              nomprestation,
              style: GoogleFonts.poppins(
                color: const Color(0xFF3E69FE),
                fontSize:screenWidth*0.05,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
            ),
            ),
          ]
      ),
    );
  }
}

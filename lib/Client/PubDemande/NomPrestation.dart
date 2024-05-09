

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Expanded(

            child:Text(
              nomprestation,
              style: GoogleFonts.poppins(
                color: const Color(0xFF3E69FE),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
            ),),
          ]
      ),
    );
  }
}

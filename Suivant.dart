import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Suivant extends StatelessWidget {


 // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:
            [
              SizedBox(width: 220,),

      ElevatedButton(

      onPressed:() {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3E69FE)),
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
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 16),

        ],
      ),
    )
    ],
    ),
    );

  }
}

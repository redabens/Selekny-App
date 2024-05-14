import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Home/listeimage.dart';
import 'package:reda/Client/Pages/Home/listimag2.dart';
import 'package:reda/Client/Pages/Home/servicepop.dart';
import 'package:reda/Client/Pages/Home/services.dart';
import 'package:reda/Client/Pages/voirtout_page.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  final int type;
  const Body({
    super.key,
    required this.type});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Services(),
            ),
             SizedBox(height:screenHeight*0.020),
            Padding(
              padding: const EdgeInsets.only(left: 24,top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Services à domicile',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                   SizedBox(width:screenWidth*0.24), // Espace entre les deux textes
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoirtoutPage(type: type,)),
                      );
                    },
                    child: Text(
                      'Voir tout',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3E69FE),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF3E69FE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height:screenHeight*0.01), // Espace entre les sections
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 9),
                  child: ImageList2(type: type,),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 9),
                  child: ImageList(type: type,),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 9),
                  child: const Servicepop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
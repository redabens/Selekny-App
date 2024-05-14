import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';

import 'contacter.dart';

class PaymentArtisan extends StatelessWidget {
  const PaymentArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comment effectuer le paiement d''un artisan?',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: screenWidth * 0.055, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        leading: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF33363F),
            size:25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                border: Border.all(
                  color: const Color(0xFF3E69FE).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Le paiement d''un artisan se fait habituellement en espèces, directement entre vous et l''artisan. En cas de problème de paiement, veuillez signaler l\'artisan en mentionnant qu\'il s\'agit d\'un problème de paiement, ou contactez l\'administration "selekny".\n\n',
                    style: GoogleFonts.poppins(fontSize:14, fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Naviguer vers une autre page lorsque le texte est cliqué
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactUsPage()));
                    },
                    child: Text(
                      'Contactez-nous',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xFF3E69FE),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFF3E69FE), // Couleur du soulignement
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height:40),
            Image.asset('assets/pay.jpg',width:screenWidth*0.8,height:screenHeight*0.4),
          ],
        ),
      ),
    );
  }
}
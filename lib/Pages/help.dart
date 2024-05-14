import 'package:flutter/material.dart';
import 'package:reda/Pages/serviceindispo.dart';
import'package:google_fonts/google_fonts.dart';
import 'Annulerrdv.dart';
import 'Payement.dart';
import 'devenirprest.dart';
import 'contacter.dart';
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF33363F),
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Aide', style:GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Colors.white,
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On est là pour vous aider',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: screenHeight *0.04),
              Text(
                'Dites-nous votre problème afin que nous puissions vous aider',
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height:screenWidth*0.04),
              Text(
                'Questions fréquentes:',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: screenHeight*0.04),
              Expanded(
                child: ListView(
                  children: [
                    _buildQuestionItem(
                      context,
                      'Comment devenir prestataire?',
                      Icons.search,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DevenirPrestataire()),
                        );
                      },
                    ),
                    SizedBox(height:screenHeight*0.007),
                    _buildQuestionItem(
                      context,
                      'Un service n''est pas disponible?',
                      Icons.search,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PageServiceIndisponible()),
                        );
                      },
                    ),
                    SizedBox(height:screenHeight*0.007),
                    _buildQuestionItem(
                      context,
                      'Un prestataire a annulé un rendez-vous?',
                      Icons.search,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PageAnnulationRendezVous()),
                        );
                      },
                    ),
                    SizedBox(height:screenHeight*0.007),
                    _buildQuestionItem(
                      context,
                      'Comment effectuer le paiement d''un artisan?',
                      Icons.search,
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentArtisan()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth*0.007),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Vous n''avez pas trouvé votre réponse?',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ContactUsPage()
                          ),
                        );
                      },
                      child: Text(
                        'Contactez-nous',
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
// fonction pour creer les box des question
  Widget _buildQuestionItem(BuildContext context, String question, IconData icon, Function() onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          question,
          style: GoogleFonts.poppins(color: Colors.blue, fontSize: 12),
        ),
        onTap: onPressed,
      ),
    );
  }
}







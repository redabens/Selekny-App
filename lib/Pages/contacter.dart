import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Contactez-nous',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Text(
              'Email:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: screenHeight*0.02),
          Center(
            child: Container(
              width:screenWidth*0.9,
              height:50,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.email,size:20),
                  SizedBox(width: screenWidth*0.02),
                  Text(
                    'SELEKNY@gmail.com',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],

              ),
            ),
          ),
          SizedBox(height: screenHeight*0.04),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Numéro de téléphone:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height:screenHeight*0.01),
          Center(
            child:Container(
              width:screenWidth*0.9,
              height:50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                    _callNumber('+213561303266');
                    },
                    child: const Icon(Icons.phone,size:20),
                  ),
                  SizedBox(width: screenWidth*0.02),
                  Text(
                    '+213561303266',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height:screenHeight*0.28),
          // Visiter notre site web
          Center(
            child: Column(
              children: [
                Text(
                  'Visitez notre site web:',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.selekny.com');
                  },
                  child: Text(
                    'www.selekny.com',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight*0.04),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Image.asset(
            'assets/shape.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top:45,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://www.facebook.com/profile.php?id=61559784200255&mibextid=ZbWKwL');
                  },
                  child: Image.asset('assets/facebook.png', width:screenWidth*0.15, height:screenHeight*0.15),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://www.instagram.com/selek_ny/');
                  },
                  child: Image.asset('assets/insta.png', width:screenWidth*0.15, height:screenHeight*0.15,),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://twitter.com/selekny19');
                  },
                  child: Image.asset('assets/twitter.png', width:screenWidth*0.15, height:screenHeight*0.15),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrlString('https://www.linkedin.com/in/berkoun-lyna-860935268/');
                  },
                  child: Image.asset('assets/linkdin.png', width:screenWidth*0.15, height:screenHeight*0.15),
                ),
              ],
            ),
          ),
          Positioned(
            top: 19,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Contactez nous',
                style: GoogleFonts.poppins(color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour ouvrir une URL
  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Impossible d''ouvrir $url';
    }
  }


  // Fonction pour lancer un appel téléphonique
  _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Impossible de lancer l''appel pour $phoneNumber';
    }
  }

}
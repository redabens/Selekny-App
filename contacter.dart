import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Définir la couleur de fond du Scaffold en blanc
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Contactez-nous',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 10), // Ajout de marge à gauche et en haut
              child: Text(
                'Email:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 14), // Ajout de marge à gauche
              child: Container(
                constraints: BoxConstraints(maxWidth: 330),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text(
                      'example@example.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 14), // Ajout de marge à gauche
              child: Text(
                'Numéro de téléphone:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 14), // Ajout de marge à gauche
              child: Container(
                constraints: BoxConstraints(maxWidth: 330),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text(
                      '+1234567890',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 280),
            // Visiter notre site web
            Center(
              child: Column(
                children: [
                  Text(
                    'Visitez notre site web:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'www.selekny.com',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 170),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Image.asset(
            'assets/shape.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launch('https://www.facebook.com'); // URL pour Facebook
                  },
                  child: Image.asset('assets/facebook.png', width: 50, height:50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://www.instagram.com/direct/t/106854544044585/'); // URL pour Instagram
                  },
                  child: Image.asset('assets/insta.png', width: 50, height: 50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://twitter.com'); // URL pour Twitter
                  },
                  child: Image.asset('assets/twitter.png', width: 50, height: 50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://www.linkedin.com'); // URL pour LinkedIn
                  },
                  child: Image.asset('assets/linkdin.png', width:50, height: 50),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Contactez nous',
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
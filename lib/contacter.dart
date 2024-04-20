import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ContactUsApp());
}

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Contactez-nous',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
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
            padding: const EdgeInsets.only(left: 15),
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
            padding: const EdgeInsets.only(left: 15),
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
            padding: const EdgeInsets.only(left: 15),
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
                  GestureDetector(
                    onTap: () {
                      _callNumber('+2134567890'); // Remplacez le numéro par votre numéro de téléphone
                    },
                    child: Icon(Icons.phone),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '+2134567890',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 250),
          // Visiter notre site web
          Center(
            child: Column(
              children: [
                Text(
                  'Visitez notre site web:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                    style: TextStyle(
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
          SizedBox(height: 20),
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
            top: 70,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launch('https://www.facebook.com');
                  },
                  child: Image.asset('assets/facebook.png', width: 50, height: 50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://www.instagram.com/lynaberkoun/');
                  },
                  child: Image.asset('assets/insta.png', width: 50, height: 50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://www.instagram.com/lynaberkoun/');
                  },
                  child: Image.asset('assets/twitter.png', width: 50, height: 50),
                ),
                GestureDetector(
                  onTap: () {
                    launch('https://www.linkedin.com/in/berkoun-lyna-860935268/');
                  },
                  child: Image.asset('assets/linkdin.png', width: 50, height: 50),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
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

  // Fonction pour ouvrir une URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible d\'ouvrir $url';
    }
  }


  // Fonction pour lancer un appel téléphonique
  _callNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer l\'appel pour $phoneNumber';
    }
  }
}
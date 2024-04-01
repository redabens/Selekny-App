import 'package:flutter/material.dart';
import 'package:selek/pages/home/home.dart';

class Sauvegarde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/envoye.png', // corrected asset name
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sauvegarde avec succès',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Retour à l\'accueil',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
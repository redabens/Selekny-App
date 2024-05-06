import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Pages/authentification/inscription.dart';
class Banni extends StatefulWidget {
  const Banni({super.key});

  @override
  BanniState createState() => BanniState();
}
class BanniState extends State<Banni>{


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
                'assets/banni2.png', // corrected asset name
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Vous avez etés Bloqué!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            const SizedBox(height: 10),
            const Text(
              "Veuillez retourner à la page d'Inscription.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const InscriptionPage()),
                );
              },
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
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
  @override
  void dispose() {
    super.dispose();
    if(FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
    }
  }
}
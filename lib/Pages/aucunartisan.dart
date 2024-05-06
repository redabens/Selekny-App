
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/authentification/connexion.dart';
class AucunArtisan extends StatefulWidget {
  const AucunArtisan({super.key});

  @override
  AucunArtisanState createState() => AucunArtisanState();
}
class AucunArtisanState extends State<AucunArtisan>{

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
                'assets/pointexclamation.png', // corrected asset name
                fit: BoxFit.cover,
                width: 225,
                height: 225,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Aucun artisan trouvé!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              "Veuillez retourner à la page d'accueil.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
}
import 'package:flutter/material.dart';

class Selekny extends StatefulWidget {
  const Selekny({super.key});
  @override
  State<Selekny> createState() => SeleknyState();
}

class SeleknyState extends State<Selekny> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond blanche
      body: Center( // Centre le contenu
        child: Image.asset(
          'assets/logo1.png', // Remplacez par votre chemin d'image
          width: 300, // Ajustez la taille selon vos besoins
          height: 300,
        ),
      ),
    );
  }
}
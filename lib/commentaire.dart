import 'package:flutter/material.dart';
import 'package:selek/pages/details/detailcomm.dart';
import 'package:selek/pages/home/home.dart';

class Commentaire extends StatelessWidget {
  const Commentaire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Commentaires',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white, // Définir la couleur de fond du Scaffold sur blanc
      body: ListView(

        children: [
          Container(
            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'Berkoun Lyna',
              starRating: 3,
              comment: 'Bonjour je suis vraiment satisfaite par votre travail profetionnel merci infiniment',
              profileImage: 'assets/peintre.png',
              date: '23/04/2023',
              time: '10:55',
            ),
          ),
          Container(
            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'Iratni Sara',
              starRating: 5,
              comment: 'Super ! ',
              profileImage: 'assets/electricite.png',
              date: '24/04/2023',
              time: '11:30',
            ),
          ),
          Container(
            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'reda bensemane',
              starRating: 5,
              comment: 'travail magnifique ya kho ',
              profileImage: 'assets/Plomberie.png',
              date: '24/04/2023',
              time: '11:30',
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0),
            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'Yousra fouanat',
              starRating: 4,
              comment: 'trés bon travail ! ',
              profileImage: 'assets/electricite.png',
              date: '24/04/2023',
              time: '11:30',
            ),
          ),
          Container(
            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'Bachir Rachad',
              starRating: 2,
              comment: 'ma3djebnich bezaf deçu!!!!! ',
              profileImage: 'assets/electricite.png',
              date: '24/04/2023',
              time: '11:30',
            ),
          ),
          Container(

            color: Colors.white, // Définir la couleur de fond du conteneur sur blanc
            child: Detcommentaire(
              userName: 'Berkoun Imene',
              starRating: 3,
              comment: 'Super expérience! merci a vous ',
              profileImage: 'assets/electricite.png',
              date: '24/04/2023',
              time: '11:30',
            ),
          ),
          // Ajoutez d'autres commentaires ici
        ],
      ),
    );
  }
}
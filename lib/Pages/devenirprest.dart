import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';
class DevenirPrestataire extends StatefulWidget {
  const DevenirPrestataire({super.key});

  @override
  DevenirPrestataireState createState() => DevenirPrestataireState();
}

class DevenirPrestataireState extends State<DevenirPrestataire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ajustement
          children: [
            Container(
              color: Colors.white, // Ajout de la couleur de fond
              child: const Comment(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              color: Colors.white, // Ajout de la couleur de fond
              child: const Pourquoi(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('Devenir prestataire'),
      leading: IconButton(
        icon: Image.asset('assets/retour.png'), // Remplacez 'icons/retour.png' par le chemin de votre image
        onPressed: () {
          Navigator.of(context).pop(); // Revenir à la page précédente lorsque l'image est cliquée
        },
      ),
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Comment Devenir un prestataire?',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset('assets/commentn.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Si vous êtes intéressé à rejoindre notre application en tant que prestataire, '
                          'veuillez soumettre votre candidature en personne à notre bureau administratif situé à ...  \n'
                          '\n'
                          'Assurez-vous d\'apporter une copie de votre CV, vos certificats de qualification '
                          'et toute autre documentation pertinente. \n'
                          '\n'
                          'Notre équipe d\'administration examinera attentivement chaque candidature soumise en personne.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Pourquoi extends StatelessWidget {
  const Pourquoi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Pourquoi nous rejoindre en tant que prestataire ?',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/pourquoi.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'En devenant prestataire sur notre plateforme, vous bénéficierez de :\n'
                              ' - Visibilité accrue auprès des clients potentiels.\n'
                              ' - Accès à un large réseau de clients.\n'
                              ' - Opportunité de développer votre activité.\n'
                              ' - Possibilité d\'augmenter vos revenus.\n',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.032,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rejoignez-nous dès aujourd\'hui pour faire partie de notre communauté d\'artisans de confiance !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
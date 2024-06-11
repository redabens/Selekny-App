import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ce n'est pas vraiment la homepage mais la page plomberie
class DevenirPrestataire extends StatefulWidget {
  const DevenirPrestataire({super.key});

  @override
  DevenirPrestataireState createState() => DevenirPrestataireState();
}

class DevenirPrestataireState extends State<DevenirPrestataire> {
  @override

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Comment(),
              SizedBox( height:screenHeight*0.05,),
              Pourquoi(),
              SizedBox( height:screenHeight*0.02,),
            ]
        ),
      ),

    );
  }
}




class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        AppBar(
          //backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Devenir Prestataire',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: screenWidth*0.010),
            ],
          ),
        ),
      ],
    );
  }
}
class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: screenHeight*0.485,
            width: screenWidth*0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
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
                          padding: const EdgeInsets.only(left:15.0,right:15),
                          child: Text(
                            'Comment Devenir un prestataire?',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Image.asset('assets/commentn.png'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
                        fontSize: 12,
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
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // Ajoutez cette ligne pour ajuster la marge supérieure
            height:screenHeight*0.6,
            width: screenWidth*0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left:15.0,right:15),
                          child: Text(
                            'Pourquoi nous rejoindre en tant que prestataire ?',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/pourquoi.png'),
                          // Remplacer par votre image
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'En devenant prestataire sur notre plateforme, vous bénéficierez de :\n'
                              ' - Visibilité accrue auprès des clients potentiels.\n'
                              ' - Accès à un large réseau de clients.\n'
                              ' - Opportunité de développer votre activité.\n'
                              ' - Possibilité d\'augmenter vos revenus.\n',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height:screenHeight*0.02), // Espace entre les textes
                        Text(
                          'Rejoignez-nous dès aujourd\'hui pour faire partie de notre communauté d\'artisans de confiance !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
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
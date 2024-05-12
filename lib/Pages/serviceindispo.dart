import 'package:flutter/material.dart';
import'package:google_fonts/google_fonts.dart';
import 'contacter.dart';
class PageServiceIndisponible extends StatelessWidget {
  const PageServiceIndisponible({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Un service n''est pas disponible?',

          style: GoogleFonts.poppins(color: Colors.black, fontSize: screenWidth * 0.055, fontWeight: FontWeight.w700), // Couleur du texte de l'AppBar
        ),
        backgroundColor: Colors.white, // Fond de l'AppBar en blanc
        leading: IconButton(
          icon: Image.asset('assets/retour.png'), // Remplacez 'assets/back_arrow.png' par le chemin de votre image
          onPressed: () {
            Navigator.pop(context); // Revenir à la page précédente lorsque l'image est cliquée
          },
        ),
      ),
      backgroundColor: Colors.white, // Fond de la page en blanc
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                border: Border.all(
                  color: const Color(0xFF3E69FE).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [ Text(
                  'Vous pouvez vérifier la liste de tout les domaines à partir de :\n'
                      '\n'
                      '- Accédez à la page d''accueil dans la barre de navigation.\n'
                      '- Sélectionnez dans la partie <Service à domicile> l''option <Voir tout>\n'
                      '\n'
                      'Si vous n''avez pas trouvé le service ou le domaine que vous recherchez, veuillez envoyer un message à l\'administration de "Selekny" pour leur suggérer de l\'ajouter s\'il y a des opportunités.',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                  const SizedBox(height:10),
                  GestureDetector(
                    onTap: () {
                      // Naviguer vers une autre page lorsque le texte est cliqué
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ContactUsPage()));
                    },
                    child: Text(
                      'Contactez-nous',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        color: const Color(0xFF3E69FE),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(
                            0xFF3E69FE), // Couleur du soulignement
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Image.asset('assets/ajouterdomaine.png', width: screenWidth*0.9, height:screenHeight*0.3),
          ],
        ),
      ),
    );
  }}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ajouterDomaine.dart';

class Importer extends StatefulWidget {
  const Importer({super.key});

  @override
  _ImporterState createState() => _ImporterState();
}

class _ImporterState extends State<Importer> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          // Fermer le clavier si ouvert et retour à la page précédente
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            const DomainServicePage(),
            Container(
              color: const Color.fromRGBO(128, 128, 128, 0.7),
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.08),
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ajouter le nom du domaine',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Image.asset(
                                'icons/ajoutimage.png',
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        GestureDetector(
                          onTap: () {
                            // Action à effectuer lors de l'importation d'une image
                          },
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Color(0xFF3E69FE),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Importer image',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                  size: screenWidth * 0.06,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(), // Ajouter de l'espace
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Retour à la page précédente
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          color: Color(0xFF3E69FE),
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Center(
                          child: Text(
                            'Terminer',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
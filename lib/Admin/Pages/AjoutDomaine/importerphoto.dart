
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reda/Pages/user_repository.dart';
import '../../Services/Domaine_service.dart';
import 'ajouterDomaine.dart';

class Importer extends StatefulWidget {
  const Importer({super.key});

  @override
  State<Importer> createState() => _ImporterState();
}

class _ImporterState extends State<Importer> {
  final TextEditingController _textController = TextEditingController();
  final DomainesService _domainesService = DomainesService();

  @override
  void initState(){
    super.initState();
    userRepository = UserRepository();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String fileName = '';
  String newUrlImg = '';
  late UserRepository userRepository;

  Future<void> uploadDomainePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70);
      if (image != null) {
        final imageUrl = await userRepository.uploadImage("Domaines/", image);
        // update user image record
        final uri = Uri.parse(imageUrl);
        print(uri);
        fileName = uri.pathSegments.last;
        print(fileName);
        print("FILE NAME : $fileName");
        setState(() {
          newUrlImg = imageUrl;
          print("Url img : $newUrlImg");
        });
      }
    } catch (e) {
      print("There is an error in uploading image in profile : $e");
      // afficher l erreur dans le front
    }
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
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
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
                              child: !newUrlImg.isNotEmpty ?  Image.asset(
                                'assets/ajoutimage.png',
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.15,
                              ) : Image.network(newUrlImg,
                                fit: BoxFit.cover,
                                height: screenHeight * 0.15,
                                width: screenWidth * 0.279,),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        GestureDetector(
                          onTap: () {
                            // Action à effectuer lors de l'importation d'une image
                            uploadDomainePicture();
                          },
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E69FE),
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
                                const SizedBox(width: 8),
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
                    const Spacer(), // Ajouter de l'espace
                    GestureDetector(
                      onTap: () {
                        if(fileName!='' && _textController.value.text != ''){
                          _domainesService.ajouterDomaine(_textController.value.text, fileName);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3E69FE),
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.03),
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

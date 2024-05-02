import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Services/signalement_service.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';
import 'package:reda/Services/Signaler.dart';

class Signaler extends StatefulWidget {
  final String idartisan;
  final String imageUrl;
  final String nomartisan;
  final String phone;
  final String domaine;
  final int rating;
  const Signaler({super.key,  required this.idartisan,
    required this.imageUrl, required this.nomartisan,
    required this.phone, required this.domaine, required this.rating});

  @override
  _SignalerState createState() => _SignalerState();
}
class _SignalerState extends State<Signaler> {
  final TextEditingController _commentController = TextEditingController();
  bool _isWritingComment = true;
  final SignalementsService _signalementsService = SignalementsService();
  @override
  void initState() {
    super.initState();
    _commentController.addListener(_onCommentChanged);
  }

  @override
  void dispose() {
    _commentController.removeListener(_onCommentChanged);
    _commentController.dispose();
    super.dispose();
  }

  void _onCommentChanged() {
    final lines = _commentController.text.split('\n');
    setState(() {
      _isWritingComment = lines.length < 4 || lines.last.length <= 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            ProfilePage2(idartisan: widget.idartisan, imageurl: widget.imageUrl,
              nomartisan: widget.nomartisan, phone: widget.phone, domaine: widget.domaine, rating: widget.rating,), // Page de profil en arrière-plan
            Container(
              color: const Color.fromRGBO(128, 128, 128, 0.7), // Couleur grise semi-transparente
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.08), // Taille proportionnelle
                width: screenWidth * 0.8, // Largeur proportionnelle
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Signalement de : ${widget.nomartisan}',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // Espacement proportionnel
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _commentController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              maxLength: 88, // Limite de caractères
                              decoration: InputDecoration(
                                hintText: 'Veuillez saisir la cause du signalement',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(screenWidth * 0.03),
                              ),
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                height: 1.0,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          ),
                        ],),
                    ),
                    SizedBox(height: screenHeight * 0.02), // Espacement proportionnel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centré horizontalement
                      children: [
                        GestureDetector(
                          onTap:() {
                            _signalementsService.sendSignalement(_commentController.value.text.toString(), widget.idartisan, FirebaseAuth.instance.currentUser!.uid);
                            Navigator.pop(context, MaterialPageRoute(builder: (context)=> ProfilePage2(idartisan: widget.idartisan, imageurl: widget.imageUrl,
                              nomartisan: widget.nomartisan, phone: widget.phone, domaine: widget.domaine, rating: widget.rating,)),);  // Revenir à ProfilePage2
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E69FE), // Couleur bleue
                              borderRadius: BorderRadius.circular(screenWidth * 0.1),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text(
                              'Envoyer',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],),
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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Services/Commentaires/commentaires_service.dart';

class AjouterCommentairePage extends StatefulWidget {
  final String nomPrestataire;
  final String nomprestation;
  final String artisanID;
  const AjouterCommentairePage({
    super.key,
    required this.nomPrestataire,
    required this.artisanID, required this.nomprestation,
  });

  @override
  State<AjouterCommentairePage> createState() => _AjouterCommentairePageState();
}

class _AjouterCommentairePageState extends State<AjouterCommentairePage> {
  int _lastStarIndex = 0; // Index de la dernière étoile cliquée
  final TextEditingController _commentController = TextEditingController();
  final CommentaireService _commentaireService =CommentaireService();
  bool _isWritingComment = true;
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
      _isWritingComment = lines.length < 3 || lines.last.length <= 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              const HomePage(),
              Container(
                color: const Color.fromRGBO(128, 128, 128, 0.7),
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Noter votre prestataire : ${widget.nomPrestataire}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                              (index) => IconButton(
                            iconSize: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            icon: Icon(
                              index < _lastStarIndex ? Icons.star : Icons.star_border,
                              color: index < _lastStarIndex ? Colors.yellow : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _lastStarIndex = index + 1;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                maxLength: 66, // Limite de 150 caractères
                                decoration: const InputDecoration(
                                  hintText: 'Ajouter un commentaire',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    height: 1.0, // Augmenter l'espace entre les lignes

                                    textBaseline: TextBaseline.alphabetic), // Ajout d'un petit espace entre les lignes
                              ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () async {
                                  await _commentaireService.sendCommentaire(widget.artisanID, _commentController.text,_lastStarIndex,widget.nomprestation);
                                  await _commentaireService.updateRating(widget.artisanID, _lastStarIndex);
                                  // clear the text controller after sending the message
                                  _commentController.clear();
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomePage()),
                                  );
                                }
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
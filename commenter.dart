import 'package:flutter/material.dart';
import 'package:selek/pages/home/home.dart';

class Commenter extends StatefulWidget {
  final String nomPrestataire;

  const Commenter({Key? key, required this.nomPrestataire}) : super(key: key);

  @override
  _CommenterState createState() => _CommenterState();
}

class _CommenterState extends State<Commenter> {
  int _lastStarIndex = 0; // Index de la dernière étoile cliquée
  final TextEditingController _commentController = TextEditingController();
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          HomePage(),
          Container(
            color: Color.fromRGBO(128, 128, 128, 0.7),
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => IconButton(
                        iconSize: 40,
                        padding: EdgeInsets.symmetric(horizontal: 1),
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
                  SizedBox(height: 10),
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
                            decoration: InputDecoration(
                              hintText: 'Ajouter un commentaire',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.0, // Augmenter l'espace entre les lignes

                            textBaseline: TextBaseline.alphabetic), // Ajout d'un petit espace entre les lignes
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: _isWritingComment
                              ? null
                              : () {
                            // Gérer l'envoi du commentaire
                          },
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
    );
  }
}
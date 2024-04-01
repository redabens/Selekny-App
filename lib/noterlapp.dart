import 'package:flutter/material.dart';

class Noterapp extends StatefulWidget {
  const Noterapp({Key? key});

  @override
  _NoterappState createState() => _NoterappState();
}

class _NoterappState extends State<Noterapp> {
  int _lastStarIndex = 0; // Index de la dernière étoile cliquée
  final TextEditingController _commentController = TextEditingController();
  bool _isWritingComment = true;
  bool _isSent = false;
  bool _iconButtonEnabled = true;// État pour gérer l'icône d'envoi

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 110),
                child: Text(
                  'Merci !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 10),
                child: Image.asset(
                  'assets/logo.png', // Remplacez 'assets/your_image.png' par le chemin de votre image
                  height: 200, // Ajustez la hauteur de l'image selon vos besoins
                  width: 300, // Ajustez la largeur de l'image selon vos besoins
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top:0,left: 30, right: 30, bottom:20),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.7)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Veuillez laisser une note pour notre application',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                                index < _lastStarIndex
                                    ? Icons.star
                                    : Icons.star_border,
                                color: index < _lastStarIndex
                                    ? Colors.yellow
                                    : Colors.grey,
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
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                maxLength: 100, //Limite de 150 caractères
                                decoration: InputDecoration(
                                  hintText:
                                  'Ajouter un commentaire sur votre experience..',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                ),
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  // Augmenter l'espace entre les lignes
                                  textBaseline: TextBaseline.alphabetic,
                                ), // Ajout d'un petit espace entre les lignes
                              ),
                            ),
                            IconButton(
                              icon: _isSent ? Icon(Icons.check) : Icon(Icons.send),
                              onPressed: _iconButtonEnabled
                                  ? () {
                                setState(() {
                                  _isSent = !_isSent;
                                  _iconButtonEnabled = false; // Désactiver l'action de l'IconButton
                                });
                              }
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50), // Ajout d'un espace entre le commentaire et le bouton
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>page de connexion ()),
                      // );
                      // vers page de connexion
                    },
                    child: Text(
                      'Reconnexion',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(350, 47)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.13),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF3E69FE),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Ajout d'un espace sous le bouton
            ],
          ),
        ),
      ),
    );
  }
}
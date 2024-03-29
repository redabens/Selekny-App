import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Services/Commentaires/commentaires_service.dart';
import 'package:reda/components/Commentaire_container.dart';
import 'package:reda/components/my_text_filed.dart';

class AjoutCommentairePage extends StatefulWidget {
  const AjoutCommentairePage({
    super.key,
    required this.artisanID,
  });
  final String artisanID;
  @override
  State<AjoutCommentairePage> createState() => _AjoutCommentairePageState();
}

class _AjoutCommentairePageState extends State<AjoutCommentairePage> {
  final TextEditingController _commentaireController = TextEditingController();
  final CommentaireService _CommentaireService =CommentaireService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int starRating= 3;
  void ajoutComment() async{
    if(_commentaireController.text.isNotEmpty){
      await _CommentaireService.sendCommentaire((widget.artisanID), _commentaireController.text,starRating);
      // clear the text controller after sending the message
      _commentaireController.clear();
    }
  }
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      String pathImage = userDoc['PathImage'];
      // Retourner le PathImage
      return pathImage;
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return 'default_image_path';
    }
  }
  Future<String> getUserName(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      String userName = userDoc['name'];
      // Retourner le PathImage
      return userName;
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return 'default_name';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reda"),),
      body: Column(
        children:[
          // messages
          Expanded(
            child: _buildCommentList(),
          ),
          // user input
          _buildCommentaireInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
  Widget _buildCommentList(){
    return StreamBuilder(
      stream: _CommentaireService.getCommentaires(widget.artisanID), //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        final documents = snapshot.data!.docs;

        // Print details of each document
        for (var doc in documents) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(snapshot.data!.docs.map((document) => _buildCommentaireItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading comments ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  }
  // build message item
  Future<Widget> _buildCommentaireItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String profileImage = "assets/images/placeholder.png"; // Default image
    String userName = "";
    try {
      profileImage = await getUserPathImage(data['userID']);
      print(profileImage);
      userName = await getUserName(data['userID']);
      print(userName);
    } catch (error) {
      print("Error fetching user image: $error");
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Detcommentaire(userName: userName, starRating: starRating, comment: data['comment'], profileImage: profileImage, timestamp: data['timestamp']),

        ],
      ),
    );
  }
  Widget _buildCommentaireInput(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: [
            // textfield
            Expanded(
              child: MyTextField(
                controller: _commentaireController,
                hinText: 'Ecrire un message...',
                obscureText: false,
              ), // MyTextField
            ),
            IconButton(onPressed: ajoutComment,
              icon: const Icon(
                Icons.arrow_upward,
                size: 40,
              ),
            )
          ],
        )
    );
  }
}

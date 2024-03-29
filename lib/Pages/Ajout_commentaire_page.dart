import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Services/Commentaires/commentaires_service.dart';
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
  final int starRating= 3;
  void ajoutComment() async{
    if(_commentaireController.text.isNotEmpty){
      await _CommentaireService.sendCommentaire((widget.artisanID), _commentaireController.text,starRating);
      // clear the text controller after sending the message
      _commentaireController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reda"),),
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
        print("Stream Data: ${snapshot.data}"); // Add this line for debugging
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
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildCommentaireItem(document)).toList(),
        );
      },
    );
  }
  // build message item
  Widget _buildCommentaireItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data['userID']),
          Text(data['comment']),

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

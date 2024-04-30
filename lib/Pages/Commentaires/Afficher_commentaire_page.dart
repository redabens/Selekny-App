import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/components/Commentaire_container.dart';
import 'package:reda/Services/Commentaires/commentaires_service.dart';

class AfficherCommentairePage extends StatefulWidget {
  const AfficherCommentairePage({
    super.key,
    required this.artisanID,
  });
  final String artisanID;
  @override
  State<AfficherCommentairePage> createState() => _AfficherCommentairePageState();
}

class _AfficherCommentairePageState extends State<AfficherCommentairePage> {
  final TextEditingController _commentaireController = TextEditingController();
  final CommentaireService _commentaireService =CommentaireService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int starRating= 3;
  void ajoutComment() async{
    if(_commentaireController.text.isNotEmpty){
      await _commentaireService.sendCommentaire((widget.artisanID), _commentaireController.text,starRating);
      // clear the text controller after sending the message
      _commentaireController.clear();
    }
  }
  Future<String> getUserPathImage(String userID) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userID).get();

    if (userDoc.exists) {
      String pathImage = userDoc['PathImage'];
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      final url = await reference.getDownloadURL();
      return url;
    } else {
      return 'default_image_url';
    }
  }
  Future<String> getUserName(String userID) async {
    DocumentSnapshot userDoc = await _firestore.collection('User').doc(userID).get();

    if (userDoc.exists) {
      String userName = userDoc['name'];
      return userName;
    } else {
      return 'default_name';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Commentaires',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white, // Définir la couleur de fond du Scaffold sur blanc
      body: Column(
        children:[
          // messages
          const SizedBox(height: 20),
          Expanded(
            child: _buildCommentList(),
          ),
          // user input
          //_buildCommentaireInput(),
          const SizedBox(height: 10),
        ],
      ),
    )
    );
  }
  Widget _buildCommentList(){
    return StreamBuilder(
      stream: _commentaireService.getCommentaires(widget.artisanID), //_firebaseAuth.currentUser!.uid
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
      print("l'url:$profileImage");
      userName = await getUserName(data['userID']);
      print("le nom:$userName");
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
  /*Widget _buildCommentaireInput(){
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
  }*/
}

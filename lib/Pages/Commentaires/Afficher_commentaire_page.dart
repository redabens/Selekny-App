
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final CommentaireService _commentaireService =CommentaireService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final int starRating= 3;
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      print('here');
      String pathImage = userDoc['pathImage'];
      print(pathImage);
      // Retourner le PathImage
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      try {
        // Get the download URL for the user image
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } catch (error) {
        print("Error fetching user image URL: $error");
        return ''; // Default image on error
      }
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return '';
    }
  }
  Future<String> getUserName(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      String userName = userDoc['nom'];
      // Retourner le PathImage
      return userName;
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return 'default_name';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          'Commentaires',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
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
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                        'Vous n''avez aucun Commentaires.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        )
                    )
                );
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  }
  // build message item
  Future<Widget> _buildCommentaireItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String profileImage = ""; // Default image
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
          Detcommentaire(userName: userName,
            starRating: data['starRating'],
            comment: data['comment'],
            profileImage: profileImage,
            timestamp: data['timestamp'],
            prestationName: data['nomprestation'],),

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/ProfilArtisan/contactpage.dart';
import 'package:reda/Client/ProfilArtisan/detailsprofil.dart';
import 'package:reda/Client/ProfilArtisan/signaler.dart';
import 'package:reda/Client/Services/getartisan.dart';
import 'package:reda/Pages/Chat/chat_page.dart';
import 'package:reda/Pages/Commentaires/Afficher_commentaire_page.dart';

class ProfilePage2 extends StatefulWidget {
  final String adresse;
  final String idartisan;
  final String imageurl;
  final String nomartisan;
  final String phone;
  final String domaine;
  final int rating;
  const ProfilePage2({super.key, required this.idartisan,
    required this.imageurl, required this.nomartisan,
    required this.phone, required this.domaine,
    required this.rating, required this.adresse});
  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ProfileBody2(
          photoPath: widget.imageurl, // Use data! after null check
          name: widget.nomartisan,
          domaine:widget.domaine,
          phone: widget.phone,
          rating: widget.rating.toString(),
          workCount:45,
          onContact: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(receiverUserID: widget.idartisan, currentUserId: FirebaseAuth.instance.currentUser!.uid,
                    type: 1, userName: widget.nomartisan, profileImage: widget.imageurl, otheruserId: widget.idartisan, phone: widget.phone,
                    adresse: widget.adresse, domaine: widget.domaine, rating: widget.rating), // Navigation to ContactPage
              ),
            );
          },
          onReport: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signaler(idartisan: widget.idartisan, imageUrl: widget.imageurl,
                  nomartisan: widget.nomartisan, phone: widget.phone, domaine: widget.domaine, rating: widget.rating, adresseartisan: widget.adresse,), // Navigation to ReportPage
              ),
            );
          },
          onComment:(){
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => AfficherCommentairePage(artisanID: widget.idartisan), // Navigation to ContactPage
              ),
            );
          },
          onPrestation:() { Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactPage(), // Navigation to ContactPage
            ),
          );
          },
        ),
      ),
    );
  }
}
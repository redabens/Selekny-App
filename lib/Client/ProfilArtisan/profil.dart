
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/ProfilPrestationPage.dart';
import 'package:reda/Client/ProfilArtisan/detailsprofil.dart';
import 'package:reda/Client/ProfilArtisan/signaler.dart';
import 'package:reda/Pages/Chat/chat_page.dart';
import 'package:reda/Pages/Commentaires/Afficher_commentaire_page.dart';

class ProfilePage2 extends StatefulWidget {
  final String nomArtisan;
  final String tokenClient;
  final String nomClient;
  final String tokenArtisan;
  final String adresse;
  final String idartisan;
  final String imageurl;
  final String phone;
  final String domaine;
  final double rating;
  final int workcount;
  final bool vehicule;
  const ProfilePage2({super.key, required this.idartisan,
    required this.imageurl,
    required this.phone, required this.domaine,
    required this.rating, required this.adresse,
    required this.workcount, required this.vehicule, required this.nomClient, required this.tokenArtisan, required this.nomArtisan, required this.tokenClient});
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
          name: widget.nomArtisan,
          domaine:widget.domaine,
          phone: widget.phone,
          rating: widget.rating.toString(),
          isVehicled: widget.vehicule,
          workCount:widget.workcount,
          onContact: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(receiverUserID: widget.idartisan, currentUserId: FirebaseAuth.instance.currentUser!.uid,
                    type: 1, userName: widget.nomArtisan, profileImage: widget.imageurl, otheruserId: widget.idartisan, phone: widget.phone,
                    adresse: widget.adresse, domaine: widget.domaine, rating: widget.rating, workcount: widget.workcount,
                  vehicule: widget.vehicule, nomArtisan: widget.nomArtisan,nomClient: widget.nomClient,
                  tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,), // Navigation to ContactPage
              ),
            );
          },
          onReport: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signaler(idartisan: widget.idartisan, imageUrl: widget.imageurl, phone: widget.phone, domaine: widget.domaine,
                  rating: widget.rating, adresseartisan: widget.adresse, workcount: widget.workcount, vehicule: widget.vehicule,
                  nomArtisan: widget.nomArtisan,nomClient: widget.nomClient,
                  tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,), // Navigation to ReportPage
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
              builder: (context) => ProfilPrestationPage(idartisan: widget.idartisan), // Navigation to ContactPage
            ),
          );
          },
        ),
      ),
    );
  }
}
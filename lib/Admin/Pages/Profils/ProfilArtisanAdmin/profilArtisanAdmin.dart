import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/ProfilPrestationPage.dart';
import 'package:reda/Admin/Pages/Profils/ProfilArtisanAdmin/detailsprofilArtisanAdmin.dart';
import 'package:reda/Client/ProfilArtisan/signaler.dart';
import 'package:reda/Pages/Chat/chat_page.dart';
import 'package:reda/Pages/Commentaires/Afficher_commentaire_page.dart';

class ProfilePage2CoteAdmin extends StatefulWidget {
  final String adresse;
  final String idartisan;
  final String imageurl;
  final String nomartisan;
  final String phone;
  final String domaine;
  final double rating;
  final int workcount;
  final bool vehicule;
  const ProfilePage2CoteAdmin({super.key, required this.idartisan,
    required this.imageurl, required this.nomartisan,
    required this.phone, required this.domaine,
    required this.rating, required this.adresse,
    required this.workcount, required this.vehicule});
  @override
  State<ProfilePage2CoteAdmin> createState() => _ProfilePage2CoteAdminState();
}

class _ProfilePage2CoteAdminState extends State<ProfilePage2CoteAdmin> {

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
        child: ProfileBody2CoteAdmin(
          photoPath: widget.imageurl, // Use data! after null check
          name: widget.nomartisan,
          domaine:widget.domaine,
          phone: widget.phone,
          rating: widget.rating,
          isVehicled: widget.vehicule,
          workCount:widget.workcount,
          userID: widget.idartisan,
          onContact: () {
          },
          onReport: () {

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
          }, adresse: widget.adresse,
        ),
      ),
    );
  }
}
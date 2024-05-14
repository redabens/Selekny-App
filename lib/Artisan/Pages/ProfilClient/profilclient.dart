import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/ProfilClient/contactpage.dart';
import 'package:reda/Artisan/Pages/ProfilClient/details.dart';
import 'package:reda/Artisan/Pages/ProfilClient/signaler.dart';
import 'package:reda/Pages/Chat/chat_page.dart'; // Ensure correct path to ProfileBody

class ProfilePage1 extends StatelessWidget {
  final String nomArtisan;
  final String tokenArtisan;
  final String tokenClient;
  final String idclient;
  final String image;
  final String nomClient;
  final String phone;
  final String adress;
  final bool isVehicled;
  const ProfilePage1({super.key, required this.image,
    required this.nomClient, required this.phone,
    required this.adress, required this.idclient, required this.isVehicled,
    required this.nomArtisan, required this.tokenClient, required this.tokenArtisan});

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
        child: ProfileBody(
          photoPath: image, // Direct photo path
          name: nomClient, // Direct name value
          phone: phone, // Direct phone value
          address: adress, // Direct address value
          isVehicled: isVehicled, // Indicates if the person has a vehicle
          onContact: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(receiverUserID: idclient, currentUserId:FirebaseAuth.instance.currentUser!.uid,
                  type: 2, userName: nomClient,
                  profileImage: image, otheruserId: idclient, phone: phone, adresse: adress, domaine: 'domaine',
                  rating: 4, workcount: 0, vehicule: isVehicled,nomArtisan: nomArtisan,nomClient: nomClient,
                  tokenArtisan: tokenArtisan,tokenClient: tokenClient,), // Navigation to ContactPage
              ),
            );
          },
          onReport: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signaler(image: image, nomClient: nomClient, phone: phone, adress: adress, idclient: idclient, isVehicled: isVehicled,
                  nomArtisan: nomArtisan,tokenClient: tokenClient, tokenArtisan: tokenArtisan,), // Navigation to ReportPage
              ),
            );
          },
        ),
      ),
    );
  }
}
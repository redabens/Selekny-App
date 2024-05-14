import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/BloquerClient.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/detailsProfilCllientAdmin.dart';
import 'package:reda/Artisan/Pages/ProfilClient/details.dart';
import 'package:reda/Pages/Chat/chat_page.dart'; // Ensure correct path to ProfileBody

class ProfilePage1CoteAdmin extends StatelessWidget {
  final String idclient;
  final String image;
  final String nomClient;
  final String phone;
  final String adress;
  final bool isVehicled;
  const ProfilePage1CoteAdmin({super.key, required this.image,
    required this.nomClient, required this.phone,
    required this.adress, required this.idclient, required this.isVehicled});

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
        child: ProfileBodyClientCoteAdmin(
          userID: idclient,
          photoPath: image,
          name: nomClient,
          phone: phone,
          address: adress,
          isVehicled: isVehicled,
          onContact: () {
          },
          onReport: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BloquerClient(idclient: idclient, image: image, nomClient: nomClient, phone: phone, adress: adress, isVehicled: isVehicled)
              ),
            );
          },
        ),
      ),
    );
  }
}
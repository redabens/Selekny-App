
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/BloquerClient.dart';
import 'package:reda/Admin/Pages/Profils/ProfilClientAdmin/detailsProfilCllientAdmin.dart';

class ProfilePage1CoteAdmin extends StatelessWidget {
  final String idclient;
  final String image;
  final String nomClient;
  final String email;
  final String phone;
  final String adress;
  final bool isVehicled;
  const ProfilePage1CoteAdmin({super.key, required this.image,
    required this.nomClient, required this.phone, required this.email,
    required this.adress, required this.idclient, required this.isVehicled});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.08, // Taille proportionnelle
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ProfileBodyClientCoteAdmin(
          userID: idclient,
          photoPath: image,
          email: email,
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
                builder: (context) => BloquerClient(idclient: idclient, image: image, nomClient: nomClient, phone: phone, adress: adress, isVehicled: isVehicled, email:email,)
              ),
            );
          },
        ),
      ),
    );
  }
}
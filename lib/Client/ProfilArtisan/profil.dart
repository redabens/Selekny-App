import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/ProfilArtisan/contactpage.dart';
import 'package:reda/Client/ProfilArtisan/detailsprofil.dart';
import 'package:reda/Client/ProfilArtisan/signaler.dart';
import 'package:reda/Client/Services/getartisan.dart';

class ProfilePage2 extends StatefulWidget {
  final String idartisan;
  final String imageurl;
  final String nomartisan;
  final String phone;
  final String domaine;
  const ProfilePage2({super.key, required this.idartisan, required this.imageurl, required this.nomartisan, required this.phone, required this.domaine});
  @override
  State<ProfilePage2> createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // ... (rest of AppBar code)
      ),
      body: SingleChildScrollView(
        child: ProfileBody2(
          photoPath: widget.imageurl, // Use data! after null check
          name: widget.nomartisan,
          domaine:widget.domaine,
          phone: widget.phone,
          //rating: data!['rating'].toString(),
          workCount:45,
          onContact: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactPage(), // Navigation to ContactPage
              ),
            );
          },
          onReport: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signaler(idartisan: widget.idartisan, imageUrl: widget.imageurl,
                  nomartisan: widget.nomartisan, phone: widget.phone, domaine: widget.domaine,), // Navigation to ReportPage
              ),
            );
          },
          onComment:(){
            Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => ContactPage(), // Navigation to ContactPage
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
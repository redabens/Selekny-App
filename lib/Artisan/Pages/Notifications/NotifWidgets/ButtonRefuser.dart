import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeClientService.dart';

class Buttonrefuser extends StatefulWidget {
  final String idclient;
  final Timestamp timestamp;
  final int type;
  const Buttonrefuser({super.key, required this.timestamp, required this.type, required this.idclient});

  @override
  ButtonrefuserState createState() => ButtonrefuserState();
}

class ButtonrefuserState extends State<Buttonrefuser> {
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
  final DemandeClientService _demandeClientService = DemandeClientService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: widget.type == 1? TextButton(
        onPressed:() async {
          _demandeArtisanService.deleteDemandeArtisan(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
          await Future.delayed(const Duration(milliseconds: 100));
        },// hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'refuser',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: const ImageIcon(
                AssetImage('assets/close.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ) : TextButton(
        onPressed:() async {
          _demandeArtisanService.deleteRendezVous(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
          _demandeClientService.deleteRendezVous(widget.timestamp, widget.idclient);
          await Future.delayed(const Duration(milliseconds: 100));
        },// hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'annuler',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: const ImageIcon(
                AssetImage('assets/close.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      )
    );
  }
}
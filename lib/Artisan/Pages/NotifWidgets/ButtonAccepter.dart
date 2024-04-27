import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeClientService.dart';
class Buttonaccepter extends StatefulWidget {
  final String datedebut;
  final String datefin;
  final String heuredebut;
  final String heurefin;
  final String adresse;
  final String iddomaine;
  final String idprestation;
  final String idclient;
  final bool urgence;
  final double latitude;
  final double longitude;
  final Timestamp timestamp;
  const Buttonaccepter({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude,
    required this.timestamp});

  @override
  ButtonaccepterState createState() => ButtonaccepterState();
}

class ButtonaccepterState extends State<Buttonaccepter> {
  Color _buttonColor = const Color(0xFF49F77A);
  Color _textColor = Colors.black;
  final DemandeClientService _demandeClientService = DemandeClientService();
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
  void _changeColor() {
    setState(() {
      _buttonColor = const Color(0xFFF6F6F6);
      _textColor = const Color(0xFFC4C4C4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: (){
        _demandeClientService.sendDemandeClient(widget.datedebut, widget.datefin,
            widget.heuredebut, widget.heurefin,
            widget.adresse, widget.iddomaine,
            widget.idprestation, widget.idclient,
            widget.urgence, widget.latitude, widget.longitude,);
        _demandeArtisanService.sendRendezVous(widget.datedebut, widget.datefin,
            widget.heuredebut, widget.heurefin,
            widget.adresse, widget.iddomaine,
            widget.idprestation, widget.idclient,
            widget.urgence, widget.latitude, widget.longitude, FirebaseAuth.instance.currentUser!.uid);
        _demandeArtisanService.deleteDemandeArtisan(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'accepter',
              style: GoogleFonts.poppins(
                color: _textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: ImageIcon(
                const AssetImage('assets/done.png'),
                color: _textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
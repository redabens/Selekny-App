import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/PubDemande/DemandeEnvoyeInit.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeClientService.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeEncours_service.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Services/notifications.dart';
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
  final String demandeid;
  final String nomArtisan;
  final String nomPrestation;
  const Buttonaccepter({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude,
    required this.timestamp, required this.demandeid,
    required this.nomArtisan, required this.nomPrestation});

  @override
  ButtonaccepterState createState() => ButtonaccepterState();
}

class ButtonaccepterState extends State<Buttonaccepter> {
  Color _buttonColor = const Color(0xFF49F77A);
  Color _textColor = Colors.black;
  final DemandeClientService _demandeClientService = DemandeClientService();
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
  final DemandeEncoursService _demandeEncoursService = DemandeEncoursService();
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
      child:  TextButton(
        onPressed: () async {
          String token =
          await UserRepository.instance.getTokenById(widget.idclient);

          print("Token du client  : $token");

          await getNomPrestationById(widget.iddomaine, widget.idprestation);

          NotificationServices.sendPushNotification(
              token,"AccepteParArtisan",
              "Votre demande a été accepté par ${widget.nomArtisan}",
              "Service demandé : $nomPrestation",);
        _demandeClientService.sendDemandeClient(widget.datedebut, widget.datefin,
            widget.heuredebut, widget.heurefin,
            widget.adresse, widget.iddomaine,
            widget.idprestation, widget.idclient, FirebaseAuth.instance.currentUser!.uid,
            widget.urgence, widget.latitude, widget.longitude,);
        _demandeArtisanService.deleteDemandeArtisan(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
        _demandeEncoursService.deleteDemande(widget.demandeid);
        await Future.delayed(const Duration(milliseconds: 100));
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

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/ButtonAccepter.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/ButtonRefuser.dart';
class Buttonaccruf extends StatelessWidget {
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
  final String nomPrestation;
  final String nomArtisan;
  const Buttonaccruf({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude,
    required this.timestamp,
    required this.demandeid, required this.nomArtisan, required this.nomPrestation});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth*0.468,
        height: 30,
        //color: Colors.black,
        child:Row(
          children: [
            Buttonaccepter(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude,
              longitude: longitude, timestamp: timestamp,
              demandeid: demandeid, nomArtisan: nomArtisan,
              nomPrestation: nomPrestation,),
            SizedBox(width: screenWidth*0.01,),
            Buttonrefuser( timestamp: timestamp, idclient: idclient, demandeid: demandeid,),
          ],
        )
    );
  }

}
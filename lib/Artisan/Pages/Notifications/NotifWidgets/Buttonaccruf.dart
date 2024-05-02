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
  final int type;
  final String nomPrestation;
  final String nomArtisan;
  const Buttonaccruf({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude,
    required this.timestamp, required this.type,
    required this.demandeid, required this.nomArtisan, required this.nomPrestation});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 30,
        //color: Colors.black,
        child:Row(
          children: [
            const SizedBox(width: 18,),
            Buttonaccepter(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude,
              longitude: longitude, timestamp: timestamp,
              demandeid: demandeid, nomArtisan: nomArtisan,
              nomPrestation: nomPrestation,),
            const SizedBox(width: 2,),
            Buttonrefuser( timestamp: timestamp, type: type, idclient: idclient, demandeid: demandeid,),
          ],
        )
    );
  }

}
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/ActiviteWidget/ButtonActivite.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/ButtonRefuser.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Buttonaccruf.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/EnvoyerILya.dart';
class Detailsbottom extends StatelessWidget {
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
  final int type1;
  final int type2;
  const Detailsbottom({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude, required this.timestamp, required this.type1, required this.type2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 390,
        height: 35,
        //color: Colors.black,
        child: type1 == 1 ? Row(
          children: [
            Envoyerilya(timestamp: timestamp,),
            const Spacer(),
            Buttonaccruf(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude,
              longitude: longitude, timestamp: timestamp, type: 1,), //hado bouton accepter refuser
            const SizedBox(width: 8,),
          ],
        )
            : type2 == 2? Row(
          children: [
            Envoyerilya(timestamp: timestamp,),
            const Spacer(),
            Buttonrefuser(timestamp: timestamp, type: 2, idclient: idclient,), //hado bouton accepter refuser
            const SizedBox(width: 8,),
          ],
        ): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Buttontraiterannuler(idclient: idclient, timestamp: timestamp,),
              const SizedBox(width: 8,),
            ])
    );
  }

}
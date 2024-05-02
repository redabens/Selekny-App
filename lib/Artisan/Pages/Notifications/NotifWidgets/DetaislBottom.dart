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
  final String idartisan;
  final bool urgence;
  final double latitude;
  final double longitude;
  final Timestamp timestamp;
  final String demandeid;
  final String sync;
  final int type1;
  final int type2;
  final String nomPrestation;
  final String nomArtisan;
  const Detailsbottom({super.key, required this.datedebut,
    required this.datefin, required this.heuredebut,
    required this.heurefin, required this.adresse,
    required this.iddomaine, required this.idprestation,
    required this.idclient, required this.urgence,
    required this.latitude, required this.longitude,
    required this.timestamp, required this.type1,
    required this.type2, required this.demandeid,
    required this.sync, required this.nomArtisan,
    required this.nomPrestation, required this.idartisan});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        //height: 35,
        child: type1 == 1 ? Row(
          children: [
            Envoyerilya(timestamp: timestamp, sync: sync,),
            const Spacer(),
            Buttonaccruf(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude,
              longitude: longitude, timestamp: timestamp, type: 1,
              demandeid: demandeid, nomArtisan: nomArtisan, nomPrestation: '',), //hado bouton accepter refuser
            const SizedBox(width: 8,),
          ],
        )
            : type2 == 2? Row(
          children: [
            Envoyerilya(timestamp: timestamp, sync: sync,),
            const Spacer(),
            Buttonrefuser(timestamp: timestamp, type: 2, idclient: idclient, demandeid: demandeid,), //hado bouton accepter refuser
            const SizedBox(width: 8,),
          ],
        ): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Buttontraiterannuler(idclient: idclient, timestamp: timestamp,
                datefin: datefin, datedebut: datedebut, location: adresse,
                heuredebut: heuredebut, heurefin: heurefin, iddomaine: iddomaine,
                idprestation: idprestation, idartisan: idartisan, urgence: urgence,
                longitude: longitude, latitude: latitude,),
              const SizedBox(width: 8,),
            ])
    );
  }

}
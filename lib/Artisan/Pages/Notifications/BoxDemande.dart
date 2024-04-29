import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Date.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/DetaislBottom.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Heure.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Lieu.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/NomPrestation.dart';
class BoxDemande extends StatelessWidget {
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
  final String nomprestation;
  final String imageUrl;
  final int type1;
  final int type2;

  const BoxDemande({
    super.key, required this.datedebut,required this.datefin,
    required this.heuredebut, required this.heurefin,
    required this.adresse, required this.iddomaine,
    required this.idprestation, required this.idclient,
    required this.urgence, required this.latitude,
    required this.longitude, required this.timestamp,
    required this.nomprestation, required this.imageUrl, required this.type1, required this.type2,});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 2.0,
        ),
      ),
      child:Column(
          children:
          [
            Pdpanddetails(nomprestation: nomprestation, idClient: idclient,
              datedebut: datedebut,heuredebut: heuredebut,
              adresse: adresse, imageUrl: imageUrl, type: type1, urgence: urgence,),
            Detailsbottom(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude, longitude: longitude,
              timestamp: timestamp, type1: type1, type2: type2,),
          ]


      ),
    );
  }
}
class Pdpanddetails extends StatelessWidget {
  final String imageUrl;
  final String idClient;
  final String nomprestation;
  final String datedebut;
  final String heuredebut;
  final String adresse;
  final int type;
  final bool urgence;
  const Pdpanddetails({super.key, required this.nomprestation, required this.idClient,
    required this.datedebut, required this.heuredebut, required this.adresse,
    required this.imageUrl, required this.type, required this.urgence,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 95,
      // color: Colors.green,

      child: Row(
          children:
          [
            const SizedBox(width: 4,),
            Pdp(imageUrl: imageUrl,),
            Details(nomprestation: nomprestation, adresse: adresse,
              datedebut: datedebut, heuredebut: heuredebut,type: type, urgence: urgence,),
          ]
      ),


    );
  }

}


class Pdp extends StatelessWidget {
  final String imageUrl;
  const Pdp({super.key, required this.imageUrl,});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      //color: Colors.yellow,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )

      ),



      //inserer la photode profil hna ki tjibha m bdd

    );
  }

}
class Details extends StatelessWidget {
  final String nomprestation;
  final String adresse;
  final String datedebut;
  final String heuredebut;
  final int type;
  final bool urgence;
  const Details({super.key, required this.nomprestation,
    required this.adresse, required this.datedebut,
    required this.heuredebut, required this.type,
    required this.urgence});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 280,
        height: 95,
        //color: Colors.red,
        child: Column(
            children:
            [
              NomPrestation(nomprestation: nomprestation,),
              Lieu(adresse: adresse,),
              Date(datedebut: datedebut, type: type, urgence: urgence,),
              Heure(heuredebut: heuredebut, type: type, urgence: urgence,),
            ]
        )
    );
  }
}
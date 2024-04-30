import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Date.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/DetaislBottom.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Heure.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/Lieu.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifWidgets/NomPrestation.dart';
import 'package:reda/Artisan/Pages/ProfilClient/profilclient.dart';
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
  final String nomclient;
  final String phone;
  final int type1;
  final int type2;

  const BoxDemande({
    super.key, required this.datedebut,required this.datefin,
    required this.heuredebut, required this.heurefin,
    required this.adresse, required this.iddomaine,
    required this.idprestation, required this.idclient,
    required this.urgence, required this.latitude,
    required this.longitude, required this.timestamp,
    required this.nomprestation, required this.imageUrl, required this.type1, required this.type2, required this.nomclient, required this.phone,});
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
              adresse: adresse, imageUrl: imageUrl, type: type1, urgence: urgence, nomclient: nomclient, phone: phone,),
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
  final String nomclient;
  final String phone;
  //final bool isvehiculed;
  final int type;
  final bool urgence;
  const Pdpanddetails({super.key, required this.nomprestation, required this.idClient,
    required this.datedebut, required this.heuredebut, required this.adresse,
    required this.imageUrl, required this.type, required this.urgence, required this.nomclient, required this.phone,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 95,
      // color: Colors.green,

      child: Row(
          children:
          [
            const SizedBox(width: 4,),
            Pdp(imageUrl: imageUrl, adresse:adresse, phone: phone, nomclient: nomclient,),
            Details(nomprestation: nomprestation, adresse: adresse,
              datedebut: datedebut, heuredebut: heuredebut,type: type, urgence: urgence,),
          ]
      ),


    );
  }

}


class Pdp extends StatelessWidget {
  final String imageUrl;
  final String adresse;
  final String phone;
  final String nomclient;
  //final String isvehiculed;
  const Pdp({super.key, required this.imageUrl,
    required this.adresse, required this.phone,
    required this.nomclient,});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage1(image: imageUrl, nomClient: nomclient, phone: phone, adress: adresse,),),
        );
      }, // Wrap the widget with GestureDetector
      child: Container(
        width: 60,
        height: 60,
        //color: Colors.yellow,
        child: imageUrl != ''
            ? ClipRRect(
          borderRadius: BorderRadius.circular(
              50), // Ajout du BorderRadius
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
            : Icon(
          Icons.account_circle,
          size: 65,
          color: Colors.grey[400],
        ),
        //inserer la photode profil hna ki tjibha m bdd
      ),
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
    return Container(
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
import 'dart:core';
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
  final String demandeid;
  final String sync;
  final int type1;
  final int type2;
  final String idartisan;
  final String nomArtisan;
  final bool vehicule;
  const BoxDemande({
    super.key, required this.datedebut,required this.datefin,
    required this.heuredebut, required this.heurefin,
    required this.adresse, required this.iddomaine,
    required this.idprestation, required this.idclient,
    required this.urgence, required this.latitude,
    required this.longitude, required this.timestamp,
    required this.nomprestation, required this.imageUrl,
    required this.type1, required this.type2,
    required this.nomclient, required this.phone, required this.demandeid,
    required this.sync, required this.nomArtisan, required this.idartisan, required this.vehicule,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 2.0,
        ),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
          [
            Pdpanddetails(nomprestation: nomprestation, idClient: idclient,
              datedebut: datedebut,heuredebut: heuredebut,
              adresse: adresse, imageUrl: imageUrl, type: type1,
              urgence: urgence, nomclient: nomclient, phone: phone, isvehiculed: vehicule,),
            Detailsbottom(datedebut: datedebut, datefin: datefin,
              heuredebut: heuredebut, heurefin: heurefin,
              adresse: adresse, iddomaine: iddomaine,
              idprestation: idprestation, idclient: idclient,
              urgence: urgence, latitude: latitude, longitude: longitude,
              timestamp: timestamp, type1: type1, type2: type2,
              demandeid: demandeid, sync: sync, nomArtisan: nomArtisan, nomPrestation: nomprestation, idartisan: idartisan,),
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
  final bool isvehiculed;
  final int type;
  final bool urgence;
  const Pdpanddetails({super.key, required this.nomprestation, required this.idClient,
    required this.datedebut, required this.heuredebut, required this.adresse,
    required this.imageUrl, required this.type, required this.urgence, required this.nomclient, required this.phone, required this.isvehiculed,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran
    return Container(
      width: screenWidth * 0.89,
      height: 95,
      // color: Colors.green,

      child: Row(
          children:
          [
            const SizedBox(width: 4,),
            Pdp(imageUrl: imageUrl, adresse:adresse, phone: phone, nomclient: nomclient, idclient: idClient, isvehiculed: isvehiculed,),
            Details(nomprestation: nomprestation, adresse: adresse,
              datedebut: datedebut, heuredebut: heuredebut,type: type, urgence: urgence,),
          ]
      ),


    );
  }

}


class Pdp extends StatelessWidget {
  final String idclient;
  final String imageUrl;
  final String adresse;
  final String phone;
  final String nomclient;
  final bool isvehiculed;
  const Pdp({super.key, required this.imageUrl,
    required this.adresse, required this.phone,
    required this.nomclient, required this.idclient, required this.isvehiculed,});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage1(image: imageUrl, nomClient: nomclient, phone: phone, adress: adresse, idclient: idclient, isVehicled: isvehiculed,),),
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
    double screenWidth = MediaQuery.of(context).size.width; // Largeur de l'écran
    double screenHeight = MediaQuery.of(context).size.height; // Hauteur de l'écran
    return Container(
        width: MediaQuery.of(context).size.width * 0.71,
        //height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children:
            [
              NomPrestation(nomprestation: nomprestation,),
              Lieu(adresse: adresse,),
              Heure(heuredebut: heuredebut, type: type, urgence: urgence,),
              Date(datedebut: datedebut, type: type, urgence: urgence,),
            ]
        )
    );
  }
}
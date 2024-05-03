import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeClientService.dart';
import 'package:reda/Client/Services/demande%20publication/HistoriqueServices.dart';
import 'package:reda/Client/Services/demande%20publication/RendezVous_Service.dart';
class Buttontraiterannuler extends StatelessWidget {
  final String idclient;
  final Timestamp timestamp;
  final String datefin;
  final String datedebut;
  final String location;
  final String heuredebut;
  final String heurefin;
  final String iddomaine;
  final String idprestation;
  final String idartisan;
  final bool urgence;
  final double longitude;
  final double latitude;
  const Buttontraiterannuler({super.key, required this.idclient, required this.timestamp, required this.datefin, required this.datedebut, required this.location, required this.heuredebut, required this.heurefin, required this.iddomaine, required this.idprestation, required this.idartisan, required this.urgence, required this.longitude, required this.latitude});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 30,
        //color: Colors.black,
        child: Row(
          children: [
            const SizedBox(width: 18,),
            ButtonTraiter(timestamp: timestamp, idclient: idclient, datefin: datefin,
              datedebut: datedebut, location: location, heuredebut: heuredebut,
              heurefin: heurefin, iddomaine: iddomaine, idprestation: idprestation,
              idartisan: idartisan, urgence: urgence, longitude: longitude, latitude: latitude,),
            const SizedBox(width: 2,),
            ButtonAnnuler(timestamp: timestamp, idclient: idclient,),
          ],
        )
    );
  }

}


class ButtonTraiter extends StatefulWidget {
  final Timestamp timestamp;
  final String idclient;
  final String datefin;
  final String datedebut;
  final String location;
  final String heuredebut;
  final String heurefin;
  final String iddomaine;
  final String idprestation;
  final String idartisan;
  final bool urgence;
  final double longitude;
  final double latitude;
  const ButtonTraiter({super.key, required this.timestamp, required this.idclient,
    required this.datefin, required this.datedebut, required this.location,
    required this.heuredebut, required this.heurefin, required this.iddomaine,
    required this.idprestation, required this.idartisan, required this.urgence,
    required this.longitude, required this.latitude});

  @override
  ButtonTraiterState createState() => ButtonTraiterState();
}

class ButtonTraiterState extends State<ButtonTraiter> {
  Color _buttonColor = const Color(0xFF49F77A);
  Color _textColor = Colors.black;
  final RendezVousService _rendezVousService = RendezVousService();
  final HistoriqueService _historiqueService = HistoriqueService();
  void _changeColor() {
    setState(() {
      _buttonColor = const Color(0xFFF6F6F6);
      _textColor = const Color(0xFFC4C4C4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed:() async {
          _changeColor;
          _historiqueService.sendHistorique(widget.datedebut, widget.datefin, widget.heuredebut,
              widget.heurefin, widget.location, widget.iddomaine,
              widget.idprestation, widget.idclient, widget.idartisan,
              widget.urgence, widget.latitude, widget.longitude);
          _rendezVousService.deleteRendezVous(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
          print('Traite avec success');
          await Future.delayed(const Duration(milliseconds: 100));
          },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Traité',
              style: GoogleFonts.poppins(
                color: _textColor,
                fontSize: 12,
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

class ButtonAnnuler extends StatefulWidget {
  final Timestamp timestamp;
  final String idclient;
  const ButtonAnnuler({super.key, required this.timestamp, required this.idclient});

  @override
  ButtonAnnulerState createState() => ButtonAnnulerState();
}

class ButtonAnnulerState extends State<ButtonAnnuler> {
  final RendezVousService _rendezVousService = RendezVousService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () async {
          _rendezVousService.deleteRendezVous(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
          _rendezVousService.deleteRendezVous(widget.timestamp, widget.idclient);
          print('annuler avec success');
          await Future.delayed(const Duration(milliseconds: 100));
        }, // hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Annuler',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
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
      ),
    );
  }
}
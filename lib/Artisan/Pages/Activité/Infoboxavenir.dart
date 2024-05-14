
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Client/Services/demande publication/RendezVous_Service.dart';
import '../ProfilClient/profilclient.dart';




class InfoBoxavenir extends StatefulWidget {
  final String prestation;// c bon
  final String heureDebut;// c bon
  final String heureFin;// c bon
  final String datedebut;// c bon
  final String datefin;// c bon
  final String adresse;// c bon
  final String photoUrl;// c bon
  final bool urgence;// c bon
  final double latitude;  // c bon
  final double longitude; // c bon
  final String iddomaine; // c bon
  final String idprestation;  // c bon
  final String idclient;// c bon
  final String nomclient;// c bon
  final String phone;// c bon
  final String demandeid; // c bon
  final String sync;  // c bon
  final String idartisan; // c bon
  final String nomArtisan;  // c bon
  final String tokenClient;
  final String tokenArtisan;
  final bool vehicule; // c bon
  final Timestamp timestamp; // c bon

  const InfoBoxavenir({super.key,
    required this.prestation,
    required this.heureDebut,
    required this.heureFin,
    required this.adresse,
    required this.photoUrl,
    required this.datedebut,
    required this.datefin,
    required this.urgence,
    required this.latitude,
    required this.longitude,
    required this.iddomaine,
    required this.idprestation,
    required this.idclient,
    required this.nomclient,
    required this.phone,
    required this.demandeid,
    required this.sync,
    required this.idartisan,
    required this.nomArtisan,
    required this.vehicule,
    required this.timestamp, required this.tokenClient, required this.tokenArtisan,
  });
  @override
  State<InfoBoxavenir> createState() => InfoBoxavenirState();
}

class InfoBoxavenirState extends State<InfoBoxavenir> {
  final RendezVousService _rendezVousService = RendezVousService();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: screenWidth*0.03),
                      Image.asset('assets/cle.png', width: screenWidth*0.07, height:screenHeight*0.07),
                      SizedBox(width: screenWidth*0.03),
                      Expanded(
                        child: Text(
                          widget.prestation,
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth*0.045,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage1(image: widget.photoUrl, nomClient: widget.nomclient, phone: widget.phone, adress: widget.adresse,
                              idclient: widget.idclient, isVehicled: widget.vehicule,nomArtisan: widget.nomArtisan,
                              tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,),),
                          );
                        }, // Wrap the widget with GestureDetector
                        child: Container(
                          width: 48,
                          height: 48,
                          //color: Colors.yellow,
                          child: widget.photoUrl != ''
                              ? ClipRRect(borderRadius: BorderRadius.circular(
                              48), // Ajout du BorderRadius
                            child: Image.network(
                              widget.photoUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                          //inserer la photode profil hna ki tjibha m bdd
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01),
                  Row(
                    children: [
                      Image.asset('assets/adresse.png', width: 20, height: 20),
                      SizedBox(width: screenWidth *0.01),
                      Expanded(
                        child: Text(
                          " ${widget.adresse}",
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth*0.035,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01),
                  Row(
                    children: [
                      Image.asset('assets/calendar.png', width: 20, height: 20),
                      SizedBox(width: screenWidth *0.01),
                      Text(
                        "Le: ${widget.datedebut}",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth*0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01),
                  Row(
                    children: [
                      Image.asset('assets/time.png', width: 20, height: 20),
                      SizedBox(width: screenWidth *0.01),
                      Text(
                        "De: ${widget.heureDebut} à ${widget.heureFin}",
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth*0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width:screenWidth*0.34),
                      if (widget.urgence) // Ajout du widget "Urgent" s'il est urgent
                        Container(

                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6B940),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Urgent',
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth*0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: screenHeight*0.01),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: screenWidth*0.25,
                          height: screenHeight*0.043,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity((0.1)),
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth*0.03,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

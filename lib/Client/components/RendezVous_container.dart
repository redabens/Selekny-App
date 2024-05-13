
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';
import 'package:reda/Client/Services/demande%20publication/HistoriqueServices.dart';
import 'package:reda/Client/Services/demande%20publication/RendezVous_Service.dart';
import 'package:reda/Pages/Commentaires/Ajouter_commentaire_page.dart';

class RendezVousClient extends StatefulWidget {
  final String tokenClient;
  final String nomClient;
  final String tokenArtisan;
  final String domaine;
  final String location;
  final String date;
  final String heure;
  final String prix;
  final String prestation;
  final String imageUrl;
  final String nomArtisan;
  final double rating;
  final int workcount;
  final bool vehicule;
  final String phone;
  final bool urgence;
  //-----------------
  final String adresseartisan;
  final double latitude;
  final double longitude;
  final String iddomaine;
  final String idprestation;
  final String idclient;
  final String datedebut;
  final String datefin;
  final String heuredebut;
  final String heurefin;
  final String idartisan;
  final Timestamp timestamp;

  const RendezVousClient({
    super.key,
    required this.domaine,
    required this.location,
    required this.date,
    required this.heure,
    required this.prix,
    required this.prestation,
    required this.imageUrl,
    required this.nomArtisan,
    required this.rating,
    required this.phone,
    required this.urgence,
    //----------------------------
    required this.latitude,
    required this.longitude,
    required this.iddomaine,
    required this.idprestation,
    required this.idclient,
    required this.datedebut,
    required this.datefin,
    required this.heuredebut,
    required this.heurefin,
    required this.idartisan,
    required this.timestamp,
    required this.adresseartisan,
    required this.workcount,
    required this.vehicule, required this.nomClient,
    required this.tokenArtisan, required this.tokenClient,
  });
  @override
  State<RendezVousClient> createState() => _RendezVousClientState();
}

class _RendezVousClientState extends State<RendezVousClient> {
  final DemandeClientService _DemandeClientService = DemandeClientService();
  final RendezVousService _rendezVousService = RendezVousService();
  final HistoriqueService _historiqueService = HistoriqueService();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.domaine,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                           SizedBox(height:screenHeight*0.010),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 21),
                              Flexible(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: screenWidth * 0.6, // Define a maximum width for the text
                                  ),
                                  child: Text(
                                    widget.location,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:screenHeight*0.010),
                          Text(
                            'Date du rendez-vous :',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),

                          Row(
                            children: [
                              Image.asset('icons/calendrier.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width:screenWidth*0.02),
                              Text(
                                widget.date,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:screenHeight*0.010),
                          Text(
                            widget.urgence ? "Urgente" : widget.heure,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.urgence ? Colors.red : null,
                            ),
                          ),
                          SizedBox(height:screenHeight*0.010),
                          Text(
                            widget.prix,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF3E69FE),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.prestation,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.6), // Adjust opacity here (0.0 to 1.0)
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Your code to handle tap actions here (e.g., navigate to profile page)
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfilePage2(idartisan: widget.idartisan, imageurl: widget.imageUrl,
                                   phone: widget.phone, domaine: widget.domaine, rating: widget.rating,
                                  adresse: widget.adresseartisan, workcount: widget.workcount, vehicule: widget.vehicule,
                                  nomArtisan: widget.nomArtisan,nomClient: widget.nomClient,
                                  tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,), // Navigation to ContactPage
                              ),
                              ); // Example navigation
                            },
                            child: Container(
                              width: 54, // Adjust as needed
                              height: 54, // Adjust as needed
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1.0,
                                ),
                              ),
                              child: widget.imageUrl != ''
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    50), // Ajout du BorderRadius
                                    child: Image.network(
                                      widget.imageUrl,
                                      width: 54,
                                      height: 54,
                                      fit: BoxFit.cover,
                                ),
                              )
                                  : Icon(
                                Icons.account_circle,
                                size: 54,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                          Text(
                            widget.nomArtisan,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height:screenHeight*0.010),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.yellow, size: 20),
                              Text(
                                widget.rating.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 20),
                              Text(
                                widget.phone,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox() ,
                // !confirmed && cancelled ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ()  async {
                        _historiqueService.sendHistorique(widget.datedebut, widget.datefin, widget.heuredebut,
                            widget.heurefin, widget.location, widget.iddomaine,
                            widget.idprestation, widget.idclient, widget.idartisan,
                            widget.urgence, widget.latitude, widget.longitude,widget.idclient);
                        _DemandeClientService.deleteRendezVous(widget.timestamp, widget.idclient);
                        await Future.delayed(const Duration(milliseconds: 100));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AjouterCommentairePage(nomPrestataire: widget.nomArtisan, artisanID: widget.idartisan, nomprestation: widget.prestation,),
                        ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF3E69FE)),
                        minimumSize: MaterialStateProperty.all(const Size(22, 6)),
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 8)), // Ajoutez du padding si nécessaire
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Traité',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width:screenWidth*0.03),
                    OutlinedButton(
                      onPressed: () async{
                        _rendezVousService.deleteRendezVous(widget.timestamp, FirebaseAuth.instance.currentUser!.uid);
                        _rendezVousService.deleteRendezVous(widget.timestamp, widget.idartisan);
                        await Future.delayed(const Duration(milliseconds: 100));
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color(0xFF3E69FE),
                            width: 1,
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(const Size(22, 6)), // Updated dimensions to match the ElevatedButton
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12, vertical: 7)), // Optional, adjust as necessary
                        shape: MaterialStateProperty.all(

                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Annuler',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF3E69FE),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
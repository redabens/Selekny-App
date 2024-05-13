import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';
import 'package:reda/Client/PubDemande/DemandeEnvoyeInit.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/Services/demande%20publication/RendezVous_Service.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Services/notifications.dart';

class DetDemandeAcceptee extends StatefulWidget {
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
  final String adresseartisan;
  final Timestamp timestamp;

  const DetDemandeAcceptee({
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
    required this.adresseartisan, required this.workcount, required this.vehicule, required this.nomClient, required this.tokenArtisan, required this.tokenClient,
  });
  @override
  State<DetDemandeAcceptee> createState() => _DetDemandeAccepteeState();
}

class _DetDemandeAccepteeState extends State<DetDemandeAcceptee> {
  final DemandeClientService _DemandeClientService = DemandeClientService();
  final DemandeArtisanService _DemandeArtisanService = DemandeArtisanService();
  final RendezVousService _rendezVousService = RendezVousService();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
                              const SizedBox(width: 6),
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
                          const SizedBox(height: 10),
                          Text(
                            widget.urgence ? "Urgente" : widget.heure,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.urgence ? Colors.red : null,
                            ),
                          ),
                          const SizedBox(height: 10),
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
                            onTap: () async {
                              // Your code to handle tap actions here (e.g., navigate to profile page)
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfilePage2(idartisan: widget.idartisan, imageurl: widget.imageUrl,
                                  phone: widget.phone, domaine: widget.domaine, rating: widget.rating, adresse: widget.adresseartisan,
                                  workcount: widget.workcount, vehicule: widget.vehicule,nomArtisan: widget.nomArtisan,nomClient: widget.nomClient,
                                  tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,), // Navigation to ContactPage
                                ),
                              );
                              await Future.delayed(const Duration(milliseconds: 800));// Example navigation
                            },
                            child: Container(
                              width: 54, // Adjust as needed
                              height: 54, // Adjust as needed
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.1,
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
                                size: 56,
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
                          const SizedBox(height: 10),
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
                        String token = await UserRepository.instance
                            .getTokenById(widget.idartisan);

                        await getNomPrestationById(widget.iddomaine, widget.idprestation);

                        NotificationServices.sendPushNotification(
                            token,"ConfirmeParClient",
                            "Votre demande a été confirmé",
                            "Service demandé : $nomPrestation");
                        _rendezVousService.sendRendezVous(widget.datedebut, widget.datefin, widget.heuredebut, widget.heurefin, widget.location, widget.iddomaine, widget.idprestation, widget.idclient, widget.urgence, widget.latitude, widget.longitude,widget.idartisan,widget.idartisan);
                        _rendezVousService.sendRendezVous(widget.datedebut, widget.datefin, widget.heuredebut, widget.heurefin, widget.location, widget.iddomaine, widget.idprestation, widget.idclient, widget.urgence, widget.latitude, widget.longitude,widget.idartisan,widget.idclient) ;
                        _DemandeClientService.deleteDemandeClient(widget.timestamp, widget.idclient);
                        await Future.delayed(const Duration(milliseconds: 100));
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
                        'Confirmer',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () async{
                        _DemandeClientService.deleteDemandeClient(widget.timestamp, widget.idclient);
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
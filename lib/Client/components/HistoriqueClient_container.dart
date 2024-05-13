
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';

class HistoriqueClient extends StatefulWidget {
  final String tokenClient;
  final String nomClient;
  final String tokenArtisan;
  final String domaine;
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
  //-----------------
  final String adresseartisan;
  final String idclient;
  final String datefin;
  final String heuredebut;
  final String heurefin;
  final String idartisan;

  const HistoriqueClient({
    super.key,
    required this.domaine,
    required this.date,
    required this.heure,
    required this.prix,
    required this.prestation,
    required this.imageUrl,
    required this.nomArtisan,
    required this.rating,
    required this.phone,
    required this.idclient,
    required this.datefin,
    required this.heuredebut,
    required this.heurefin,
    required this.idartisan,
    required this.adresseartisan,
    required this.workcount,
    required this.vehicule, required this.nomClient, required this.tokenArtisan, required this.tokenClient,
  });
  @override
  State<HistoriqueClient> createState() => _HistoriqueClientState();
}

class _HistoriqueClientState extends State<HistoriqueClient> {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
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
                          const SizedBox(height: 8,),
                          Text(
                            widget.prestation,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.6), // Adjust opacity here (0.0 to 1.0)
                            ),
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
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                              width: 55, // Adjust as needed
                              height: 55,
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
                          const SizedBox(height: 8,),
                          Container(
                            width: 80,
                            child: Text(
                                widget.nomArtisan,
                                style: GoogleFonts.poppins(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
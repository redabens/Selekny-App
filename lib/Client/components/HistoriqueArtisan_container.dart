
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/ProfilClient/profilclient.dart';

class HistoriqueArtisan extends StatefulWidget {
  final String domaine;
  final String location;
  final String date;
  final String heure;
  final String prix;
  final String prestation;
  final String imageUrl;
  final String nomClient;
  final bool vehicule;
  final String phone;
  final bool urgence;
  final String idclient;
  final String datefin;
  final String heuredebut;
  final String heurefin;

  const HistoriqueArtisan({
    super.key,
    required this.domaine,
    required this.location,
    required this.date,
    required this.heure,
    required this.prix,
    required this.prestation,
    required this.imageUrl,
    required this.nomClient,
    required this.phone,
    required this.urgence,
    required this.idclient,
    required this.datefin,
    required this.heuredebut,
    required this.heurefin,
    required this.vehicule,
  });
  @override
  State<HistoriqueArtisan> createState() => _HistoriqueArtisanState();
}

class _HistoriqueArtisanState extends State<HistoriqueArtisan> {
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
                            widget.prestation,
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
                          GestureDetector(
                            onTap: () {
                              // Your code to handle tap actions here (e.g., navigate to profile page)
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProfilePage1(image: widget.imageUrl, nomClient: widget.nomClient,
                                  phone: widget.phone, adress: widget.location, idclient: widget.idclient, isVehicled: widget.vehicule),
                              ),); // Example navigation
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
                            widget.nomClient,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
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
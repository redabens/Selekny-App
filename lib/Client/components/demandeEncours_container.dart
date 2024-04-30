import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/Services/demande publication/DemandeClientService.dart';

class DetDemandeEncours extends StatefulWidget {
  final String domaine;
  final String prestation;
  final String date;
  final String heure;
  final String prix;
  final String sync;
  final bool urgence;
  final String demandeID;

  const DetDemandeEncours({
    Key? key,
    required this.domaine,
    required this.prestation,
    required this.date,
    required this.heure,
    required this.prix,
    required this.sync,
    required this.urgence,
    required this.demandeID,

  }) : super(key: key);

  @override
  _DetDemandeEncoursState createState() => _DetDemandeEncoursState();
}

class _DetDemandeEncoursState extends State<DetDemandeEncours> {
  bool isCancelled = false;
DemandeClientService _DemandeClientService = DemandeClientService();
  @override
  Widget build(BuildContext context) {
    // Get the screen's dimensions to scale layout accordingly
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // Padding based on screen width
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, // Margin based on screen height
            ),
            padding: EdgeInsets.all(screenWidth * 0.06), // Padding based on screen width
            decoration: BoxDecoration(
              color: isCancelled ? Colors.red.withOpacity(0.5) : Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: screenWidth * 0.02,
                  blurRadius: screenWidth * 0.03,
                  offset: Offset(0, screenWidth * 0.01),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.domaine,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: Text(
                        widget.prestation,
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.035,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    Image.asset(
                      'icons/calendrier.png',
                      height: screenWidth * 0.056,
                    ),
                    Text(
                      " ${widget.date}",
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.urgence ? "Urgent" : widget.heure,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.bold,
                        color: widget.urgence ? Colors.red : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  children: [
                    Text(
                      widget.prix,
                      style: GoogleFonts.poppins(
                        color: Color(0xFF3E69FE),
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.036,
                      ),
                    ),
                    Spacer(flex: 3), // Move button to the right
                    if (!isCancelled)
                      ElevatedButton(
                        onPressed: () async {

                          setState(() {
                            isCancelled = true;
                          });

                         // await Future.delayed(const Duration(milliseconds: 100));
                          await _DemandeClientService.deleteDemandeEncours(widget.demandeID);
                          isCancelled= false;
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF3E69FE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.035),
                          ),
                        ),
                        child: Text(
                          'Annuler',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.036,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015), // Space between button and `sync`
                if (isCancelled)
                  SizedBox.shrink(), // Hide button when cancelled
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Align `sync` to the right
                  children: [
                    Text(""),
                    const Spacer(flex:2),
                    Text(
                      widget.sync,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.03,
                        color: Colors.black.withOpacity(0.7)
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
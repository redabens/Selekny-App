import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Signalements/DetailsSignalement_page.dart';
import '';

class DetSignalement extends StatelessWidget {
  final String signalementID;
  final String signaleurId;
  final String signalantId;
  final String signaleurName;
  final String signalantName;
  final String leDate;
  final String aHeure;
  final String signaleurJob;
  final String signalantJob;
  final String raison;
  final String signaleurUrl;
  final String signalantUrl;

  const DetSignalement({
    Key? key,
    required this.signalementID,
    required this.signaleurId,
    required this.signalantId,
    required this.signaleurName,
    required this.signalantName,
    required this.leDate,
    required this.aHeure,
    required this.signaleurJob,
    required this.signalantJob,
    required this.raison,
    required this.signaleurUrl,
    required this.signalantUrl

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailsSignalement(signalementID:signalementID,signaleurID:signaleurId,signalantID:signalantId,signaleurName: signaleurName, signalantName: signalantName, signaleurJob: signaleurJob, signalantJob: signalantJob, date: leDate, heure: aHeure, raison: raison,signaleurUrl: signaleurUrl,signalantUrl: signalantUrl,)),
      );
    },
      child:Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color(0xFFEBEBEB),
        border: Border.all(
          color: Color(0xFF7089DD),
          width: 0, // Décommentez cette ligne si vous souhaitez afficher une bordure
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 39,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: signalantName,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' a été signalé par ',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF685D5D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: signaleurName,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                leDate,
                style: GoogleFonts.poppins(
                  color: Color(0xFF685D5D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                aHeure,
                style: GoogleFonts.poppins(
                  color: Color(0xFF685D5D),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


class Detcommentaire extends StatelessWidget {
  final String userName;
  final int starRating;
  final String comment;
  final String prestationName;
  final String profileImage;
  final Timestamp timestamp;

  const Detcommentaire({
    super.key,
    required this.userName,
    required this.starRating,
    required this.comment,
    required this.prestationName,
    required this.profileImage,
    required this.timestamp,
  });
  String getFormattedDate(Timestamp timestamp) {
    //Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();

    // Formater la date
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    print(formattedDate);
    return formattedDate;
  }
  String getFormattedTime(Timestamp timestamp) {
    // Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();

    // Formater l'heure
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    print(formattedTime);
    return formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      margin: EdgeInsets.symmetric(  vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.05,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Première ligne avec la photo de profil
          Row(
            children: [
              Container(
                width: 54, // Adjust as needed
                height: 54, // Adjust as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.0,
                  ),
                ),
                child: profileImage != ''
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(
                      50), // Ajout du BorderRadius
                  child: Image.network(
                    profileImage,
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
              SizedBox(width: screenWidth * 0.02),
              // Colonne avec le nom de l'utilisateur et le nom de la prestation
              Flexible(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height:  screenHeight *0.005), // Espace entre le nom et la prestation
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Color(0xFF3E69FE), fontSize:screenWidth * 0.03),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            prestationName,// Texte
                          ),
                        ],
                      ),
                      softWrap: true, // Permet au texte de se diviser en plusieurs lignes
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ],

          ),
          SizedBox(height: screenHeight *0.01),
          // Commentaire
          Text(
            comment,
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: index < starRating ? Colors.yellow : Colors.grey,
                    size:screenWidth * 0.05,
                  ),
                ),
              ),
              Spacer(),
              Text(
                getFormattedDate(timestamp),
                style: GoogleFonts.poppins(fontWeight: FontWeight.w300, color: Colors.grey,fontSize: screenWidth * 0.035),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

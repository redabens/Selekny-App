import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
=======
import 'package:reda/Artisan/Pages/ProfilClient/profilclient.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b

const Color myBlueColor = Color(0xFF3E69FE);

class DetChatList extends StatelessWidget {
  final String userName;
  final String lastMsg;
  final String profileImage;
  final String timestamp;
  final String otheruserId;
  final String phone;
  final String adresse;
  final String domaine;
  final int rating;
  final int type;
  const DetChatList({
    super.key,
    required this.userName,
    required this.lastMsg,
    required this.profileImage,
    required this.timestamp,
    required this.type,
    required this.otheruserId,
    required this.phone,
    required this.adresse,
    required this.domaine,
    required this.rating,
  });

  String getFormattedTime(Timestamp timestamp) {
    // Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    print(formattedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
      ),
      child: Stack(
        children: [
          Container(
            height:80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
<<<<<<< HEAD
                color: const Color(0xFFFD1D1D1).withOpacity(0.5),
=======
                color: const Color(0xFFD1D1D1).withOpacity(0.5),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                width: 1.2,
              ),
              /* boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],*/
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle photo tap here (e.g., navigate to a new screen, show a dialog)
                      if(type == 1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(    //otherUserId
                            builder: (context) => ProfilePage2(idartisan: otheruserId, imageurl: profileImage, nomartisan: userName, phone: phone, domaine: domaine, rating: rating),
                          ),
                        );
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(    //otherUserId
                              builder: (context) => ProfilePage1(image: profileImage, nomClient: userName, phone: phone, adress: adresse, idclient: otheruserId,),
                          ),
                        );
                      } // Example action (replace with your desired functionality)
                    },
                    child: Container(
                      width: 54, // Adjust as needed
                      height: 54, // Adjust as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: myBlueColor,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: profileImage != ''
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              54), // Ajout du BorderRadius
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
                    ),
                  ),
                  const SizedBox(width: 16), //espace entre container image et text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userName,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            lastMsg,
                            maxLines: 1, // Limit to a single line
                            overflow: TextOverflow.ellipsis, // Show '...' if overflow
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
<<<<<<< HEAD
                              color: Color(0xFF7F7F7F),
=======
                              color: const Color(0xFF7F7F7F),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 38,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 5),
                Text(
                  timestamp,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
<<<<<<< HEAD
                    color: Color(0xFF7F7F7F),
=======
                    color: const Color(0xFF7F7F7F),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 91),
        ],
      ),
    );
  }
}
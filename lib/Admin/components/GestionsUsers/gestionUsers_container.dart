
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<String> getUserPathImage(String userID) async {

  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
      'users').doc(userID).get();
  if (userDoc.exists) {
    print('here');
    String pathImage = userDoc['pathImage'];
    print(pathImage);
    // Retourner le PathImage
    final reference = FirebaseStorage.instance.ref().child(pathImage);
    try {
      // Get the download URL for the user image
      final downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Error fetching user image URL: $error");
      return ''; // Default image on error
    }
  } else {
    return '';
  }
}


class DetGestionUsers extends StatelessWidget {
  final String userName;
  final String job;
  final String profileImage;

  const DetGestionUsers({
    super.key,
    required this.userName,
    required this.job,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Stack(
        children: [
          Container(

            width: screenWidth*1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFD1D1D1),
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50, // Adjust as needed
                    height: 50, // Adjust as needed
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: profileImage != ''
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                          60), // Ajout du BorderRadius
                      child: Image.network(
                        profileImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ): Icon(
                      Icons.account_circle,
                      size:55,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child:
                            Text(
                              userName,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,

                            ),
                              ),
                        ],
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            job,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: const Color(0xFF7F7F7F),
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
          const Positioned(
            top: 38,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 5),
              ],
            ),
          ),
          // const SizedBox(height: 84),
        ],
      ),
    );
  }
}
/**/

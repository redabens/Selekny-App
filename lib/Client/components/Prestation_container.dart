import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';
import 'package:reda/Pages/retourAuth.dart';

class Prestation extends StatelessWidget {
  final String nomprestation;
  final String imageUrl;
  final String domaineID;
  final String prestationID;
  final int type;

  const Prestation({
    Key? key,
    required this.nomprestation,
    required this.imageUrl,
    required this.domaineID,
    required this.prestationID,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.9, // Set width to 90% of screen width
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: screenWidth * 0.02),
          Container(
            width: screenWidth * 0.17,
            height: screenHeight * 0.09,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
<<<<<<< HEAD
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
=======
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              nomprestation,
              style: GoogleFonts.poppins(
                color: Colors.black.withOpacity(0.7),
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
            ),
          ),

          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF33363F),
              size: screenWidth * 0.05,
            ),
            onPressed: () {
              if (type == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsDemande(
                      domaineID: domaineID,
                      prestationID: prestationID,
                      nomprestation: nomprestation,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
<<<<<<< HEAD
                    builder: (context) => RetourAuth(),
=======
                    builder: (context) => const RetourAuth(),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilPrestation extends StatelessWidget {
  final String nomprestation;
  final String imageUrl;

  const ProfilPrestation({
    super.key,
    required this.nomprestation,
    required this.imageUrl,
  });

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
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(width: 10),
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
        ],
      ),
    );
  }
}
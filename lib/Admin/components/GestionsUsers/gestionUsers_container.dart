
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildUserProfileImage(String? profileImage) {
  //si url valide => crached net
  if (profileImage != null && (profileImage.startsWith('http') || profileImage.startsWith('https'))) {
    return CachedNetworkImage(
      imageUrl: profileImage,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) =>  Icon(
        Icons.account_circle,
        size: 50,
        color: Colors.grey[400],
      ),
    );
  } else {
    // if url nexiste pas ou null => assets
    return  Icon(
      Icons.account_circle,
      size: 50,
      color: Colors.grey[400],
    );
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
    // Responsive width for the job text and image sizes
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth * 0.1;
    double textWidth = screenWidth * 0.65; // 60% of screen width, adjust accordingly

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD1D1D1), width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: imageSize, // Responsive based on screen size
                height: imageSize, // Same as width for circle
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: buildUserProfileImage(profileImage), // User image
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                    const SizedBox(height: 1),
                    Container(
                      width: textWidth, // Responsive width for job description
                      child: Text(
                        job,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: const Color(0xFF7F7F7F),
                        ),
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


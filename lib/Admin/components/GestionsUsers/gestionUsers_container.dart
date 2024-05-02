import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildUserProfileImage(String? profileImage) {
  //si url valide => crached net
  if (profileImage != null && (profileImage.startsWith('http') || profileImage.startsWith('https'))) {
    return CachedNetworkImage(
      imageUrl: profileImage,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => Image.asset('assets/anonyme.png'),
    );
  } else {
    // if url nexiste pas ou null => assets
    return Image.asset(
      'assets/anonyme.png',
      fit: BoxFit.cover,
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
      ),
      child: Stack(
        children: [
          Container(
            height: 74,
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: buildUserProfileImage(
                          profileImage), // Using the function here
                    ),
                  ),
                  const SizedBox(width: 20),
                  //espace entre container image et text
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
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.5,
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
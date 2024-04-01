import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prestation extends StatelessWidget {
  final String nomprestation;
  final String imageUrl;

  const Prestation({
    super.key,
    required this.nomprestation,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 69,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black54),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 60,
            child: ClipRRect(
              child: CachedNetworkImage(

                imageUrl: imageUrl,

                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
              child: Text(
                nomprestation,
                maxLines: 2, // Limit text to 2 lines to prevent overflow
                overflow: TextOverflow.ellipsis, // Add ellipsis for visual cue
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ),
          const Spacer(), // Push IconButton to the end
          IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF33363F),
              size: 20,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 5), // Add spacing before the container's edge
        ],
      ),
    );
  }
}
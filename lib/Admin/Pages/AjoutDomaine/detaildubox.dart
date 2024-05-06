
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//Details de chaque box de domaine
class DomainPhotoWidget extends StatelessWidget {
  final String domainName;
  final String imagePath;
  final VoidCallback onTap;

  const DomainPhotoWidget({super.key,
    required this.domainName,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Ajout du BorderRadius
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 105,
                    width: double.infinity,
                  ),
              ),
              Positioned(
                top: 73,
                right: 10,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            domainName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}




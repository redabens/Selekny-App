import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileBodyClientCoteAdmin extends StatelessWidget {
  final String photoPath;
  final String name;
  final String phone;
  final String address;
  final bool isVehicled;
  final VoidCallback onContact;
  final VoidCallback onReport;

  ProfileBodyClientCoteAdmin({
    required this.photoPath,
    required this.name,
    required this.phone,
    required this.address,
    required this.isVehicled,
    required this.onContact,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        photoPath != ''
            ? ClipRRect(
          borderRadius: BorderRadius.circular(
              50), // Ajout du BorderRadius
          child: Image.network(
            photoPath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        )
            : Icon(
          Icons.account_circle,
          size: 65,
          color: Colors.grey[400],
        ),
        SizedBox(height: screenHeight * 0.04),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.1),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/tel.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                phone,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        Container(
          width: screenWidth * 0.9,

          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/localisation.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: Text(
                  address,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.04),
        Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.055,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenWidth * 0.05),
            border: Border.all(color: Colors.blue),
            color: isVehicled ? const Color(0xFF7CF6A5) : Colors.red.withOpacity(0.5),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/Car.png',
                width: screenWidth * 0.07,
                height: screenWidth * 0.07,
              ),
              SizedBox(width: screenWidth * 0.03),
              Text(
                'Vehiculé',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.07),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onContact,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3E69FE),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical:12),
                child: Center(
                  child: Text(
                    'Contact',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            GestureDetector(
              onTap: onReport,
              child: Container(
                decoration: BoxDecoration(
                  color:  const Color(0xFFFF0000).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(screenWidth * 0.05),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Text(
                  'Bloquer',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

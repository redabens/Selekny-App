import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myBlueColor = Color(0xFF3E69FE);
const Color myGrayColor = Color(0xFFF3F3F3);

class ChatBubble extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    BorderRadius borderRadius = BorderRadius.circular(20);

    if (textColor == Colors.black) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(0),
      );
    } else if (textColor == Colors.white) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(0),
        bottomLeft: Radius.circular(20),
      );
    }

    return Align(
      alignment: textColor == Colors.black ? Alignment.centerLeft : Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: screenWidth * 0.8, // Maximum width is 80% of the screen width
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

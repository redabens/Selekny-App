import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myBlueColor = Color(0xFF3E69FE);
const Color myGrayColor = Color(0xFFF3F3F3);

class ChatBubble extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final String? otherUserImage; // Optional, could be null for the current user
  const ChatBubble({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.otherUserImage,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double maxWidth = screenWidth * 0.75;

    BorderRadius borderRadius = BorderRadius.circular(20);
    bool isCurrentUser = textColor == Colors.white;

    if (isCurrentUser) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(0),
        bottomLeft: Radius.circular(20),
      );
    } else {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(0),
      );
    }

    Widget messageBubble = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minHeight: 0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          message,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
    );

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: isCurrentUser ? messageBubble : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (otherUserImage != null) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(otherUserImage!),
              radius: 10,
            ),
            const SizedBox(width: 4),
          ],
          messageBubble,
        ],
      ),
    );
  }
}
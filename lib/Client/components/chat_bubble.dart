import 'package:flutter/material.dart';
// Import additional services as needed (e.g., ChatService, ImageService)

const Color myBlueColor = Color(0xFF3E69FE); // Your desired blue color
const Color myGrayColor = Color(0xFFF3F3F3); // Your desired gray color

class ChatBubble extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0), // Adjust as desired
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0), // Adjust as desired
          bottomRight: Radius.circular(10.0), // Adjust as desired
        ),
        color: backgroundColor,
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.normal, // Adjust weight as desired
        ),
      ),
    );
  }
}
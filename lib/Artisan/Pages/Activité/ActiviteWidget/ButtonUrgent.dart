import 'package:flutter/material.dart';
class ButtonUrgent extends StatelessWidget {
  const ButtonUrgent({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.grey[300], // Set background color to red
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners with 10.0 radius
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0), // Add padding around the text
        child: Text(
          'Urgent',
          style: TextStyle(
            color: Colors.redAccent, // Set text color to white
            fontSize: 24.0, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
      ),
    );
  }
}
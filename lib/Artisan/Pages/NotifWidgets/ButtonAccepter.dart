import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class buttonaccepter extends StatefulWidget {
  const buttonaccepter({super.key});

  @override
  buttonaccepterState createState() => buttonaccepterState();
}

class buttonaccepterState extends State<buttonaccepter> {
  Color _buttonColor = const Color(0xFF49F77A);
  Color _textColor = Colors.black;

  void _changeColor() {
    setState(() {
      _buttonColor = const Color(0xFFF6F6F6);
      _textColor = const Color(0xFFC4C4C4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _changeColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'accepter',
              style: GoogleFonts.poppins(
                color: _textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: ImageIcon(
                const AssetImage('assets/done.png'),
                color: _textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
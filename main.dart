




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ProfilePage.dart';
import 'ChatPage.dart';
import 'NotificationsPage.dart';
import 'Plomberie.dart';
import 'HomePage.dart';
import 'devenirPrestatire.dart';
import 'Detailsdemandes/detailsDemande.dart';
import 'package:flutter/cupertino.dart';



void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Selekny',
      home: detailsDemande(),
    );
  }
}


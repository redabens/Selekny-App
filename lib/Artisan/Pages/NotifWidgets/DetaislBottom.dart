import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/NotifWidgets/Buttonaccruf.dart';
import 'package:reda/Artisan/Pages/NotifWidgets/EnvoyerILya.dart';
class Detailsbottom extends StatelessWidget {
  const Detailsbottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 325,
        height: 35,
        //color: Colors.black,
        child:const Row(
          children: [
            Envoyerilya(),
            Buttonaccruf(),//hado bouton accepter refuser
          ],
        )
    );
  }

}
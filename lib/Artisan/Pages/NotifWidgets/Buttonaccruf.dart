import 'dart:core';
import 'package:flutter/material.dart';
import 'package:reda/Artisan/Pages/NotifWidgets/ButtonAccepter.dart';
import 'package:reda/Artisan/Pages/NotifWidgets/ButtonRefuser.dart';
class Buttonaccruf extends StatelessWidget {
  const Buttonaccruf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 30,
        //color: Colors.black,
        child:const Row(
          children: [
            SizedBox(width: 18,),
            buttonaccepter(),
            SizedBox(width: 2,),
            buttonrefuser(),
          ],
        )
    );
  }

}
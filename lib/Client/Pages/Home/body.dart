import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Home/listeimage.dart';
import 'package:reda/Client/Pages/Home/listimag2.dart';
import 'package:reda/Client/Pages/Home/servicepop.dart';
import 'package:reda/Client/Pages/Home/services.dart';
import 'package:reda/Client/Pages/voirtout_page.dart';

class Body extends StatelessWidget {
  final int type;
  const Body({
    super.key,
    required this.type});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Services(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15,top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Service à domicile',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(width: 105), // Espace entre les deux textes
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoirtoutPage(type: type,)),
                      );
                    },
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E69FE),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF3E69FE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Espace entre les sections
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageList2(type: type,),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageList(type: type,),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: const Servicepop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
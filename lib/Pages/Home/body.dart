import 'package:flutter/material.dart';
import 'package:reda/Pages/Home/datails.dart';
import 'package:reda/Pages/Home/listeimage.dart';
import 'package:reda/Pages/Home/listimag2.dart';
import 'package:reda/Pages/Home/servicepop.dart';
import 'package:reda/Pages/Home/services.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
                        MaterialPageRoute(builder: (context) =>  const DetailPage()),
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
                  child: ImageList2(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageList(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Servicepop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
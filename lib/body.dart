import 'package:flutter/material.dart';
import 'package:selek/pages/home/services.dart';
import 'package:selek/pages/home/listeimage.dart';
import 'package:selek/pages/home/listimag2.dart';
import 'package:selek/pages/details/datails.dart';
import 'package:selek/pages/home/servicepop.dart';
class Body extends StatelessWidget {
  const Body({Key? key});

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
            SizedBox(
              child: const Services(),
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
                        MaterialPageRoute(builder: (context) =>  DetailPage() ),
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
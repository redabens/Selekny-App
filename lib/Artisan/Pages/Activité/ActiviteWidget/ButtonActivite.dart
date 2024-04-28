import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Buttontraiterannuler extends StatelessWidget {
  const Buttontraiterannuler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 30,
        //color: Colors.black,
        child:const Row(
          children: [
            SizedBox(width: 18,),
            ButtonTraiter(),
            SizedBox(width: 2,),
            ButtonAnnuler(),
          ],
        )
    );
  }

}


class ButtonTraiter extends StatefulWidget {
  const ButtonTraiter({super.key});

  @override
  ButtonTraiterState createState() => ButtonTraiterState();
}

class ButtonTraiterState extends State<ButtonTraiter> {
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
      width: 80,
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
              'Traité',
              style: GoogleFonts.poppins(
                color: _textColor,
                fontSize: 12,
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

class ButtonAnnuler extends StatefulWidget {
  const ButtonAnnuler({super.key});

  @override
  ButtonAnnulerState createState() => ButtonAnnulerState();
}

class ButtonAnnulerState extends State<ButtonAnnuler> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {

        }, // hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Annuler',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: const ImageIcon(
                AssetImage('assets/close.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
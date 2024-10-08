import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:reda/Client/components/Date.dart';



class JourFin extends StatefulWidget {
  final Date datefin;
  const JourFin({
    super.key,
    required this.datefin,
  });

  @override
  JourFinState createState() => JourFinState();
}

class JourFinState extends State<JourFin> {
  String _selectedDayText = 'Jour'; // Variable pour stocker le texte du jour sélectionné
  int jourfin = 0; // Variable pour stocker le jour sélectionné
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.035,
      width: screenWidth*0.18,
      child: ElevatedButton(
        onPressed: () {
          // Afficher le picker iOS
          _showDayPicker(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFD0E2FF)), // Couleur de fond
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        child: Text(
          _selectedDayText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF6D6D6D),
            fontSize: screenWidth*0.026,
            fontWeight: FontWeight.w700,
          ), // Afficher le texte du jour sélectionné ou "Jour"
        ),
      ),


    );
  }

  void _showDayPicker(BuildContext context) {
    // Afficher un picker iOS pour choisir le jour
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            itemExtent: 40.0,
            onSelectedItemChanged: (int index) {
              // Mettre à jour le jour sélectionné
              setState(() {
                jourfin = index + 1;
                _selectedDayText = index + 1 < 10 ? '0${(index + 1)}' : '${(index + 1)}'; // Mettre à jour le texte du jour sélectionné
                widget.datefin.setjour(jourfin);
              });
            },
            children: List<Widget>.generate(31, (int index) {
              // Générer la liste des jours de 1 à 31
              return Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              );
            }),
          ),
        );
      },
    ).then((value) {
      // Force la reconstruction du bouton après la sélection
      setState(() {});
    });
  }
}
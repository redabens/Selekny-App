

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:reda/Client/components/Date.dart';

class MoisDebut extends StatefulWidget {
  final Date datedebut;
  const MoisDebut({
    super.key,
    required this.datedebut,
  });

  @override
  MoisDebutState createState() => MoisDebutState();
}

class MoisDebutState extends State<MoisDebut> {
  String _selectedMonthText = 'Mois'; // Variable pour stocker le texte du mois sélectionné
  int moisdebut = 0; // Variable pour stocker le mois sélectionné
  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    moisdebut = currentDate.month;
    _selectedMonthText = _getMonthName(moisdebut).toString();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.035,
      width: screenWidth*0.24,
      child: ElevatedButton(
        onPressed: () {
          // Afficher le picker iOS
          _showMonthPicker(context,moisdebut);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFD0E2FF)), // Couleur de fond
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          _selectedMonthText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF6D6D6D),
            fontSize: screenWidth*0.028,
            fontWeight: FontWeight.w700,
          ), // Afficher le texte du mois sélectionné ou "Mois"
        ),
      ),
    );
  }

  void _showMonthPicker(BuildContext context, int monthdebut) {
    int initialIndex = monthdebut - 1;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            itemExtent: 40.0,
            scrollController: FixedExtentScrollController(initialItem: initialIndex),
            onSelectedItemChanged: (int index) {
              setState(() {
                monthdebut = index + 1;
                _selectedMonthText = _getMonthName(monthdebut); // Mettre à jour le texte du mois sélectionné
                widget.datedebut.setmois(monthdebut as String); // Mettre à jour le mois dans datedebut
              });
            },
            children: List<Widget>.generate(12, (int index) {
              // Générer la liste des mois de janvier à décembre
              int monthNumber = index + 1;
              String monthName = _getMonthName(monthNumber);
              return Center(
                child: Text(
                  monthName,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
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
  String _getMonthName(int monthIndex) {
    switch (monthIndex) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Month';
    }
  }
}
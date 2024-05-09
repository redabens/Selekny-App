
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.04,
      width: screenWidth*0.23,
      child: ElevatedButton(
        onPressed: () {
          // Afficher le picker iOS
          _showMonthPicker(context);
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
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ), // Afficher le texte du mois sélectionné ou "Mois"
        ),
      ),
    );
  }

  void _showMonthPicker(BuildContext context) {
    // Afficher un picker iOS pour choisir le mois
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            itemExtent: 40.0,
            onSelectedItemChanged: (int index) {
              // Mettre à jour le mois sélectionné
              setState(() {
                moisdebut = index + 1;
                _selectedMonthText = _getMonthName(index + 1); // Mettre à jour le texte du mois sélectionné
                widget.datedebut.setmois(_selectedMonthText);
              });
            },
            children: List<Widget>.generate(12, (int index) {
              // Générer la liste des mois de janvier à décembre
              return Center(
                child: Text(
                  _getMonthName(index + 1),
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
        return 'Janvier';
      case 2:
        return 'Février';
      case 3:
        return 'Mars';
      case 4:
        return 'Avril';
      case 5:
        return 'Mai';
      case 6:
        return 'Juin';
      case 7:
        return 'Juillet';
      case 8:
        return 'Août';
      case 9:
        return 'Septembre';
      case 10:
        return 'Octobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Décembre';
      default:
        return 'Mois';
    }
  }
}
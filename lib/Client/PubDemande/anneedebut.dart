

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:reda/Client/components/Date.dart';

class AnneeDebut extends StatefulWidget {
  final Date datedebut;
  const AnneeDebut({
    super.key,
    required this.datedebut,
  });

  @override
  AnneeDebutState createState() => AnneeDebutState();
}


class AnneeDebutState extends State<AnneeDebut> {
  String _selectedYearText = 'Année'; // Variable pour stocker le texte de l'année sélectionnée
  int anneedebut = 2024; // Variable pour stocker l'année sélectionnée
  @override
  void initState() {
    super.initState();
    int currentYear = DateTime.now().year;
    anneedebut = currentYear;
    _selectedYearText = currentYear.toString();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.035,
      width: screenWidth*0.23,
      child: ElevatedButton(
        onPressed: () {
          // Afficher le picker iOS
          _showYearPicker(context,anneedebut);
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
          _selectedYearText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF6D6D6D),
            fontSize: screenWidth*0.026,
            fontWeight: FontWeight.w700,
          ), // Afficher le texte de l'année sélectionnée ou "Année"
        ),
      ),
    );
  }

  void _showYearPicker(BuildContext context, int selectedYear) {
    int initialIndex = 0; // Calculate initial index based on selected year
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
              // Update the selected year
              setState(() {
                int selectedYear = 2024 + index; // Calculate selected year based on index
                _selectedYearText = selectedYear.toString(); // Update the selected year text
                widget.datedebut.setannee(selectedYear); // Update the year in datedebut
              });
            },
            children: List<Widget>.generate(3, (int index) {
              // Generate the list of years 2024, 2025, and 2026
              int year = 2024 + index;
              return Center(
                child: Text(
                  year.toString(),
                  style: GoogleFonts.poppins(fontSize: 20.0),
                ),
              );
            }),
          ),
        );
      },
    ).then((value) {
      // Force the button to rebuild after selection
      setState(() {});
    });
  }

}

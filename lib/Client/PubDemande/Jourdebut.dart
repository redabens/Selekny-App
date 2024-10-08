
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:reda/Client/components/Date.dart';


class JourDebut extends StatefulWidget {
  final Date datedebut;
  const JourDebut({
    super.key,
    required this.datedebut,
  });

  @override
  JourDebutState createState() => JourDebutState();
}

class JourDebutState extends State<JourDebut> {

  String _selectedDayText = 'Jour'; // Variable pour stocker le texte du jour sélectionné
  int jourdebut = 0; // Variable pour stocker le jour sélectionné
  @override
  void initState() {
    super.initState();

    // Initialiser _selectedDayText avec la valeur initiale de datedebut
    jourdebut = widget.datedebut.getjour(); // Obtenez la valeur du jour de datedebut
    _selectedDayText = jourdebut.toString();
  }
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
          _showDayPicker(context,jourdebut);
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

  void _showDayPicker(BuildContext context, int jourdebut) {
    // Calculer l'index initial pour le jour sélectionné
    int initialIndex = jourdebut - 1;

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
                jourdebut = index + 1;
                _selectedDayText = index + 1 < 10 ? '0${(index + 1)}' : '${(index + 1)}'; // Mettre à jour le texte du jour sélectionné
                widget.datedebut.setjour(jourdebut);
              });
            },
            children: List<Widget>.generate(31, (int index) {
              // Générer la liste des jours de 1 à 31
              return Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.poppins(fontSize: 20.0),
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

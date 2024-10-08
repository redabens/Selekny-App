import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:reda/Client/components/Date.dart';

class AnneeFin extends StatefulWidget {
  final Date datefin;
  const AnneeFin({
    super.key,
    required this.datefin,
  });

  @override
  AnneeFinState createState() => AnneeFinState();
}


class AnneeFinState extends State<AnneeFin> {
  String _selectedYearText = 'Année'; // Variable pour stocker le texte de l'année sélectionnée
  int anneefin = 2024; // Variable pour stocker l'année sélectionnée

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.035,
      width: screenWidth*0.21,
      child: ElevatedButton(
        onPressed: () {
          // Afficher le picker iOS
          _showYearPicker(context);
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

  void _showYearPicker(BuildContext context) {
    // Afficher un picker iOS pour choisir l'année
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            itemExtent: 40.0,
            onSelectedItemChanged: (int index) {
              // Mettre à jour l'année sélectionnée
              setState(() {
                anneefin = 2024 + index;
                _selectedYearText = anneefin.toString(); // Mettre à jour le texte de l'année sélectionnée
                widget.datefin.setannee(anneefin);
              });
            },
            children: List<Widget>.generate(3, (int index) {
              // Générer la liste des années 2024, 2025 et 2026
              return Center(
                child: Text(
                  (2024 + index).toString(),
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



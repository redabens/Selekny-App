
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 80,
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
            fontSize: 9,
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
                anneedebut = 2024 + index;
                _selectedYearText = anneedebut.toString(); // Mettre à jour le texte de l'année sélectionnée
                widget.datedebut.setannee(anneedebut);
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



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/components/Demande.dart';




class De extends StatelessWidget {
  final Demande demande;
  const De({
    super.key,
    required this.demande,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
              children: [
                 SizedBox(width:screenWidth*0.01,),
                  Text(
                     'De :',
                    style: GoogleFonts.poppins(
                     color: const Color(0xFF6D6D6D),
                      fontSize: screenWidth*0.022,
                      fontWeight: FontWeight.w700,
                     ),
                  ),
              ],
            ),

            SizedBox(height:screenHeight*0.004),
            HeureDebut(demande: demande,),
          ]
      ),
    );
  }
}

class HeureDebut extends StatefulWidget {
  final Demande demande;
  const HeureDebut({
    super.key,
    required this.demande,
  });

  @override
  State<HeureDebut> createState() => _HeureDebutState();
}

class _HeureDebutState extends State<HeureDebut> {

  String _selectedTimeText = 'Heure';
  TimeOfDay heuredebut = const TimeOfDay(hour: 0, minute: 0); // Initial time
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight*0.035,
      width: screenWidth*0.22, // Adjust width for better time display
      child: ElevatedButton(
        onPressed: () {
          _showTimePicker(context);
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
          _selectedTimeText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF6D6D6D),
            fontSize: 9, // Adjust font size for better readability
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: heuredebut, // Use the previously selected time
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != heuredebut) {
      setState(() {
        heuredebut = pickedTime;
        _selectedTimeText = '${heuredebut.hour.toString().padLeft(2, '0')}:${heuredebut.minute.toString().padLeft(2, '0')}';
        widget.demande.setHeureDebut(_selectedTimeText);
      });
    }
  }
}

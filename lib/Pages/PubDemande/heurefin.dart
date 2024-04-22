import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/components/Demande.dart';



class Jusqua extends StatelessWidget {
  final Demande demande;
  const Jusqua({
    super.key,
    required this.demande,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
              children: [
                const SizedBox(width: 10,),
                Text(
                  'À :',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6D6D6D),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5,),
            HeureFin(demande: demande,),
          ]
      ),
    );
  }
}










class HeureFin extends StatefulWidget {
  final Demande demande;
  const HeureFin({
    super.key,
    required this.demande,
  });

  @override
  HeureFinState createState() => HeureFinState();
}

class HeureFinState extends State<HeureFin> {
  String _selectedTimeText = 'Heure';
  TimeOfDay heurefin = const TimeOfDay(hour: 0, minute: 0); // Initial time
  String getheurefin(){
    return _selectedTimeText;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80, // Adjust width for better time display
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
      initialTime: heurefin, // Use the previously selected time
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != heurefin) {
      setState(() {
        heurefin = pickedTime;
        _selectedTimeText = '${heurefin.hour.toString().padLeft(2, '0')}:${heurefin.minute.toString().padLeft(2, '0')}';
        widget.demande.setHeureFin(_selectedTimeText);
      });
    }
  }
}

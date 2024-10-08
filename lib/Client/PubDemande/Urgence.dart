import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';
import 'package:reda/Client/components/Demande.dart';
import 'detailsDemandeUrgente.dart';


class Urgence extends StatelessWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  final Demande demande;
  final bool urgence;
  const Urgence({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
    required this.demande,
    required this.urgence,
  });
  @override

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      //height: screenHeight*0.11,
      width: screenWidth*0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFEBE5E5),
          width: 2.0,
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'icons/urgent.png',
                  // Assurez-vous de fournir le chemin correct vers votre image
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Demande urgente ?',
                style: GoogleFonts.poppins(
                  color: Colors.black,

                  fontSize:screenWidth*0.035,fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 80,),

              EmergencySwitch(domaineID: domaineID, prestationID: prestationID, nomprestation: nomprestation, demande: demande, urgence: urgence,),


            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              Expanded(child:
              Text(
                'Trouver un prestataire disponible immédiatement',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: screenWidth*0.03,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 5,
              ),
              ),
            ],
          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}


class EmergencySwitch extends StatefulWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  final Demande demande;
  final bool urgence;
  const EmergencySwitch({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
    required this.demande,
    required this.urgence,
});

  @override
  State<EmergencySwitch> createState() => _EmergencySwitchState();
}

class _EmergencySwitchState extends State<EmergencySwitch> {
  bool _emergencyActivated =false;
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    setState(() {
      _emergencyActivated =widget.urgence;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _emergencyActivated = !_emergencyActivated;
          widget.demande.setUrgence(_emergencyActivated);
        });
        if (_emergencyActivated){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DetailsDemandeUrgente(domaineID: widget.domaineID, prestationID: widget.prestationID, nomprestation: widget.nomprestation, )),
          );
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DetailsDemande(domaineID: widget.domaineID, prestationID: widget.prestationID, nomprestation: widget.nomprestation)),
          );
        }
      },
      child: Container(
        width: 48,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _emergencyActivated ? const Color(0xFFFF0017) : const Color(0xFF777777),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _emergencyActivated ? 28.0 : 0.0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


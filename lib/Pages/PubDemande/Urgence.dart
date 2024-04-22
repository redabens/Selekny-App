


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Pages/PubDemande/detailsDemande.dart';
import 'package:reda/components/Demande.dart';
import 'detailsDemandeUrgente.dart';

import 'package:custom_switch_widget/custom_switch_widget.dart';

class Urgence extends StatelessWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  final Demande demande;
  const Urgence({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
    required this.demande,
  });
  @override

  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: 325,
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
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 80,),

              EmergencySwitch(domaineID: domaineID, prestationID: prestationID, nomprestation: nomprestation, demande: demande,),


            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 30),
              Text(
                'Trouver un prestataire disponible immédiatement',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D6D6D),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
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
  const EmergencySwitch({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
    required this.demande,
});

  @override
  State<EmergencySwitch> createState() => _EmergencySwitchState();
}

class _EmergencySwitchState extends State<EmergencySwitch> {
  static bool _emergencyActivated = false;
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    _emergencyActivated =widget.demande.urgence;
    setState(() {
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

/*
class EmergencySwitch extends StatefulWidget {
  @override
  _EmergencySwitchState createState() => _EmergencySwitchState();
}

class _EmergencySwitchState extends State<EmergencySwitch> {
  bool _emergencyActivated = false;
  final CustomSwitchController _controller = CustomSwitchController();
  void _enable() => _controller.enable();

  void _disable() => _controller.disable();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      setState(() {
        this._emergencyActivated = _controller.value;
      });
    });
  }
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomSwitchWidget(


        controller: _controller,
        activeColor: Colors.blueAccent,
        inactiveColor: Colors.blueAccent.withOpacity(.60),
    onChange: (value) {

      if (value) {

        _disable();

      } else {
        _enable();

      }

    }
        ),

      ],
    );
  }


*/
/*
class EmergencySwitch extends StatefulWidget {
  @override
  _EmergencySwitchState createState() => _EmergencySwitchState();
}

class _EmergencySwitchState extends State<EmergencySwitch> {
  bool _emergencyActivated = true;
  final CustomSwitchController _controller = CustomSwitchController();

  void _enable() => _controller.enable();

  void _disable() => _controller.disable();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        this._emergencyActivated = _controller.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomSwitchWidget(
          controller: _controller,
          activeColor: Colors.blueAccent,
          inactiveColor: Colors.blueAccent.withOpacity(.60),
          onChange: (value) {
            setState(() {
              _emergencyActivated = value;
            });
            if (_emergencyActivated) {
              // Navigation vers la page demande urgente
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => detailsDemandeUrgente()),
              );
            }
          },
        ),
      ],
    );
  }
}
*/

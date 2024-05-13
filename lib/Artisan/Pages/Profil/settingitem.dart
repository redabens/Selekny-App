
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsItem extends StatefulWidget {
  final String imagePath;
  final String text;
  final bool isClickable;
  final bool hasSwitch;
  final Function? onTap;
  final bool initialSwitchState; // Ajout de l'état initial du switch

  const SettingsItem({super.key,
    required this.imagePath,
    required this.text,
    this.isClickable = false,
    this.hasSwitch = false,
    this.onTap,
    this.initialSwitchState = false, // Définit l'état initial
  });

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  late bool switchState; // État du switch

  @override
  void initState() {
    super.initState();
    setState(() { switchState = widget.initialSwitchState;// Définir l'état initial
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur de l'écran
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        if (widget.hasSwitch) {
          setState(() {
            switchState = !switchState; // Inverser l'état du switch
          });
        }
        if (widget.onTap != null) {
          widget.onTap!(); // Appeler la fonction si elle est définie
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.imagePath,
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            if (widget.isClickable && widget.text != 'Déconnexion')
              Image.asset(
                'assets/fleche.png',
                width: screenWidth * 0.05,
              ),
            if (widget.hasSwitch)
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: switchState, // Utiliser l'état du switch
                  activeColor: const Color(0xFF3E69FE),
                  inactiveTrackColor: Colors.grey,
                  onChanged: (value) {
                    DocumentReference userRef =
                    FirebaseFirestore.instance.collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid);
                    setState(() {
                      switchState = value;
                      if(widget.text == 'Véhiculé'){
                        userRef.update({'vehicule': switchState});
                      }
                      else if (widget.text == 'Statut'){
                        userRef.update({'statut': switchState});
                      }
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

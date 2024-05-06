import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/Profil/settingitem.dart';
import 'package:reda/Client/Pages/Demandes/HistoriqueArtisanPage.dart';
import 'package:reda/Client/profile/update_profile_screen.dart';
import 'package:reda/Pages/conditongeneral.dart';
import 'package:reda/Pages/contacter.dart';
import '../../../Pages/authentification/connexion.dart';
import '../../../Pages/help.dart';

class SettingsArtisanSection extends StatelessWidget {
  final bool vehicule;
  final bool statut;
  const SettingsArtisanSection({super.key,
    required this.vehicule,
    required this.statut});

  @override
  Widget build(BuildContext context) {
    // Obtenir les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(screenWidth * 0.1),
            topRight: Radius.circular(screenWidth * 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 9,
              offset: const Offset(0, -4), // Ombre orientée vers le haut
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), // Rembourrage proportionnel
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsItem(
                imagePath: 'assets/profil.png',
                text: 'Éditer le profil',
                isClickable: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen(),
                    ),
                  );
                },
              ),

              SettingsItem(
                imagePath: 'assets/historique.png',
                text: 'Historique',
                isClickable: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoriqueArtisanPage(),
                    ),
                  );
                },
              ),
              SettingsItem(
                imagePath: 'assets/contact.png',
                text: 'Contactez-nous',
                isClickable: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactUsPage (),
                    ),
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.02),
                      Icon(Icons.help, size: screenWidth * 0.06),
                      SizedBox(width: screenWidth * 0.055),
                      Text(
                        'Aide',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpPage(), // Page cible
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/fleche.png',
                      width: screenWidth * 0.06,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),
              SettingsItem(
                imagePath: 'assets/condition.png',
                text: 'Conditions générales',
                isClickable: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConditionsGeneralesPage(),
                    ),
                  );
                },
              ),
              SettingsItem(
                imagePath: 'assets/statut.png',
                text: 'Statut',
                hasSwitch: true,
                initialSwitchState: statut,
              ),
              SettingsItem(
                imagePath: 'assets/Car.png',
                text: 'Véhiculé',
                hasSwitch: true,
                initialSwitchState: vehicule,
              ),
              const SettingsItem(
                imagePath: 'assets/sombre.png',
                text: 'Mode sombre',
                hasSwitch: true,
              ),
              SettingsItem(
                imagePath: 'assets/deconexion.png',
                text: 'Déconnexion',
                isClickable: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("SE DECONNECTER"),
                      content: const Text(
                        "Êtes-vous sûr de vouloir vous déconnecter ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Fermer le dialogue
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "NON",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Déconnexion de l'utilisateur
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "OUI",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
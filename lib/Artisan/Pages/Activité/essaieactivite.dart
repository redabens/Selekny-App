import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Définir la page de destination pour le clic sur la flèche
class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Commentaires"),
      ),
      body: Center(
        child: Text(
          "Ceci est la page des commentaires",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// La fonction _buildSelectionRow ajustée
Widget _buildSelectionRow(bool isTodaySelected, Function(bool) onSelectionChange) {
  Color selectedColor = const Color(0xFFF5A529); // Couleur sélectionnée
  Color unselectedColor = Colors.black; // Couleur non sélectionnée

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () => onSelectionChange(true), // Sélectionne "Aujourd'hui"
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
                children: [
                  Image.asset(
                    'image/aujour.png', // Image pour "Aujourd'hui"
                    height: 24,
                    color: isTodaySelected ? selectedColor : unselectedColor, // Change la couleur
                  ),
                  SizedBox(width: 8), // Espace entre l'image et le texte
                  Text(
                    'Aujourd\'hui',
                    style: GoogleFonts.poppins(
                      color: isTodaySelected ? selectedColor : unselectedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 200,
                color: isTodaySelected ? selectedColor : unselectedColor,
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () => onSelectionChange(false), // Sélectionne "À venir"
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Centrer le contenu
                children: [
                  Image.asset(
                    'image/future.png', // Image pour "À venir"
                    height: 24,
                    color: !isTodaySelected ? selectedColor : unselectedColor, // Change la couleur
                  ),
                  const SizedBox(width: 8), // Espace entre l'image et le texte
                  Text(
                    'À venir',
                    style: GoogleFonts.poppins(
                      color: !isTodaySelected ? selectedColor : unselectedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width:200,
                color: !isTodaySelected ? selectedColor : unselectedColor,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
Widget _buildTitleAndDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '• ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSpan(
                text:
                ' Vous pouvez ici consulter vos Activtées, cela represente les jobs à faire dans les jours à venir.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Page principale
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isTodaySelected = true; // Indique si "Aujourd'hui" est sélectionné

  void _handleSelectionChange(bool isToday) {
    setState(() {
      isTodaySelected = isToday;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Activité',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTitleAndDescription(),
            // Ajout du titre et de la description
            SizedBox(height: 24),
            _buildSelectionRow(isTodaySelected, _handleSelectionChange),
            // Sélection des onglets
            SizedBox(height: 24),
            Expanded(
              child: isTodaySelected
                  ? _buildTodayContent()
                  : _buildComingSoonContent(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTodayContent() {
    return Center(
      child: Text(
        'Contenu pour Aujourd\'hui',
        style: GoogleFonts.poppins(fontSize: 18),
      ),
    );
  }

  Widget _buildComingSoonContent() {
    return Center(
      child: Text(
        'Contenu pour À venir',
        style: GoogleFonts.poppins(fontSize: 18),
      ),
    );
  }
}
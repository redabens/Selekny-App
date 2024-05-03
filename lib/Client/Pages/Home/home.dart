import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Demandes/demandeEncours_page.dart';
import 'package:reda/Client/Pages/Home/header.dart';
import 'package:reda/Client/Pages/Home/body.dart';
import 'package:reda/Client/profile/profile_screen.dart';
import 'package:reda/Pages/Chat/chatList_page.dart'; // Importation de la classe Searchbar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late String currentUserID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Column(
        children: [
          Header(),
          SizedBox(
              height:
                  15), // Ajout d'un espace entre le header et le reste du contenu
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Body(
                    type: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex:
            _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/accueil.png',
                  color: _currentIndex == 0
                      ? const Color(0xFF3E69FE)
                      : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemandeEncoursPage(),
                  ),
                );
              },
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/demandes.png',
                  color: _currentIndex == 1
                      ? const Color(0xFF3E69FE)
                      : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatListPage(
                      type: 1,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/messages.png',
                  color: _currentIndex == 2
                      ? const Color(0xFF3E69FE)
                      : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: SizedBox(
                height: 40,
                child: Image.asset(
                  'assets/profile.png',
                  color: _currentIndex == 3
                      ? const Color(0xFF3E69FE)
                      : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:reda/Pages/Home/body.dart';
import 'package:reda/Pages/Home/datails.dart';
import 'package:reda/Pages/Home/header.dart';
import 'package:reda/Pages/Home/search.dart'; // Importation de la classe Searchbar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    //les 4 pages de la navbar
    const HomePage(),
    const DetailPage(),
    const DetailPage(),
    const DetailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Column(
        children: [
          Header(),
          Searchbar(),
          SizedBox(height: 15), // Ajout d'un espace entre le header et le reste du contenu
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Body(),
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
        currentIndex: _currentIndex,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              child: Image.asset(
                'assets/accueil.png',
                color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              child: Image.asset(
                'assets/demandes.png',
                color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              child: Image.asset(
                'assets/messages.png',
                color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors.black,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40,
              child: Image.asset(
                'assets/profile.png',
                color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors.black,
              ),
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
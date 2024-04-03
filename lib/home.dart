import 'package:flutter/material.dart';
import 'package:selek/pages/home/search.dart'; // Importation de la classe Searchbar
import 'package:selek/pages/home/header.dart';
import 'package:selek/pages/home/body.dart';
import 'package:selek/pages/details/commentaire.dart';
import 'package:selek/pages/details/datails.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    //les 4 pages de la navbar
    HomePage(),
    DetailPage(),
    DetailPage(),
    DetailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

    backgroundColor: Color(0xFFF8F8F8),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    currentIndex: _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
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
    MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
    );

    },
    child: Container(
    height: 40,
    child: Image.asset(
    'assets/accueil.png',
    color: _currentIndex == 0 ? Color(0xFF3E69FE) : Colors.black,
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
    MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
    );


    },
    child: Container(
    height: 40,
    child: Image.asset(
    'assets/demandes.png',
    color: _currentIndex == 1 ? Color(0xFF3E69FE) : Colors.black,
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
    MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
    );

    },
    child: Container(
    height: 40,
    child: Image.asset(
    'assets/messages.png',
    color: _currentIndex == 2 ? Color(0xFF3E69FE) : Colors.black,
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
    MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
    );

    },
    child: Container(
    height: 40,
    child: Image.asset(
    'assets/profile.png',
    color: _currentIndex == 3 ? Color(0xFF3E69FE) : Colors.black,
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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reda/Client/Pages/Demandes/demandeEncours_page.dart';
import 'package:reda/Client/Pages/Home/header.dart';
import 'package:reda/Client/Pages/Home/body.dart';
import 'package:reda/Client/profile/profileClient.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    // Ajoute un rappel de retour arrière spécifique à cette page
    ModalRoute.of(context)?.addScopedWillPopCallback(() async {
      // Quitter l'application lorsque le bouton de retour est pressé
      SystemNavigator.pop();
      return false;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Column(
        children: [
          Header(type: 1,),
          SizedBox(height: 15), // Ajout d'un espace entre le header et le reste du contenu
          Expanded(
            child: Body(type: 1,),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F8F8),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage(),),
                );

              },
              child: Container(
                height: screenHeight*0.03,
                child: Image.asset(
                  'assets/accueil.png',
                  color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors.black,
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DemandeEncoursPage(),),
                );


              },
              child: SizedBox(
                height: screenHeight*0.04,
                child: Image.asset(
                  'assets/demandes.png',
                  color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors.black,
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 1,),),
                );

              },
              child: SizedBox(
                height: screenHeight*0.040,
                child: Image.asset(
                  'assets/messages.png',
                  color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors.black,
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilClientPage(),),
                );

              },
              child: Container(
                height: screenHeight*0.03,
                child: Image.asset(
                  'assets/profile.png',
                  color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors.black,
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
class HomePageObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
      SystemNavigator.pop();
  }
}
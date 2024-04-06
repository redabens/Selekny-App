import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/HomePage.dart';
import '../ProfilePage.dart';
import '../ChatPage.dart';
import '../NotificationsPage.dart';
import '../Plomberie.dart';
import 'package:flutter/cupertino.dart';
import 'Materiel.dart';
import 'Prix.dart';
import 'NomPrestation.dart';
import 'Urgence.dart';
import 'date.dart';
import 'heure.dart';
import 'Suivant.dart';





class detailsDemandeUrgente extends StatefulWidget {
  @override
  detailsDemandeUrgenteState createState() => detailsDemandeUrgenteState();

}

class detailsDemandeUrgenteState extends State<detailsDemandeUrgente> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    //les 4 pages de la navbar
    HomePage(),
    NotificationsPage(),
    ChatPage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            NomPrestation(),
            SizedBox(width: 50, height: 25,),
            Materiel(),
            SizedBox(width: 50, height: 25,),
            Prix(),
            SizedBox(width: 50, height: 25,),
            Urgence(),
            SizedBox(width: 50, height: 25,),
            Suivant(),
          ],
        ),




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
                  'icons/accueil.png',
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
                  'icons/demandes.png',
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
                  'icons/messages.png',
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
                  'icons/profile.png',
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


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false, // Désactiver la flèche de retour en arrière
          //backgroundColor: Colors.blue,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //SizedBox(width: 0),
              Container( // Enveloppez l'icône dans un Container pour créer un bouton carré
                height: 40, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Plomberie()),
                    );

                  },
                ),
              ),

              SizedBox(width: 40),
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Détails de la demande',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,

                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/HomePage.dart';
import 'ProfilePage.dart';
import 'ChatPage.dart';
import 'NotificationsPage.dart';
import 'Plomberie.dart';

class Plomberie extends StatefulWidget {
  @override
  PlomberieState createState() => PlomberieState();
}

class PlomberieState extends State<Plomberie> {
  int _currentIndex =0;

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
              Prestation1(),
              Prestation2(),
              Prestation3(),
              Prestation4(),
            ]
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


class Prestation1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/lavabo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Text(
                'Déboucher le lavabo',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  //fontWeight: FontWeight.w00,
                ),
              ),
              SizedBox(width: 87),
              IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF33363F),
                  size: 20,
                ),
                onPressed: () {


                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Prestation2 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 69,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/robinet.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Text(
                'Installation des robinets',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  //fontWeight: FontWeight.w00,
                ),
              ),
              SizedBox(width: 65),
              IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF33363F),
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Prestation3 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 69,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/fuite.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Text(
                'Réparation d\'une fuite d\'eau',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  //fontWeight: FontWeight.w00,
                ),
              ),
              SizedBox(width: 40),
              IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF33363F),
                  size: 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Prestation4 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  Container(
      height: 69,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/machine.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Text(
                'Réparation machine à laver ',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 13,
                  //fontWeight: FontWeight.w00,
                ),
              ),
              SizedBox(width: 40),
              IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF33363F),
                  size: 20,
                ),
                onPressed: () {},
              ),

            ],
          ),
        ],
      ),
    );
  }
}





class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(110);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false, // Désactiver la flèche de retour en arrière
          //backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //SizedBox(width: 0),
              Container( // Enveloppez l'icône dans un Container pour créer un bouton carré
                height: 50, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 30,
                  ),
                  onPressed: () {
                       Navigator.push(
                       context,
                           MaterialPageRoute(builder: (context) => HomePage()),
                       );

                  },
                ),
              ),

              SizedBox(width: 54),
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Plomberie',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,

                  ),
                ),
              ),
              SizedBox(width: 100),
            ],
          ),
        ),
      ],
    );
  }
}
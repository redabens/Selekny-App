import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ProfilePage.dart';
import 'ChatPage.dart';
import 'NotificationsPage.dart';
import 'Plomberie.dart';
import 'HomePage.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex =0;

  final List<Widget> _pages = [
    //les 4 pages de la navbar
    HomePage(),
    NotificationsPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
 // const HomePage({Key? key}) : super(key: key); // Correction de la déclaration du constructeur


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Header(),
          Searchbar(),
          SizedBox(height: 15), // Ajout d'un espace entre le header et le reste du contenu
          Expanded( // Utilisation d'Expanded pour que SingleChildScrollView prenne tout l'espace disponible
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




class Header extends StatelessWidget {
  //const Header({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 16,
        right: 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selekny',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(), // Pour ajouter un espace flexible entre les éléments
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
            icon: Image.asset(
              'assets/Question.png', // Remplacez 'votre_image.png' par le chemin de votre image dans le dossier assets
              width: 30, // Largeur de l'image
              height: 30, // Hauteur de l'image
            ),
          ),
        ],
      ),
    );
  }
}

class Searchbar extends StatelessWidget {
  const Searchbar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 2), // Ajustement de la marge verticale
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.2), // Ajustement du padding vertical
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
            spreadRadius: 5, // Rayon de diffusion de l'ombre
            blurRadius: 7, // Rayon de flou de l'ombre
            offset: const Offset(0, 3), // Décalage de l'ombre
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/Search_alt.png', width: 24, height: 24), // Remplacer 'votre_image.png' par le chemin de votre image
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Chercher un service...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.4),
                ),
                border: InputBorder.none, // Supprime la bordure du champ de saisie
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Body extends StatelessWidget {
  const Body({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Services(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15,top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Service à domicile',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(width: 105), // Espace entre les deux textes
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DetailPage()),
                      );
                    },
                    child: const Text(
                      'Voir tout',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E69FE),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF3E69FE),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Espace entre les sections
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageList2(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ImageList(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Servicepop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: const Center(
        child: Text('Contenu de la page détail'),
      ),
    );
  }
}
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide'),
      ),
      body: const Center(

        child: Text('Contenu de la page détail'),
      ),
    );
  }
}
class ImageList extends StatelessWidget {
  final List<String> imagePaths = [
    "assets/peintre.png",
    "assets/carreleur.png",
    "assets/serrurier.png",
    "assets/femme de menage.png",
  ];

  final List<String> texts = [
    "Peintre",
    "Carreleur",
    "Serrurier",
    "Ménage",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( top:10, left:2), // Ajout de padding au haut de la liste
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(imagePaths.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Plomberie()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      imagePaths[index],
                      width: 79,
                      height: 79,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      texts[index],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
class ImageList2 extends StatelessWidget {
  final List<String> imagePaths = [
    "assets/Plomberie.png",
    "assets/electricite.png",
    "assets/macon.png",
    "assets/menuisier.png",
  ];

  final List<String> texts = [
    "Plombier",
    "Electricien",
    "Maçon",
    "Menuisier",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( top:10, left:2), // Ajout de padding au haut de la liste
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(imagePaths.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Plomberie()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      imagePaths[index],
                      width: 79,
                      height: 79,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      texts[index],
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Servicepop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0), // Ajouter un padding uniforme à gauche et à droite
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services populaires',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10), // Espace entre le texte et les images
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/robinet.jpg',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Espace entre l'image et le texte
                    const Text(
                      'Installation de robinet',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10), // Espace entre les images
              Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DetailPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/chaudiere.jpg',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Espace entre l'image et le texte
                    const Text(
                      'Installation chaudiere',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Services extends StatelessWidget {
  const Services({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130, // Hauteur fixe pour contenir les images agrandies
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 5), // Espacement initial
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 7), // Espacement entre les images
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 7), // Espacement entre les images
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
              child: Container(
                width: 230, // Largeur de l'image agrandie
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
                child: Image.asset('assets/annonce.png', fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(width: 5), // Espacement final
        ],
      ),
    );
  }
}
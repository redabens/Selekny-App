import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
import 'package:reda/Pages/Home/home.dart';
import 'package:reda/Pages/prestation_page.dart';
import 'package:reda/Services/demande%20publication/getMateriel.dart';
import 'package:reda/components/Demande.dart';
import 'package:reda/components/Date.dart';
import '../ProfilePage.dart';
import '../NotificationsPage.dart';
import './Materiel.dart';
import './Prix.dart';
import './NomPrestation.dart';
import './Urgence.dart';
import './date.dart';
import './heure.dart';
import './Suivant.dart';





class DetailsDemande extends StatefulWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  const DetailsDemande({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
  });

  @override
  State<DetailsDemande> createState() => DetailsDemandeState();

}

class DetailsDemandeState extends State<DetailsDemande> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    //les 4 pages de la navbar
    const HomePage(),
    const NotificationsPage(),
    const ChatListPage(currentUserID: 'hskvyxfATXnpgG8vsZlc'),
    const ProfilePage(),
  ];
  String? materiel; // Declare materiel as nullable String
  String? prix;
  late Demande demandeinit = Demande(id_Client: "", id_Artisan: "", id_Prestation: "", urgence: false, date_debut: "", date_fin: "", heure_debut: "", heure_fin: "");
  late Date datedebut = Date(0, "", 0);
  late Date datefin = Date(0, "", 0);
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    _fetchMaterial(widget.domaineID, widget.prestationID);
  }

  Future<void> _fetchMaterial(String domaineID, String prestationID) async {
    try {
      materiel = await getMaterielById(domaineID, prestationID);
      prix = await getPrixById(domaineID, prestationID);
      setState(() {}); // Update UI with fetched material
    } catch (e) {
      print("Erreur lors de la recherche de matériel : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(domaineID: widget.domaineID,),
      body:
      SingleChildScrollView(
          child: Column(
            children: [
              NomPrestation(nomprestation: widget.nomprestation,),
              const SizedBox(width: 50, height: 25,),
              Materiel(materiel: materiel ?? 'rien',),
              const SizedBox(width: 50, height: 25,),
              Prix(prix: prix ?? 'prix',),
              const SizedBox(width: 50, height: 25,),
              Urgence(domaineID: widget.domaineID,prestationID: widget.prestationID,nomprestation: widget.nomprestation,demande: demandeinit,),
              const SizedBox(width: 50, height: 25,),
              Dates(datedebut: datedebut,datefin: datefin,),
              const SizedBox(width: 50, height: 25,),
              Heure(demande: demandeinit,),
              const SizedBox(width: 50, height: 25,),
              Suivant(prestationID: widget.prestationID,demande: demandeinit,datedebut: datedebut,datefin: datefin,),
            ],
          ),




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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
                );

              },
              child: Container(
                height: 40,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
                );


              },
              child: Container(
                height: 40,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
                );

              },
              child: Container(
                height: 40,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _pages[_currentIndex]),
                );

              },
              child: Container(
                height: 40,
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


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String domaineID;
  const MyAppBar({
    super.key, required this.domaineID
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

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
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrestationPage(domaineID: domaineID, indexe: 2)),
                    );

                  },
                ),
              ),

             const SizedBox(width: 40),
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
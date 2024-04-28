import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Client/Pages/Demandes/demandeAcceptee_page.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeEncours_service.dart';
import 'package:reda/Client/components/demandeEncours_container.dart';
import '../Home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/profile/profile_screen.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

//import 'package:reda/Services/GestionUsers/gestionUsers_service.dart';

class DemandeEncoursPage extends StatefulWidget {
  const DemandeEncoursPage({
    super.key,
  });
  @override
  State<DemandeEncoursPage> createState() => _DemandeEncoursPageState();
}

class _DemandeEncoursPageState extends State<DemandeEncoursPage> {
  late String currentUserID;
  int _currentIndex = 1;
  @override
  void _onItemTap(bool isEnCours) {
    setState(() {
      isEnCoursSelected = isEnCours;
    });
  }
  bool isEnCoursSelected = true;

  //---------------LES FONCTION GETTERS---------------------------------------------------
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DemandeEncoursService _DemandeEncoursService = DemandeEncoursService();

  // get id domaine de la demande (general)

  Future<String> getIdDomaineDemande(String demandeID) async {
    final _firestore = FirebaseFirestore.instance;
    final demandeDoc = await _firestore.collection('Demandes').doc(demandeID).get();
    if (!demandeDoc.exists) {
      return 'Demande introuvable';
    }
    final idDomaine = demandeDoc.data()!['id_Domaine'];
    return idDomaine;
  }
 // get id de la prestation (general for the next functions)
  Future<String> getIdPrestationDemande(String demandeID) async {
    final _firestore = FirebaseFirestore.instance;
    final demandeDoc = await _firestore.collection('Demandes').doc(demandeID).get();
    if (!demandeDoc.exists) {
      return 'Demande introuvable';
    }
      final idPres = demandeDoc.data()!['id_Prestation'];
    return idPres;
  }
  // get le nom domaine de la demande encours
  Future<String> getDomaineDemande(String domaineID) async {
    final _firestore = FirebaseFirestore.instance;

    final domaineDoc = await _firestore.collection('Domaine').doc(domaineID).get();
    if (domaineDoc.exists) {
      final domainName = domaineDoc.data()!['Nom'];
      print(' Nom domaine : $domainName');
      return domainName;
    } else {
      return 'Domaine introuvable';
    }
  }

  //get nom prestation de la demande encours
  Future<String> getPrestationDemande(String domaineID,String PrestationID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try{
      DocumentSnapshot domaine = await firestore.collection('Domaine').doc(domaineID).get();
      if (!domaine.exists) {
        throw Exception("Domaine non trouvé");
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(PrestationID).get();
      if (!prestation.exists) {
        throw Exception("Prestation non trouvée");
      }
      return prestation.get('nom_prestation');
    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      return 'Erreur: $e';
    }
  }

  //get prix demande
  Future<String> getPrixDemande(String domaineID,String PrestationID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot domaine = await firestore.collection('Domaine').doc(domaineID).get();
      if (!domaine.exists) {
        throw Exception("Domaine non trouvé");
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(PrestationID).get();
      if (!prestation.exists) {
        throw Exception("Prestation non trouvée");
      }
      return prestation.get('prix');
    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      return 'Erreur: $e';
    }
  }

  // get heure debut et heure fin
  Future<String> getHeureDemande(String demandeID) async {
    final _firestore = FirebaseFirestore.instance;
    final demandeDoc = await _firestore.collection('Demandes').doc(demandeID).get();
    if (!demandeDoc.exists) {
      return 'Demande introuvable';
    }
    final heureDebut = demandeDoc.data()!['heure_debut'];
    final heureFin = demandeDoc.data()!['heure_fin'];
   final String intervalleHeure = '$heureDebut - $heureFin';
    return intervalleHeure;
  }

  // get sync (il y a 5 min)
  Future<String> getSyncDemande(String demandeID) async {
    final _firestore = FirebaseFirestore.instance;
    final demandeDoc = await _firestore.collection('Demandes').doc(demandeID).get();

    if (!demandeDoc.exists) {
      return 'Demande introuvable';
    }
    final Timestamp timestamp = demandeDoc.data()!['timestamp'];
    final DateTime timeDemande = timestamp.toDate();
    final DateTime now = DateTime.now();
    Duration difference = now.difference(timeDemande);
    if (difference.inDays > 0) {
      return 'il y a ${difference.inDays} jr';
    } else if (difference.inHours > 0) {
      return 'il y a ${difference.inHours} h';
    } else if (difference.inMinutes > 0) {
      return 'il y a ${difference.inMinutes} min';
    } else {
      return 'il y a ${difference.inSeconds} second';
    }
  }

  // get boolean demande urgente
  Future<bool> getUrgenceBoolDemande(String demandeID) async {
    final _firestore = FirebaseFirestore.instance;
    final demandeDoc = await _firestore.collection('Demandes').doc(demandeID).get();
    if (demandeDoc.exists) {
      final urgent = demandeDoc.data()!['urgence'];
      return urgent;
    }else{
     return false;
   }
  }

  //--------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // espace fo9 titre de la page
          SizedBox(height: 20.0),
          AppBar(
            elevation: 0.0,
            // Remove default shadow
            backgroundColor: Colors.white,
            title: Text(
              'Demandes',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 18),
          _buildTitleAndDescription(), // le petit texte du début
          SizedBox(height: 10),
          _buildSelectionRow(),
          const SizedBox(height: 2),
          Expanded(
            child: _buildDemandeEncoursList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
      //-------------------------------------------NAVIGATION BAAAAAR--------------------
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
                  MaterialPageRoute(builder: (context) => const HomePage(),),
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
                  MaterialPageRoute(builder: (context) => const DemandeEncoursPage(),),
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
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 1,),),
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
                  MaterialPageRoute(builder: (context) => const ProfilePage(),),
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

  Widget _buildDemandeEncoursList(){
    return StreamBuilder(
      stream: _DemandeEncoursService.getDemandesEnCours(), //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        final documents = snapshot.data!.docs;

        // Print details of each document
        for (var doc in documents) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(snapshot.data!.docs.map((document) => _buildDemandeEncoursItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading demandes encours:  ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  }

  Future<Widget> _buildDemandeEncoursItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String demandeID = document.id;

   final String domaineID =  data['id_Domaine'];
   final String prestationID = data['id_Prestation'];

    final String domaineName = await getDomaineDemande(domaineID);
    final String prestation = await getPrestationDemande(domaineID,prestationID);
    final String prix = await getPrixDemande(domaineID,prestationID);
    final String date = data['date_debut'];
    final String heure = '${data['heure_debut']} - ${data['heure_fin']}';
    final String sync = await getSyncDemande(demandeID);
    final bool urgence = data['urgence'];


    print('id de la demande .... $demandeID');
    print("domaine demande: $domaineName");

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetDemandeEncours(domaine: domaineName,
              prestation: prestation,
              date: date,
              heure: heure,
              prix: prix,
              sync: sync,
          urgence: urgence,),
        ],
      ),
    );
  }

//---------------------------------------------------------------------------------------------------

  Widget _buildSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _onItemTap(true),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'En-cours',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 4 : 1, // Épaisseur de la ligne
                  color: isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => const DemandeAccepteePage())),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Text(
                  'Acceptées',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: !isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 1 : 4, // Épaisseur de la ligne
                  color: !isEnCoursSelected ? Color(0xFFF5A529) : Colors.grey,
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
        SizedBox(height: 0),
        Padding( // Add Padding widget here
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          // Set padding values
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
                  ' Vous pouvez ici consulter vos demandes en cours, en attente, et celles qui sont confirmées pour la date du rendez-vous.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
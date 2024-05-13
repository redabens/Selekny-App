import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reda/Client/Pages/Demandes/demandeAcceptee_page.dart';
import 'package:reda/Client/Services/demande%20publication/DemandeEncours_service.dart';
import 'package:reda/Client/components/demandeEncours_container.dart';
import 'package:reda/Services/ModifPrix.dart';
import '../../profile/profileClient.dart';
import '../Home/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

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
  void _onItemTap(bool isEnCours) {
    setState(() {
      isEnCoursSelected = isEnCours;
    });
  }
  bool isEnCoursSelected = true;

  //---------------LES FONCTION GETTERS---------------------------------------------------
  final DemandeEncoursService _DemandeEncoursService = DemandeEncoursService();
  final ModifPrixService _modifPrixService = ModifPrixService();
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
    print('$timeDemande');
    print('$now');
    Duration diff = now.difference(timeDemande);
    Duration difference = diff - const Duration(hours: 1);
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
  bool hasPassedDate(String dateString) {
    // Parse the date string from Firestore
    try {
      final formatter = DateFormat('dd MMMM yyyy');
      final parsedDate = formatter.parse(dateString);
      // Obtenir la date d'aujourd'hui à minuit
      final midnightToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return parsedDate.isBefore(midnightToday); // Retourne vrai si la date est avant aujourd'hui à minuit
    } on FormatException catch (e) {
      print('Error parsing date string: $e');
      // Gérer l'erreur de formatage de manière élégante (par exemple, retourner faux ou lancer une exception)
      return false;
    }
  }

  //--------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
          SizedBox(height:screenHeight*0.02),
          _buildTitleAndDescription(), // le petit texte du début
          SizedBox(height:screenHeight*0.01),
          _buildSelectionRow(),
          SizedBox(height: screenHeight*0.02),
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilClientPage(),),
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
        final filteredDocuments = documents.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return !hasPassedDate(data['date_debut']);
        }).toList();
        for (var document in documents) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (hasPassedDate(data['date_debut'])) {
            _DemandeEncoursService.deleteDemande(document.id);
            print('suprimer');
          }
        }
        // Print details of each document
        for (var doc in filteredDocuments) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(filteredDocuments.map((document) => _buildDemandeEncoursItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading demandes encours:  ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Text(
                        'Vous n''avez aucune demande encours.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        )
                    )
                );
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
    final String prix = await _modifPrixService.getPrixPrestation(domaineID, prestationID);
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
                const SizedBox(height: 10), // Espace entre le texte et la ligne
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
                const SizedBox(height: 10), // Espace entre le texte et la ligne
                Container(
                  height: isEnCoursSelected ? 1 : 4, // Épaisseur de la ligne
                  color: !isEnCoursSelected ? const Color(0xFFF5A529) : Colors.grey,
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
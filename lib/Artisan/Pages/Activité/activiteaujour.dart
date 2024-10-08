
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activitavenir.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Artisan/Pages/Profil/profileArtisan.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
import '../../../Client/Services/demande publication/RendezVous_Service.dart';
import 'infoboxauj.dart';
class ActiviteaujourPage extends StatefulWidget {
  const ActiviteaujourPage({super.key});

  @override
  State<ActiviteaujourPage> createState() => _ActiviteaujourPageState();
}

class _ActiviteaujourPageState extends State<ActiviteaujourPage> {
  int _currentIndex = 0;
  bool isAujourdhui = true;
  final RendezVousService _rendezVousService = RendezVousService();
  DateTime now = DateTime.now();
  void _onItemTap(bool isAujourdhui) {
    setState(() {
      this.isAujourdhui = isAujourdhui;
    });
  }
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      print('here');
      String pathImage = userDoc['pathImage'];
      print(pathImage);
      // Retourner le PathImage
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      try {
        // Get the download URL for the user image
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } catch (error) {
        print("Error fetching user image URL: $error");
        return ''; // Default image on error
      }
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return '';
    }
  }
  Future<String> getNameUser(String userID) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String userName = userDoc.data()!['nom'] as String;
    return userName;
  }
//get phone number de l'artisan
  Future<String> getPhoneUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String phone = userDoc.data()!['numTel'] as String;
    return phone;
  }
  Future<String> getSyncDemande(Timestamp timestamp) async {
    final DateTime timeDemande = timestamp.toDate();
    final DateTime now = DateTime.now();
    Duration difference = now.difference(timeDemande);
    if (difference.inDays > 0) {
      return 'Envoyé il y''a ${difference.inDays} jr';
    } else if (difference.inHours > 0) {
      return 'Envoyé il y''a ${difference.inHours} h';
    } else if (difference.inMinutes > 0) {
      return 'Envoyé il y''a ${difference.inMinutes} min';
    } else {
      return 'Envoyé il y''a ${difference.inSeconds} second';
    }
  }
  // get Vehicule user
  Future<bool> getVehiculeUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      print('introuvable');
      return false;
    }
    final bool vehicule = userDoc.data()!['vehicule'] as bool;
    return vehicule;
  }
  Future<String> getNomPrestation(String idPrestation, String idDomaine) async {
    try {
      final domainsCollection = FirebaseFirestore.instance.collection('Domaine');
      final domainDocument = domainsCollection.doc(idDomaine);
      final prestationsCollection = domainDocument.collection('Prestations');
      final prestationDocument = prestationsCollection.doc(idPrestation);
      final nomPrestation = await prestationDocument.get().then((snapshot) => snapshot.data()?['nom_prestation']);
      print(nomPrestation);
      return nomPrestation ?? ''; // Return empty string if not found
    } catch (error) {
      print('Error fetching nomPrestation: $error');
      return ''; // Return empty string on error
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
  Future<String> getTokenById(String id) async {
    late String? token;
    Map<String, dynamic> userData = {};
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (documentSnapshot.exists) {
        userData = documentSnapshot.data()!;
        token = userData['token'];
        print("Get token by id : ${token}");
      }
      if (token != null) {
        return token;
      } else {
        return '';
      }
    } catch (e) {
      print("Erreur lors de la recuperation du token du user : ${e}");
    }

    return '';
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(
                'Activité',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth*0.07,
                  fontWeight: FontWeight.w700,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            _buildDescription(),
            SizedBox(height:screenHeight*0.02),
            _buildSelectionRow(),

            Expanded(child: _buildRendezVousList(),)
          ]
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
                  MaterialPageRoute(builder: (context) => const ActiviteaujourPage()),
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
                  MaterialPageRoute(builder: (context) => const NotifUrgente()),
                );


              },
              child: Container(
                height: screenHeight*0.035,
                child: Image.asset(
                  'assets/Ademandes.png',
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
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 2,)),
                );

              },
              child: Container(
                height:screenHeight*0.04,
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
                  MaterialPageRoute(builder: (context) => const ProfilArtisanPage()),
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
  Widget _buildRendezVousList() {
    return StreamBuilder(
      stream: _rendezVousService.getRendezVous(FirebaseAuth.instance.currentUser!.uid),
      //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final documents = snapshot.data!.docs;
        String formattedDate = DateFormat('dd MMMM yyyy').format(now);
        final filteredDocuments = documents.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return !hasPassedDate(data['datedebut']);
        }).toList();
        final urgentDocuments = filteredDocuments.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          return data['datedebut'] == formattedDate;
        }).toList();
        for (var document in documents) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (hasPassedDate(data['datedebut'])) {
            _rendezVousService.deleteRendezVousID(document.id);
          }
        }
        // Print details of each non-urgent document (optional)
        for (var doc in urgentDocuments) {
          print("Document Data (non-urgent): ${doc.data()}");
        }

        return FutureBuilder<List<Widget>>(
          future: Future.wait(
            urgentDocuments.map((document) => _buildRendezVousItem(document)),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading comments: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                      'Vous n\'avez aucune Activité.',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      )
                  )
              );
            }
            return ListView(children: snapshot.data!);
          },
        );
      },
    );
  }
  // build message item
  Future<Widget> _buildRendezVousItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print('${data['idclient']} et ${data['idprestation']} et ${data['iddomaine']}');
    String image = await getUserPathImage(data['idclient']);
    print("l'url:$image");
    String nomprestation = await getNomPrestation(
        data['idprestation'], data['iddomaine']);
    print(nomprestation);
    String nomClient = await getNameUser(data['idclient']);
    String phone = await getPhoneUser(data['idclient']);
    bool vehicule = await getVehiculeUser(data['idclient']);
    final String sync = await getSyncDemande(data['timestamp']);
    String nomArtisan = await getNameUser(FirebaseAuth.instance.currentUser!.uid);
    String tokenClient = await getTokenById(data['idclient']);
    String tokenArtisan = await getTokenById(data['idartisan']);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InfoBoxaujour(
            datedebut: data['datedebut'],
            datefin: data['datefin'],
            prestation: nomprestation,
            heureDebut: data['heuredebut'],
            heureFin: data['heurefin'],
            adresse: data['adresse'],
            photoUrl: image,
            iddomaine: data['iddomaine'],
            idprestation: data['idprestation'],
            idclient: data['idclient'],
            urgence: data['urgence'],
            timestamp: data['timestamp'],
            latitude: data['latitude'],
            longitude: data['longitude'],
            nomclient: nomClient,
            phone: phone,
            demandeid: document.id,
            sync: sync,
            nomArtisan: nomArtisan,
            idartisan: FirebaseAuth.instance.currentUser!.uid,
            vehicule: vehicule, tokenClient: tokenClient, tokenArtisan: tokenArtisan,
          ),
          const SizedBox(height: 2,),
        ],
      ),
    );
  }

  Widget _buildSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _onItemTap(true),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset('assets/aujour.png', color: isAujourdhui ? const Color(0xFFF5A529) : Colors.grey),
                    const SizedBox(width:5),
                    Text(
                      'Aujourd\'hui',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: isAujourdhui ? const Color(0xFFF5A529) : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10), // Espace entre le texte et la ligne
                Container(
                  height: isAujourdhui ? 4 : 1, // Épaisseur de la ligne
                  color: isAujourdhui ? const Color(0xFFF5A529) : Colors.grey,
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
                    builder: (context) => const ActivitAvenirPage())),
            child: Column( // Utiliser une colonne pour séparer le texte de la ligne
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset('assets/time.png', color: isAujourdhui ? Colors.grey : const Color(0xFFF5A529) ),
                    SizedBox(width:5),
                    Text(textAlign: TextAlign.center,
                      'A venir',

                      style: GoogleFonts.poppins(
                        color: !isAujourdhui ? const Color(0xFFF5A529) : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16), // Espace entre le texte et la ligne
                Container(
                  height: isAujourdhui ? 1 : 4, // Épaisseur de la ligne
                  color: !isAujourdhui? const Color(0xFFF5A529) : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                TextSpan(
                  text:
                  ' Vous pouvez ici consulter vos Activtées, cela represente les jobs à faire aujourd\'hui.',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
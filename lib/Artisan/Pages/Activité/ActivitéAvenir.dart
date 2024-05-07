import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Today.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/ActiviteWidget/JobsAndComments.dart';
import 'package:reda/Artisan/Pages/Notifications/BoxDemande.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Client/Services/demande%20publication/RendezVous_Service.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

import '../Profil/profileArtisan.dart';

class ActiviteAvenir extends StatefulWidget {
  const ActiviteAvenir({super.key});

  @override
  ActiviteAvenirState createState() => ActiviteAvenirState();

}

class ActiviteAvenirState extends State<ActiviteAvenir> {
  int _currentIndex = 0;
  final RendezVousService _rendezVousService = RendezVousService();
  DateTime now = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Column(
          children: [
            const Jobsandcomments(),
            const Buttons(),
            const SizedBox(width: 20, height: 20),
            Expanded(child: _buildRendezVousList(),)
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActiviteAvenir()),
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
                  MaterialPageRoute(builder: (context) => const NotifUrgente()),
                );


              },
              child: Container(
                height: 40,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 2,)),
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
                  MaterialPageRoute(builder: (context) => const ProfilArtisanPage()),
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
  Widget _buildRendezVousList() {
    return StreamBuilder(
      stream: _rendezVousService.getRendezVous(
          FirebaseAuth.instance.currentUser!.uid),
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
        // Filter documents based on urgency (urgence == false)
        final nonUrgentDocuments = documents.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data['datedebut'] != formattedDate;
        });

        // Print details of each non-urgent document (optional)
        for (var doc in nonUrgentDocuments) {
          print("Document Data (non-urgent): ${doc.data()}");
        }

        return FutureBuilder<List<Widget>>(
          future: Future.wait(
            nonUrgentDocuments.map((document) => _buildRendezVousItem(document)),
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
                      'Vous n''avez aucune Activité.',
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxDemande(
            datedebut: data['datedebut'],
            heuredebut: data['heuredebut'],
            adresse: data['adresse'],
            iddomaine: data['iddomaine'],
            idprestation: data['idprestation'],
            idclient: data['idclient'],
            urgence: data['urgence'],
            timestamp: data['timestamp'],
            nomprestation: nomprestation,
            imageUrl: image, datefin: data['datefin'],
            heurefin: data['heurefin'], latitude: data['latitude'],
            longitude: data['longitude'], type1: 2, type2: 2,
            nomclient: nomClient, phone: phone,
            demandeid: document.id, sync: sync,
            nomArtisan: nomArtisan, idartisan: FirebaseAuth.instance.currentUser!.uid, vehicule: vehicule,),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false, // Désactiver la flèche de retour en arrière
          //backgroundColor: Colors.blue,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 30,),
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Activité',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
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


class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: 60,
      color: Colors.white,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          TodayButton(),
          AvenirButton(),
        ],
      ),

    );

  }
}




class AvenirButton extends StatelessWidget {
  const AvenirButton({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
        child: GestureDetector(
          onTap: (){},
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.zero, // Pas de coin arrondi
              border: Border(
              bottom: BorderSide(
              color: Color(0xFFF5A529),
              width: 2,
              ),
            ),
            ),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      [
                    Row(

                children:
                      [
                      Container(
                        height: 15,
                        width:15,
                        child: const ImageIcon(
                        AssetImage('assets/heure.png'),
                        color: Color(0xFFF5A529),
                        ),),

                        const SizedBox(width: 5),
                        Text(
                          'À venir',
                          style: GoogleFonts.poppins(
                          color: const Color(0xFFF5A529),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,

                          ),
                        ),
                        ],),
                    ],),
                  ),
            ),
        );
  }

  }
class TodayButton extends StatelessWidget {
  const TodayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 40,
      child: GestureDetector(
        onTap: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActiviteToday()),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero, // Pas de coin arrondi
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFC4C4C4),
                width: 2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [

              Row(
                children:
                [
                  Container(
                    height: 20,
                    width:20,
                    child: const ImageIcon(
                      AssetImage('assets/auj.png'),
                      color: Color(0xFFC4C4C4),
                    ),),


                  Text(
                    'Aujourd\'hui',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFC4C4C4),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,

                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}








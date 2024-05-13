import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/activiteaujour.dart';
import 'package:reda/Artisan/Pages/Notifications/BoxDemande.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifDemande.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

import '../Profil/profileArtisan.dart';

class NotifUrgente extends StatefulWidget {
  const NotifUrgente({super.key});

  @override
  NotifUrgenteState createState() => NotifUrgenteState();

}

class NotifUrgenteState extends State<NotifUrgente> {
  int _currentIndex = 1;
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();

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
    Duration diff = now.difference(timeDemande);
    Duration difference = diff - const Duration(hours: 1);
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
          const SizedBox(height: 18,),
          _buildTitleAndDescription(),
          const SizedBox(height: 10,),
          const Buttons(),
          const SizedBox(width: 20, height: 20),
          Expanded(
            child: _buildDemandeArtisanList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        // Assurez-vous de mettre l'index correct pour la page de profil
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
                  MaterialPageRoute(builder: (context) => const ActiviteaujourPage()),
                );
              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/accueil.png',
                  color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors
                      .black,
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
                  color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors
                      .black,
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
                  color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors
                      .black,
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
                  color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors
                      .black,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildDemandeArtisanList() {
    return StreamBuilder(
      stream: _demandeArtisanService.getDemandeArtisan(
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

        // Filter documents based on urgency (urgence == false)
        final UrgentDocuments = documents.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return data['urgence'] == true;
        });

        // Print details of each non-urgent document (optional)
        for (var doc in UrgentDocuments) {
          print("Document Data (non-urgent): ${doc.data()}");
        }

        return FutureBuilder<List<Widget>>(
          future: Future.wait(
            UrgentDocuments.map((document) => _buildCommentaireItem(document)),
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
                      'Vous n''avez aucune demande urgente.',
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
  Future<Widget> _buildCommentaireItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print('${data['idclient']} et ${data['idprestation']} et ${data['iddomaine']}');
    String image = await getUserPathImage(data['idclient']);
    print("l'url:$image");
    String nomprestation = await getNomPrestation(
        data['idprestation'], data['iddomaine']);
    print(nomprestation);
    String idartisan = data['idartisan'];
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
            longitude: data['longitude'],
            type1: 1, type2: 1,
            nomclient: nomClient, phone: phone,
            demandeid: data['demandeid'], sync: sync,
            nomArtisan: nomArtisan, idartisan: idartisan, vehicule: vehicule,),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
  Widget _buildTitleAndDescription() {
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
                const TextSpan(
                  text:
                  ' Vous pouvez ici consulter vos demandes Urgente, une fois accepter vous proposerai votre service au client.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Mes Notifications',
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

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override

  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
        children: [
          UrgentButton(),
          demandeButton(),
        ],
      ),

    );

  }
}



class UrgentButton extends StatelessWidget {
  const UrgentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 55,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotifUrgente()),
        ),

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
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Urgentes',
              style: GoogleFonts.poppins(
                color: Color(0xFFF5A529),
                fontSize: 15,
                fontWeight: FontWeight.w500,

              ),
            ),
          ),
        ),
      ),
    );
  }

}

class demandeButton extends StatelessWidget {
  const demandeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 55,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotifDemande()),
        ),

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
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Demandes',
              style: GoogleFonts.poppins(
                color: const Color(0xFFC4C4C4),
                fontSize: 15,
                fontWeight: FontWeight.w500,

              ),
            ),
          ),
        ),
      ),
    );
  }
}






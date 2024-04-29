import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Avenir.dart';
import 'package:reda/Artisan/Pages/Notifications/BoxDemande.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Client/profile/profile_screen.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';

class NotifDemande extends StatefulWidget {
  const NotifDemande({super.key});

  @override
  NotifDemandeState createState() => NotifDemandeState();

}

class NotifDemandeState extends State<NotifDemande> {
  int _currentIndex = 1;
  final DemandeArtisanService _demandeArtisanService =DemandeArtisanService();
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
      print('pathImage');
      // Retourner le PathImage
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      final url = await reference.getDownloadURL();
      print(url);
      return url;
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return 'assets/images/placeholder.png';
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
      appBar: const MyAppBar(),
      body: Column(
          children: [
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
              child: SizedBox(
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
                  MaterialPageRoute(builder: (context) => const NotifUrgente(),),
                );


              },
              child: SizedBox(
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
              child: SizedBox(
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );

              },
              child: SizedBox(
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
  Widget _buildDemandeArtisanList() {
    return StreamBuilder(
      stream: _demandeArtisanService.getDemandeArtisan(FirebaseAuth.instance.currentUser!.uid), //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final documents = snapshot.data!.docs;

        // Filter documents based on urgency (urgence == false)
        final nonUrgentDocuments = documents.where((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return !data['urgence'];
        });

        // Print details of each non-urgent document (optional)
        for (var doc in nonUrgentDocuments) {
          print("Document Data (non-urgent): ${doc.data()}");
        }

        return FutureBuilder<List<Widget>>(
          future: Future.wait(
            nonUrgentDocuments.map((document) => _buildCommentaireItem(document)),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error loading demande: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
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
    String image = await getUserPathImage(data['idclient']);
      print("l'url:$image");
    String nomprestation = await getNomPrestation(data['idprestation'], data['iddomaine']);
      print(nomprestation);
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
            longitude: data['longitude'], type1: 1, type2: 1,),
          const SizedBox(height: 10,),
        ],
      ),
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
    return SizedBox(
      width: 205,
      height: 55,
      child: GestureDetector(
        onTap: () =>   Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotifUrgente()),
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
              'Urgentes',
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

class demandeButton extends StatelessWidget {
  const demandeButton({super.key});

@override
Widget build(BuildContext context) {
  return SizedBox(
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
              color: Color(0xFFF5A529),
              width: 2,
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            'Demandes',
            style: GoogleFonts.poppins(
              color: const Color(0xFFF5A529),
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









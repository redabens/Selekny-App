
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Avenir.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/ActiviteWidget/ButtonActivite.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/ActiviteWidget/JobsAndComments.dart';
import 'package:reda/Artisan/Pages/Notifications/BoxDemande.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'package:reda/Pages/retourAuth.dart';

class ActiviteToday extends StatefulWidget {
  const ActiviteToday({super.key});

  @override
  ActiviteTodayState createState() => ActiviteTodayState();

}

class ActiviteTodayState extends State<ActiviteToday> {
  int _currentIndex = 0;
  final DemandeArtisanService _demandeArtisanService = DemandeArtisanService();
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
        return 'assets/images/placeholder.png'; // Default image on error
      }
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
            const Jobsandcomments(),
            const SizedBox(width: 20, height: 20),
            const Buttons(),
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
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
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
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
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
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
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
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
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
      stream: _demandeArtisanService.getRendezVous(
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
          return data['datedebut'] == formattedDate;
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
            longitude: data['longitude'], type: 2,),
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
      height: 60,
      color: Colors.white,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,// Align children to the start
        children: [
          SizedBox(width: 10),
          TodayButton(),
          AvenirButton(),
        ],
      ),

    );

  }
}
class TodayButton extends StatelessWidget {
  const TodayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 40,
      child: GestureDetector(


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
            children:
            [
              const SizedBox(width: 30,),

            Container(
            height: 20,
            width:20,
            child: const ImageIcon(
              AssetImage('assets/auj.png'),
                 color: Color(0xFFF5C443),
            ),),


              Text(
            'Aujourd\'hui',
              style: GoogleFonts.poppins(
                color: const Color(0xFFF5A529),
                fontSize: 13,
                fontWeight: FontWeight.w600,

              ),
            ),

          ],
          ),
        ),
      ),
    );
  }

}
class AvenirButton extends StatelessWidget {
  const AvenirButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 40,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ActiviteAvenir()),
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
          child: Row(
            children:
            [
              const SizedBox(width: 40),
              Container(
                height: 15,
                width:15,
                child: const ImageIcon(
                  AssetImage('assets/heure.png'),
                  color: Color(0xFFC4C4C4),
                ),),

              const SizedBox(width: 5),
              Text(
                'À venir',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFC4C4C4),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
/*class BoxDemandeUrgente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 2.0,
        ),
      ),
      child:Column(
          children:
          [
            const SizedBox(height: 8,),
            pdpanddetailsUrgente(),
            detailsbottom(),
          ]


      ),
    );
  }
}

class pdpanddetailsUrgente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 95,
      // color: Colors.green,

      child: Row(
          children:
          [

            detailsUrgent(),
            Pdp(),
          ]
      ),


    );
  }

}



class detailsUrgent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 235,
        height: 95,
        //color: Colors.red,
        child: Column(
            children:
            [
              NomPrestation(),

              HeureUrgent(),
              Lieu(),
            ]

        )


    );

  }

}
class HeureUrgent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 30,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(

          children: [
          const SizedBox(width: 7),
          Container(
            height: 17,
            width: 17,
            child: Image.asset(

              'icons/heure.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width: 7),
          Text(
            '14h-14h30',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          ],
          ),

          ButtonUrgent(),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}

class Salut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 325,
      child:
          Container(
            height: 30,
          child:Text(
            'Bonjour Yousra , vous avez 2 jobs à faire aujourd\'hui , vous commencez à 14h',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w400,

            ),
          ),

      ),


    );
  }
}*/



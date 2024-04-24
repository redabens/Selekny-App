import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Services/DemandeArtisanService.dart';
import 'NotifUrgente.dart';

class NotifDemande extends StatefulWidget {
  const NotifDemande({super.key});

  @override
  NotifDemandeState createState() => NotifDemandeState();

}

class NotifDemandeState extends State<NotifDemande> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    //les 4 pages de la navbar
    // HomePage(),
    const NotifUrgente(),
    // ChatPage(),
    // ProfilePage(),
  ];


  String currentUserID = '';
  Future<String?> getUserIdFromFirestore(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si un document correspondant est trouvé, retournez son ID
        return querySnapshot.docs.first.id;
      } else {
        print('Aucun utilisateur trouvé pour l\'adresse e-mail : $email');
        return null;
      }
    } catch (e) {
      print(
          'Erreur lors de la recherche de l\'utilisateur dans Firestore : $e');
      return null;
    }
  }
  Future<void> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    String? email = currentUser?.email;
    String? id = await getUserIdFromFirestore(email ?? '');
    if(email != null){
      currentUserID = id ?? '';
    }
  }
  final DemandeArtisanService _demandeArtisanService =DemandeArtisanService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            const Buttons(),
            const SizedBox(width: 20, height: 20),
            _buildDemandeArtisanList(),
          ],
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
                  'assets/Ademandes.png',
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
  Widget _buildDemandeArtisanList() {
    return StreamBuilder(
      stream: _demandeArtisanService.getDemandeArtisan(currentUserID), //_firebaseAuth.currentUser!.uid
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
  Future<Widget> _buildCommentaireItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String profileImage = "assets/images/placeholder.png"; // Default image
    String userName = "";
    try {
      /*profileImage = await getUserPathImage(data['userID']);
      print("l'url:$profileImage");
      userName = await getUserName(data['userID']);
      print("le nom:$userName");*/
    } catch (error) {
      print("Error fetching user image: $error");
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BoxDemande(datedebut: data['datedebut'], heuredebut: data['heuredebut'],
            adresse: data['adresse'], iddomaine: data['iddomaine'],
            idprestation: data['idprestation'], idclient: data['idclient'],
            urgence: data['urgence'], timestamp: data['timestamp'],),

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
    return Container(
      width: 175,
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
                color: Color(0xFFC4C4C4),
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
    width: 175,
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




class BoxDemande extends StatefulWidget {
  final String datedebut;
  final String heuredebut;
  final String adresse;
  final String iddomaine;
  final String idprestation;
  final String idclient;
  final bool urgence;
  final Timestamp timestamp;
  const BoxDemande({super.key, required this.datedebut, required this.heuredebut, required this.adresse, required this.iddomaine, required this.idprestation, required this.idclient, required this.urgence, required this.timestamp,});
  @override
  State<BoxDemande> createState() => _BoxDemandeState();
}

class _BoxDemandeState extends State<BoxDemande> {
  late String nomprestation;
  Future<void> getNomPrestationById(String domainId, String prestationId) async {

    final domainsCollection = FirebaseFirestore.instance.collection('Domaine');
    final domainDocument = domainsCollection.doc(domainId);
    final prestationsCollection = domainDocument.collection('Prestations');

    final prestationDocument = prestationsCollection.doc(prestationId);

    nomprestation = await prestationDocument.get().then((snapshot) => snapshot.data()?['nom_prestation']);
  }
  @override
  void initState(){
    super.initState();
    getNomPrestationById(widget.iddomaine, widget.idprestation);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 140,
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
            pdpanddetails(nomprestation: nomprestation, idClient: widget.idclient, datedebut: widget.datedebut,heuredebut: widget.heuredebut,adresse: widget.adresse,),
            const detailsbottom(),
          ]


      ),
    );
  }
}
class pdpanddetails extends StatelessWidget {
  final String idClient;
  final String nomprestation;
  final String datedebut;
  final String heuredebut;
  final String adresse;
  const pdpanddetails({
    super.key,
    required this.nomprestation, required this.idClient, required this.datedebut, required this.heuredebut, required this.adresse,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 95,
      // color: Colors.green,

      child: Row(
          children:
          [
            pdp(userId: idClient,),
            Details(nomprestation: nomprestation, adresse: adresse,
              datedebut: datedebut, heuredebut: heuredebut,),
          ]
      ),


    );
  }

}


class pdp extends StatefulWidget {
  final String userId;
  const pdp({super.key, required this.userId,});
  @override
  State<pdp> createState() => _pdpState();
}

class _pdpState extends State<pdp> {
  Future<String> getImageUrl(String imagePath) async {
    try {
      final reference = FirebaseStorage.instance.ref().child(imagePath);
      final url = await reference.getDownloadURL();
      return url;
    } catch (error) {
      print('Error getting image URL: $error');
      return ''; // Or return a default placeholder URL if desired
    }
  }
  late String _imageUrl;
  Future<void> _loadImageUrl(String userId) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('User');
      final userDocument = userCollection.doc(userId);
      final imgPath = await userDocument.get().then((snapshot) => snapshot.data()?['PathImage']);
      String url = await getImageUrl(imgPath);
      setState(() {
        _imageUrl = url;
      });
    } catch (error) {
      print("Error: $error");
    }
  }
  @override
  void initState() {
    super.initState();
    _loadImageUrl(widget.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      //color: Colors.yellow,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: CachedNetworkImage(
            imageUrl: _imageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )

      ),



      //inserer la photode profil hna ki tjibha m bdd

    );
  }

}
class Details extends StatefulWidget {
  final String nomprestation;
  final String adresse;
  final String datedebut;
  final String heuredebut;
  const Details({super.key, required this.nomprestation, required this.adresse, required this.datedebut, required this.heuredebut});
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 240,
        height: 95,
        //color: Colors.red,
        child: Column(
            children:
            [
              NomPrestation(nomprestation: widget.nomprestation,),
              Lieu(adresse: widget.adresse,),
              Date(datedebut: widget.datedebut,),
              Heure(heuredebut: widget.heuredebut,),
            ]

        )


    );

  }

}
class NomPrestation extends StatelessWidget {
  final String nomprestation;
  const NomPrestation({
    super.key,
    required this.nomprestation
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 30,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            child: Image.asset(
              'assets/cle.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width: 10),
          Text(
            nomprestation,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}
class Lieu extends StatelessWidget {
  final String adresse;
  const Lieu({super.key, required this.adresse});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 20,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(

              'assets/lieu.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width: 7),
          Text(
            adresse,
            style: GoogleFonts.poppins(
              color: Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}

class Date extends StatelessWidget {
  final String datedebut;
  const Date({super.key, required this.datedebut});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 20,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 7),
          Container(
            height: 13,
            width: 13,
            child: Image.asset(

              'assets/date.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width: 7),
          Text(
            datedebut,
            style: GoogleFonts.poppins(
              color: Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}

class Heure extends StatelessWidget {
  final String heuredebut;
  const Heure({super.key, required this.heuredebut});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 20,
      color: Colors.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 7),
          Container(
            height: 17,
            width: 17,
            child: Image.asset(

              'assets/heure.png',
              // Assurez-vous de fournir le chemin correct vers votre image
            ),
          ),
          SizedBox(width: 7),
          Text(
            heuredebut,
            style: GoogleFonts.poppins(
              color: Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),


      // Ajoutez plus de widgets Text ici pour les éléments supplémentaires


    );
  }
}


class detailsbottom extends StatelessWidget {
  const detailsbottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 325,
        height: 35,
        //color: Colors.black,
        child:const Row(
          children: [
            envoyerilya(),
            buttonaccruf(),//hado bouton accepter refuser
          ],
        )
    );
  }

}


class envoyerilya extends StatelessWidget {
  const envoyerilya({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 35,
      //color: Colors.yellow,
      child: Align(
        alignment: const Alignment(0.0, 0.5), // Centrage par rapport à Y

        child: Text(
          'Envoyé il y a 5 min',
          style: GoogleFonts.poppins(
            color: Color(0xFF3E69FE),
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),


    );
  }

}
class buttonaccruf extends StatelessWidget {
  const buttonaccruf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 30,
        //color: Colors.black,
        child:Row(
          children: [
            SizedBox(width: 18,),
            buttonaccepter(),
            SizedBox(width: 2,),
            buttonrefuser(),
          ],
        )
    );
  }

}


class buttonaccepter extends StatefulWidget {
  const buttonaccepter({super.key});

  @override
  buttonaccepterState createState() => buttonaccepterState();
}

class buttonaccepterState extends State<buttonaccepter> {
  Color _buttonColor = Color(0xFF49F77A);
  Color _textColor = Colors.black;

  void _changeColor() {
    setState(() {
      _buttonColor = Color(0xFFF6F6F6);
      _textColor = Color(0xFFC4C4C4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: _buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: _changeColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'accepter',
              style: GoogleFonts.poppins(
                color: _textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: ImageIcon(
                AssetImage('assets/done.png'),
                color: _textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class buttonrefuser extends StatefulWidget {
  const buttonrefuser({super.key});

  @override
  buttonrefuserState createState() => buttonrefuserState();
}

class buttonrefuserState extends State<buttonrefuser> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 30,
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed:() {

        },// hna lazm quand on annule la classe Box Demande troh completement

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'refuser',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Container(
              height: 14,
              width: 14,
              child: ImageIcon(
                AssetImage('assets/close.png'),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
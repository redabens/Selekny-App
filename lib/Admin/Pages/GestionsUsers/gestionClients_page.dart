import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Admin/Services/GestionsUsers/gestionUsers_service.dart';
import 'package:reda/Admin/components/GestionsUsers/gestionUsers_container.dart';
import 'gestionArtisans_page.dart';
import 'package:google_fonts/google_fonts.dart';

class GestionClientsPage extends StatefulWidget {
  const GestionClientsPage({
    super.key,
  });
  @override
  State<GestionClientsPage> createState() => _GestionClientsPageState();
}

class _GestionClientsPageState extends State<GestionClientsPage> {
 void _onItemTap(bool isEnCours) {
   setState(() {
     isEnCoursSelected = isEnCours;
   });
 }
  bool isEnCoursSelected = false;
 //pour la recherche de clients------------------------------
@override
  void initState(){
    super.initState();
    getClientStream();
    _searchController.addListener(_onSearchChanged);
}
 void _onSearchChanged(){
  print(_searchController.text);
 }
final TextEditingController _searchController = TextEditingController();
  List allResults = [];
  getClientStream() async{
    var data = await FirebaseFirestore.instance.collection('User').where('role', isEqualTo: "client").orderBy('name').get();

    setState(() {
      allResults = data.docs;
    });
  }
  //------------------------------------------------------
  final GestionUsersService _GestionUsersService = GestionUsersService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserPathImage(String userID) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userID).get();
    if (userDoc.exists) {
      String pathImage = userDoc['PathImage'];
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      final url = await reference.getDownloadURL();
      return url;
    } else {
      return  '';
    }
  }
  Future<String> getUserName(String userID) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userID).get();
    if (userDoc.exists) {
      String userName = userDoc['name'];
      return userName;
    } else {
      return 'default_name';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // espace fo9 titre de la page
          const SizedBox(height: 20.0),
          AppBar(
            elevation: 0.0, // Remove default shadow
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(
              'Gestion des utilisateurs',
              style:GoogleFonts.poppins (
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            centerTitle: true,
          ),
          const SizedBox(height: 18),
          _buildSelectionRow(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 26, right: 26),
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey[300] ?? Colors.grey,
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Recherche des utilisateurs...',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600, // Semi-bold
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: _buildGestionUsersList(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }



  Widget _buildGestionUsersList() {
    return StreamBuilder(
      stream: _GestionUsersService.getAllClients(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        final documents = snapshot.data!.docs;
        for (var doc in documents) {
          print("====> Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(documents.map((document) => _buildGestionUsersItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error loading users: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return ListView(children: snapshot.data!);
            }
        );
      },
    );
  }

  Future<Widget> _buildGestionUsersItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String userID = document.id;
    String profileImage = "assets/anonyme.png"; // Default image
    String userName = "??????";
    String job = "?????";
    try {
      userName = await getUserName(userID);
      print("nooooooooooooooooooom:$userName");
      job = 'Client';
      profileImage = await getUserPathImage(userID);
      print("l'url :$profileImage");
    } catch (error) {

      print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
      print("Error fetching user image: $error");
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DetGestionUsers(userName: userName, job: job,profileImage: profileImage),

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
    onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => GestionArtisansPage())),
    child: Column( // Utiliser une colonne pour séparer le texte de la ligne
    children: [
    Text(
    'Mes Artisans',
    textAlign: TextAlign.center,
    style: TextStyle(
    color: isEnCoursSelected ? Color(0xFFF5A529) : Colors.grey,
    fontSize: 18,
    fontWeight: FontWeight.w800,
    ),
    ),
    SizedBox(height: 12), // Espace entre le texte et la ligne
    Container(
    height: isEnCoursSelected ? 4 : 1, // Épaisseur de la ligne
    color: isEnCoursSelected ? Color(0xFFF5A529) : Colors.grey,
    ),
    ],
    ),
    ),
    ),
    Expanded(
    child: GestureDetector(
    onTap: () => _onItemTap(false),
    child: Column( // Utiliser une colonne pour séparer le texte de la ligne
    children: [
    Text(
    'Mes Clients',
    textAlign: TextAlign.center,
    style: TextStyle(
    color: !isEnCoursSelected ? Color(0xFFF5A529) : Colors.grey,
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


}
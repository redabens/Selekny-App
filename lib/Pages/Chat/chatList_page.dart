import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Avenir.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Client/Pages/Demandes/demandeEncours_page.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/components/chatList_container.dart';
import 'package:reda/Client/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reda/Services/chat/chatList_service.dart';
import 'package:intl/intl.dart';
import 'package:reda/Pages/Chat/chat_page.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myBlueColor = Color(0xFF3E69FE);

class ChatListPage extends StatefulWidget{
  final int type;
  const ChatListPage({
    super.key, required this.type,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int _currentIndex = 2;
  final ChatListService _ChatListService = ChatListService();

  //functions-----------------------------------------------------
  Future<String> getUserImgPathById(String userId) async {

    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDocument = userCollection.doc(userId);
    final imgPath = await userDocument.get().then((snapshot) => snapshot.data()?['pathImage']);
    print(imgPath);
    return imgPath;
  }

  String getFormattedTime(Timestamp timestamp) {
    // Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  String getFormattedDate(Timestamp timestamp) {
    // Convertir le Timestamp en DateTime
    DateTime dateTime = timestamp.toDate();

    // Formater la date
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  String getFormattedDateTime(Timestamp timestamp) {
    // Convert the timestamp to a DateTime object
    DateTime dateTime = timestamp.toDate();

    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inHours < 24) {
      return getFormattedTime(timestamp); // Returns formatted time (e.g., "15:30")
    } else {
      return getFormattedDate(timestamp); // Returns formatted date (e.g., "24/05/2024")
    }
  }

  Future<String> getUserName(String userId) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDocument = userCollection.doc(userId);
    final name = await userDocument.get().then((snapshot) =>
    snapshot.data()?['nom']);
    return name;
  }

  // get rating artisan
  Future<double> getRatingUser(String userID) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    if (!userDoc.exists) {
      print ('Utilisateur introuvable');
      return 0;
    }
    final double rating = userDoc.data()!['rating'] as double;
    return rating;
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
  //get role de l'artisan
  Future<String> getRoleUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String role = userDoc.data()!['role'] as String;
    return role;
  }
  //get domaine de l'artisan
  Future<String> getDomaineUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String role = userDoc.data()!['domaine'] as String;
    return role;
  }
  // get adrrese user
  Future<String> getAdresseUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      return 'Utilisateur introuvable';
    }
    final String adresse = userDoc.data()!['adresse'] as String;
    return adresse;
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
  // get Vehicule user
  Future<int> getWorkCountUser(String userId) async {
    final firestore = FirebaseFirestore.instance;
    final userDoc = await firestore.collection('users').doc(userId).get();
    if (!userDoc.exists) {
      print('introuvable');
      return 0;
    }
    final int workcount = userDoc.data()!['workcount'] as int;
    return workcount;
  }
  //get image user
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title:  Text(
            'Messagerie',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight:  FontWeight.w800,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(9.0),
            child: Divider(
              color: Colors.white,
              height: 1, // epaisseur du trait
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column( // Use Column to stack elements vertically
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 16.0,
                    left: 26,
                    right: 26),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0), // Set border radius
                    border: Border.all(
                      color: Colors.grey[300] ?? Colors.grey, // Set border color
                      width: 3.0, // Set border widthS
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.search,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Recherche',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500, // Semi-bold
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              // Rest of the body content (chat list, etc.)
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildChatList(),
            ),
            const SizedBox(height: 10), // espace between les chat box
          ],
        ),
        bottomNavigationBar: widget.type == 1 ? BottomNavigationBar(

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
                    MaterialPageRoute(builder: (context) => const ChatListPage( type: 1,),),
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
        ) : BottomNavigationBar(

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
                    MaterialPageRoute(builder: (context) => const ActiviteAvenir(),),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const NotifUrgente(),),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatListPage(type: 2,),),
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
        )

    );

  }
  Widget _buildChatList() {
    return StreamBuilder<List<QueryDocumentSnapshot>>(
      stream: _ChatListService.getConversations(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final documents = snapshot.data!;
        if (documents.isEmpty) {
          return Center(
              child: Text(
                  'Vous n''avez aucune Conversation.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  )
              )
          );
        }
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            return FutureBuilder<Widget>(
              future: _buildChatListItem(document),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error loading chat: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return  Center(child: CircularProgressIndicator(color: Colors.grey[350],// Replace with your desired color
                  ));
                }
                return snapshot.data!;
              },
            );
          },
        );
      },
    );
  }
  Future<Widget> _buildChatListItem(DocumentSnapshot doc) async {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String profileImage = ""; // Default image
    String userName = "";
    String otherUserId = '';
    String phone = "";
    String adresse = "";
    String role = "";
    double rating = 4;
    String domaine = "";
    bool vehicule = false;
    int workcount = 0;
    //Teest to get the other user in the coversation
    try {
      if (data['user1'] == FirebaseAuth.instance.currentUser!.uid) {
        otherUserId = data['user2'];
        profileImage = await getUserPathImage(data['user2']); // get user2 si currentuser est user1
        userName = await getUserName(data['user2']);
        phone = await getPhoneUser(otherUserId);
        adresse = await getAdresseUser(otherUserId);
        role = await getRoleUser(otherUserId);
        vehicule = await getVehiculeUser(otherUserId);
        if (role == 'artisan'){
          rating = await getRatingUser(otherUserId);
          domaine = await getDomaineUser(otherUserId);
          workcount = await getWorkCountUser(otherUserId);
        }
      } else {
        otherUserId = data['user1'];
        profileImage = await getUserPathImage(data['user1']);
        userName = await getUserName(data['user1']);
        phone = await getPhoneUser(otherUserId);
        adresse = await getAdresseUser(otherUserId);
        role = await getRoleUser(otherUserId);
        vehicule = await getVehiculeUser(otherUserId);
        if (role == 'artisan'){
          rating = await getRatingUser(otherUserId);
          domaine = await getDomaineUser(otherUserId);
          workcount = await getWorkCountUser(otherUserId);
        }
      }
    }catch (error) {
      print("Error fetching user image: $error");
    }
    print("l'url:$profileImage");

    //tirer le dernier message
    final messageRef = doc.reference.collection('messages');
    final latestMessageSnapshot = await messageRef.orderBy('timestamp', descending: true).limit(1).get();
    String lastMsg = '';
    String lastMsgTime = 'DD:DD';
    Timestamp lastMessageTimestamp;
    if (latestMessageSnapshot.docs.isNotEmpty) {
      final messageData = latestMessageSnapshot.docs.first.data() as Map<String, dynamic>;
      lastMessageTimestamp = messageData['timestamp'] ;
      lastMsg = messageData['message'] ;
      lastMsgTime = getFormattedDateTime( lastMessageTimestamp);
      print('Hada last msg time $lastMsgTime');
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Navigate to ChatPage with receiver's user ID
              Navigator.push(
                context,
                MaterialPageRoute(    //otherUserId
                  builder: (context) => ChatPage(receiverUserID: otherUserId , currentUserId: FirebaseAuth.instance.currentUser!.uid,
                    type: widget.type, userName: userName,
                    profileImage: profileImage,otheruserId: otherUserId,
                    phone: phone, adresse: adresse,
                    domaine: domaine, rating: rating, workcount: workcount, vehicule: vehicule,
                  ),
                ),
              );
            },
            child: DetChatList(
              userName: userName,
              lastMsg: lastMsg,
              profileImage: profileImage,
              timestamp: lastMsgTime,
              type: widget.type,
              otheruserId: otherUserId,
              phone: phone, adresse: adresse,
              domaine: domaine, rating: rating,
              workcount: workcount, vehicule: vehicule,
            ),
          ),
        ],
      ),
    );
  }
}
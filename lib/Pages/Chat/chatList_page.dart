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

    // Calculate the difference between the timestamp and now
    Duration difference = DateTime.now().difference(dateTime);

    // If less than 24 hours, display time
    if (difference.inHours < 24) {
      return getFormattedTime(timestamp); // Returns formatted time (e.g., "15:30")
    } else {
      return getFormattedDate(timestamp); // Returns formatted date (e.g., "24/05/2024")
    }
  }

  Future<String> getUserPathImage(String userID) async {
    String pathImage = await getUserImgPathById(userID);
    // Retourner le PathImage
    final reference = FirebaseStorage.instance.ref().child(pathImage);
    final url = await reference.getDownloadURL();
    return url;

  }

  Future<String> getUserName(String userId) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDocument = userCollection.doc(userId);
    final name = await userDocument.get().then((snapshot) =>
    snapshot.data()?['nom']);
    return name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Messagerie',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
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
                          hintStyle: TextStyle(
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
                Navigator.push(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DemandeEncoursPage(),),
                );


              },
              child: SizedBox(
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
                  MaterialPageRoute(builder: (context) => const ChatListPage( type: 1,),),
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
                  MaterialPageRoute(builder: (context) => const ProfilePage(),),
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
                Navigator.push(
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
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 2,),),
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
                  MaterialPageRoute(builder: (context) => const ProfilePage(),),
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
          return const Center(child: Text('No conversations found'));
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
    String profileImage = "assets/images/placeholder.png"; // Default image
    String userName = "";
    String otherUserId = '';

    //Teest to get the other user in the coversation
    try {
      if (data['user1'] == FirebaseAuth.instance.currentUser!.uid) {
        otherUserId = data['user2'];
        profileImage = await getUserPathImage(data['user2']); // get user2 si currentuser est user1
        userName = await getUserName(data['user2']);
      } else {
        otherUserId = data['user1'];
        profileImage = await getUserPathImage(data['user1']);
        userName = await getUserName(data['user1']);
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
      final messageData = latestMessageSnapshot.docs.first.data();
      lastMessageTimestamp = messageData['timestamp'] ;
      lastMsg = messageData['message'] ;
      lastMsgTime = getFormattedDateTime( lastMessageTimestamp);
      print('HADAAAAAA last msg time $lastMsgTime');
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // Navigate to ChatPage with receiver's user ID
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(    //otherUserId
                  builder: (context) => ChatPage(receiverUserID: otherUserId , currentUserId: FirebaseAuth.instance.currentUser!.uid, type: widget.type,
                  ),
                ),
              );
            },
            child: DetChatList(
              userName: userName,
              lastMsg: lastMsg,
              profileImage: profileImage,
              timestamp: lastMsgTime,
            ),
          ),
        ],
      ),
    );
  }
}
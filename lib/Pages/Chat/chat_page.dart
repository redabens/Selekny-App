import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Artisan/Pages/ProfilClient/profilclient.dart';
import 'package:reda/Client/ProfilArtisan/profil.dart';
import 'package:reda/Client/components/chat_bubble.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
import 'package:reda/Services/Chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myBlueColor = Color(0xFF3E69FE);

class ChatPage extends StatefulWidget{
  final String userName;
  final String profileImage;
  final String otheruserId;
  final String phone;
  final String adresse;
  final String domaine;
  final int rating;
  final String receiverUserID;
  final String currentUserId;
  final int type;
  const ChatPage({
    super.key,
    required this.receiverUserID,
    required this.currentUserId,
    required this.type, required this.userName,
    required this.profileImage, required this.otheruserId,
    required this.phone, required this.adresse,
    required this.domaine, required this.rating,
  });
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //final String imageUrl = await getImageUrl('Prestations/1vyrPcSqF0LTRZpaYUVy.png');
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage((widget.receiverUserID), _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

<<<<<<< HEAD
  Future<String> getUserNameById(String userId) async {

    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDocument = userCollection.doc(userId);
    final name = await userDocument.get().then((snapshot) => snapshot.data()?['nom']);
    print(name);
    return name;
  }

  Future<String> getUserImagePath(String userId) async {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final userDocument = userCollection.doc(userId);
      final imgPath = await userDocument.get().then((snapshot) => snapshot.data()?['pathImage']);
      String url = await getImageUrl(imgPath);
      return url;
  }

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

=======
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
  @override
  void initState() {
    super.initState();
  }
  Future<Widget> _buildAppBar(String otherUserId) async {
<<<<<<< HEAD

    String otherUserName = '';
    try {
      final imagePath = await  getUserImagePath(otherUserId) ;
      final url = await getImageUrl(imagePath);
      otherUserName = await getUserNameById(otherUserId);
    }catch (error) {
      print("Error fetching other user name: $error");
    }

=======
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
    return AppBar(
      title: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
<<<<<<< HEAD
      children:
          [
      Container( // Enveloppez l'icône dans un Container pour créer un bouton carré
      height: 40, // Définissez la hauteur et la largeur pour obtenir un bouton carré
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Color(0xFF33363F),
            size: 22,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatListPage(type: 1)),
            );

          },
        ),
      ),
          SizedBox(width:5),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Container(
              width: 40, // Taille container de l'image
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // container mdaweer
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 2.0, // Épaisseur de la bordure
=======
            children:
            [
              Container( // Enveloppez l'icône dans un Container pour créer un bouton carré
                height: 40, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                  },
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                ),
              ),
              const SizedBox(width:5),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle photo tap here (e.g., navigate to a new screen, show a dialog)
                    if(widget.type == 1){
                      Navigator.push(
                        context,
                        MaterialPageRoute(    //otherUserId
                          builder: (context) => ProfilePage2(idartisan: widget.otheruserId, imageurl: widget.profileImage,
                              nomartisan: widget.userName, phone: widget.phone,
                              domaine: widget.domaine, rating: widget.rating),
                        ),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(    //otherUserId
                          builder: (context) => ProfilePage1(image: widget.profileImage, nomClient: widget.userName,
                            phone: widget.phone, adress: widget.adresse, idclient: widget.otheruserId,),
                        ),
                      );
                    } // Example action (replace with your desired functionality)
                  },
                  child: Container(
                    width: 45, // Adjust as needed
                    height: 45, // Adjust as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: myBlueColor,
                        width: 1.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: widget.profileImage != ''
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            50), // Ajout du BorderRadius
                        child: Image.network(
                          widget.profileImage,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.account_circle,
                        size: 45,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),

              ),
<<<<<<< HEAD
            ),

            ),
  ],),
=======
            ],),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b

          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
<<<<<<< HEAD
                    text: otherUserName,
                    style: GoogleFonts.poppins(
                      color: Color(0xFF333333),
=======
                    text: widget.userName,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF333333),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
<<<<<<< HEAD
          SizedBox(width: 8),
=======
          const SizedBox(width: 8),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
        ],
      ),
      backgroundColor: Colors.white,
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(9.0),
        child: Divider(
          color: Colors.black26,
          height: 1, // epaisseur du trait
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Adjust height if needed
        child: FutureBuilder<Widget>(
          future: _buildAppBar(widget.receiverUserID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!; // Use the built AppBar widget
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return AppBar(title: const Text('Error Loading AppBar')); // Handle errors
            }
            return const LinearProgressIndicator(); // Show loading indicator
          },
        ),
      ),
      body: Column(
        children:[
          // messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID, widget.currentUserId),
      builder: (context, snapshot){
        if (snapshot.hasError){
          print('(snapshot.hasError)');
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        return ListView(
          reverse: false,
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // align the messages to the right sender is the current user , otherwise the left
    var alignment = (data['senderId'] == widget.currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    var bubbleColor = (data['senderId'] == widget.currentUserId)
        ? const Color(0xFF3E69FE)
        : const Color(0xFFE6E6E6);

    var textColor = (data['senderId'] == widget.currentUserId)
        ? Colors.white
        : Colors.black;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == widget.currentUserId)
              ?CrossAxisAlignment.end
              :CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == widget.currentUserId)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            //Text(data['senderEmail']),
            ChatBubble(
              message: data['message'],
              backgroundColor: bubbleColor,
              textColor: textColor,
            ),

          ],
        ),
      ),
    );
    return Text(data["message"]);
  }



  // build message input
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
          children: [
            Expanded(
                child: TextFormField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Ecrire un message...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16,fontFamily: 'poppins' ),
                      border: InputBorder.none,
                    )

                )),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () {
                sendMessage();
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: myBlueColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )
                ),
              ),
            ),
          ] //expanded
      ),
    );
  }
}
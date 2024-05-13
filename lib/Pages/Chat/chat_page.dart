
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
import 'package:reda/Services/notifications.dart';

const Color myBlueColor = Color(0xFF3E69FE);

class ChatPage extends StatefulWidget{
  final String nomArtisan;
  final String nomClient;
  final String tokenArtisan;
  final String tokenClient;
  final String userName;
  final String profileImage;
  final String otheruserId;
  final String phone;
  final String adresse;
  final String domaine;
  final double rating;
  final int workcount;
  final bool vehicule;
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
    required this.domaine, required this.rating, required this.workcount,
    required this.vehicule, required this.nomArtisan,
    required this.nomClient, required this.tokenArtisan, required this.tokenClient,
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

  @override
  void initState() {
    super.initState();
  }
  Future<Widget> _buildAppBar(String otherUserId) async {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      title: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
            [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width:2),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () {
                    // Handle photo tap here (e.g., navigate to a new screen, show a dialog)
                    if(widget.type == 1){
                      Navigator.push(
                        context,
                        MaterialPageRoute(    //otherUserId
                          builder: (context) => ProfilePage2(idartisan: widget.otheruserId, imageurl: widget.profileImage, phone: widget.phone,
                              domaine: widget.domaine, rating: widget.rating, adresse: widget.adresse, workcount: widget.workcount,
                            vehicule: widget.vehicule,nomArtisan: widget.nomArtisan,nomClient: widget.nomClient,
                            tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,),
                        ),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(    //otherUserId
                          builder: (context) => ProfilePage1(image: widget.profileImage, nomClient: widget.userName,
                            phone: widget.phone, adress: widget.adresse, idclient: widget.otheruserId, isVehicled: widget.vehicule,
                            nomArtisan: widget.nomArtisan, tokenArtisan: widget.tokenArtisan,tokenClient: widget.tokenClient,),
                        ),
                      );
                    } // Example action (replace with your desired functionality)
                  },
                  child: Container(
                    width:screenWidth*0.105,
                    height: screenWidth*0.105,
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
                          width: screenWidth*0.09,
                          height: screenWidth*0.09,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Icon(
                        Icons.account_circle,
                        size: 34,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),

              ),
            ],),

          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.userName,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      backgroundColor: Colors.white,

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
              return AppBar(title: const Text('Loading the user ...',
              )); // style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
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

    var isCurrentUser = data['senderId'] == widget.currentUserId;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var bubbleColor = isCurrentUser ? myBlueColor : myGrayColor;
    var textColor = isCurrentUser ? Colors.white : Colors.black;
    var otherUserImage = isCurrentUser ? null : widget.profileImage;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ChatBubble(
          message: data['message'],
          backgroundColor: bubbleColor,
          textColor: textColor,
          otherUserImage: otherUserImage,
        ),
      ),
    );
  }




  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: myGrayColor,
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
              ),
              child: TextFormField(
                controller: _messageController,
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "  Écrire un message ...",
                  hintStyle: GoogleFonts.poppins(color: Colors.black.withOpacity(0.5), fontSize: 14,fontWeight: FontWeight.w500),
                  border: InputBorder.none, // No border
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              sendMessage();
              if(widget.type == 1){
               NotificationServices.sendPushNotification(widget.tokenArtisan,widget.nomClient ,_messageController.value.text,"Message");
              }
              else{
                NotificationServices.sendPushNotification(widget.tokenClient,widget.nomArtisan ,_messageController.value.text,"Message");
              }
            },
            child: Container(
              height: 44, // Increased size for better touch area
              width: 44,
              decoration: BoxDecoration(
                color: myBlueColor.withOpacity(0.7), // Solid blue color for the send button
                borderRadius: BorderRadius.circular(24), // Circle shape
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

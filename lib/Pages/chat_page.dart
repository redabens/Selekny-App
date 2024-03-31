import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Services/Chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/components/chat_bubble.dart';
import 'package:reda/components/my_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reda/Services/image_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

const Color myBlueColor = Color(0xFF3E69FE);

class ChatPage extends StatefulWidget{
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });
  final  receiverUserEmail;
  final String receiverUserID;
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

  final currentUserId ='hskvyxfATXnpgG8vsZlc';
  final String currentUserEmail = 'mm_bensemane@esi.dz';
//'https://firebasestorage.googleapis.com/v0/b/selekny-app.appspot.com/o/Prestations%2F1vyrPcSqF0LTRZpaYUVy.png?alt=media&token=078326f3-518a-44a8-9609-9d538343b362';
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

  @override
  void initState() {
    super.initState();
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    try {
      String url = await getImageUrl('Prestations/1vyrPcSqF0LTRZpaYUVy.png');
      setState(() {
        _imageUrl = url;
      });
    } catch (error) {
      print("Error: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
    //String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/selekny-app.appspot.com/o/Prestations%2F1vyrPcSqF0LTRZpaYUVy.png?alt=media&token=078326f3-518a-44a8-9609-9d538343b362';
    //geturl();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Container(
                  width: 40, // Taille container de l'image
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,// container mdaweer
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 2.0, // Épaisseur de la bordure
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: CachedNetworkImage(

                      imageUrl: _imageUrl,

                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.receiverUserEmail,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(9.0),
          child: Divider(
            color: Colors.black26,
            height: 1, // epaisseur du trait
          ),
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
      stream: _chatService.getMessages(widget.receiverUserID, currentUserId),
      builder: (context, snapshot){
        if (snapshot.hasError){
          print('(snapshot.hasError)');
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // align the messages to the right sender is the current user , otherwise the left
    var alignment = (data['senderId'] == currentUserId)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: (data['senderId'] == currentUserId)
              ?CrossAxisAlignment.end
              :CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == currentUserId)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            //Text(data['senderEmail']),
            ChatBubble(message: data['message']),

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
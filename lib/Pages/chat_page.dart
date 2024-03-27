import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Services/Chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/components/chat_bubble.dart';
import 'package:reda/components/my_text_filed.dart';

class ChatPage extends StatefulWidget{
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });
  final String receiverUserEmail;
  final String receiverUserID;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage((widget.receiverUserID), _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail),),
      body: Column(
        children:[
          // messages
          Expanded(
            child: _buildMessageList(),
          ),
          // user input
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList(){
  return StreamBuilder(
    stream: _chatService.getMessages(widget.receiverUserID, "eOILQzRtIQlxwCGKhFMy"), //_firebaseAuth.currentUser!.uid
    builder: (context, snapshot){
      print("Stream Data: ${snapshot.data}"); // Add this line for debugging
      if (snapshot.hasError){
        return Text('Error${snapshot.error}');
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text('Loading..');
      }
      final documents = snapshot.data!.docs;

      // Print details of each document
      for (var doc in documents) {
        print("Document Data: ${doc.data()}");
      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
      );
    },
  );
  }
  // build message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print("Message Data: $data"); // Add this line for debugging
    // align the messages to the right sender is the current user , otherwise the left
    var alignment = (data['senderId'] == "eOILQzRtIQlxwCGKhFMy") //_firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == "eOILQzRtIQlxwCGKhFMy")
                ?CrossAxisAlignment.end
                :CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == "eOILQzRtIQlxwCGKhFMy")
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          ChatBubble(message: data['message']),

        ],
      ),
    );
  }
  // build message input
  Widget _buildMessageInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          // textfield
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hinText: 'Ecrire un message...',
              obscureText: false,
            ), // MyTextField
          ),
        IconButton(onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ),
        )
        ],
      )
    );
  }
}
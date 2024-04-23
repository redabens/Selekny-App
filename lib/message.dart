import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    // for background and terminated state
    if (data is RemoteMessage) {
      payload = data.data;
    }

    // for foreground state
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Message"),
      ),
      body: Center(
        child: Text(payload.toString()),
      ),
    );
  }
}

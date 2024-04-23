import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Front/WelcomeScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reda/Back/services/notifications.dart';
import 'package:reda/message.dart';
import 'package:reda/Front/profile/profile_menu.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'package:reda/Front/profile/update_profile_screen.dart';
// function to listen to background changes

final navigatorkey = GlobalKey<NavigatorState>();
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received in background");
  }
}

NotificationServices notificationServices = NotificationServices();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  notificationServices.requestNotificationPermission();
  //notificationServices.isTokenRefresh();
  notificationServices.getDeviceToken().then((value) {
    print("device token : ${value}");
  });
  // init firebase messaging
  await NotificationServices.initLocalNotifications();

  // listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      navigatorkey.currentState!
          .push(MaterialPageRoute(builder: (context) => const MessagePage()));
    }
  });

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      NotificationServices.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // to handle in terminated state

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      // delay time for app initialization
      navigatorkey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkIfLogin(); // Appel de la méthode pour vérifier l'état de connexion
  }

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

// si user est deja connecte on le redirige directement vers la page d acceuil

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      theme: ThemeData(
        // Define your light theme here
        brightness: Brightness.light,
        // Add other light theme configurations
      ),
      darkTheme: ThemeData(
        // Define your dark theme here
        brightness: Brightness.dark,
        // Add other dark theme configurations
      ),
      home: isLogin ? ProfilePage() : WelcomePage(),
      //home: ProfilePage(),
      routes: {"/message": (context) => MessagePage()},
    );
  }
}

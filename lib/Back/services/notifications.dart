import "package:firebase_messaging/firebase_messaging.dart";
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'package:reda/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Back/services/auth.dart';

class NotificationServices {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('user denied permission');
    }
  }

  static Future initLocalNotifications() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosInitializationSettings = const DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // request notif permission for android 13 or above

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    navigatorkey.currentState!
        .pushNamed("/message", arguments: notificationResponse);
  }

  /*void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);
        print(message.data['type']);
        print(message.data['id']);
      }
      initLocalNotifications(context, message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }
*/
  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    FirebaseAuthService auth = FirebaseAuthService();
    print("Device Token: $token");

    /* if (FirebaseAuth.instance.currentUser?.email != null) {
      await FirebaseAuthService.saveUserToken(token!);
      print("save in firestore");
    }
    // if token refreshed
    messaging.onTokenRefresh.listen((event) async {
      if (FirebaseAuth.instance.currentUser?.email != null) {
        await FirebaseAuthService.saveUserToken(token!);
        print("save in firestore");
      }
    });*/

    return token;
  }

  void isTokenRefresh() async {
    await messaging.onTokenRefresh.listen((event) {
      print("Token Refreshed: $event");
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'msg') {
      // Redirigez vers la page du chat
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}

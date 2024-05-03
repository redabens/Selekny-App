import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reda/Pages/auth.dart';
import 'package:reda/main.dart';
import 'package:http/http.dart';

final navigatorkey = GlobalKey<NavigatorState>();

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
    const iosInitializationSettings = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
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
    final notificationType = notificationResponse.notificationResponseType;

    // Exemple de logique de redirection en fonction du type de notification

    switch (notificationType) {
      case 'PublieDemande':
        navigatorkey.currentState!
            .pushNamed("/PublierDemandePage", arguments: notificationResponse);
        break;
      case 'AccepteParArtisan':
        navigatorkey.currentState!
            .pushNamed("/AccepteParArtisan", arguments: notificationResponse);
        break;
      // Ajoutez d'autres cas pour d'autres types de notifications si nécessaire
      case 'ConfirmeParClient':
        // Par défaut, redirigez l'utilisateur vers une page générique
        navigatorkey.currentState!
            .pushNamed("/ConfirmeParClient", arguments: notificationResponse);
        break;
      default:
        break;
    }
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
    print("Device Token: $token");

    /* if (FirebaseAuth.instance.currentUser?.email != null) {
      await FirebaseAuthService.saveUserToken(token!);
      print("save in firestore");
    }*/
    // if token refreshed
    messaging.onTokenRefresh.listen((event) async {
      if (FirebaseAuth.instance.currentUser?.email != null) {
        await FirebaseAuthService.saveUserToken(token!);
        print("save in firestore");
      }
    });

    return token;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print("Token Refreshed: $event");
    });
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'Selekny',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future<void> sendPushNotification(String token, String title,
      String content, String notificationType) async {
    try {
      final body = {
        "to": token,
        "notification": {
          "title": title,
          "body": content,
          "type": notificationType
        }
      };

      var response =
          await post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    'key=AAAA0S8eygg:APA91bFuZSbeV48FXJ7V0PWAc4Sl61-rlgzLvtdFzl7vZxL77eTwN1--iG5OLFB4Ppsm9OoFrZFV97mB-k_y3Er1OpZHQlsi5VzHqP6fM9xXf7rgJCvbLbUgsCvmRrgEcSeoLC5a3DYt'
              },
              body: jsonEncode(body));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print("\nErreur dans l'envoi de la notification : ${e.toString()}");
    }
  }
}

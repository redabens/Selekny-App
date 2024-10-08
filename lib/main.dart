
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/activiteaujour.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifDemande.dart';
import 'package:reda/Client/Pages/Demandes/demandeAcceptee_page.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/Pages/Home/search.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
import 'package:reda/Pages/VousEtesBanni.dart';
import 'package:reda/Pages/WelcomeScreen.dart';
import 'package:reda/Pages/authentification/connexion2.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Services/notifications.dart';
import 'firebase_options.dart';
import 'dart:convert';
User? currentUser = FirebaseAuth.instance.currentUser;
final navigatorkey = GlobalKey<NavigatorState>();
NotificationServices notificationServices = NotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Future firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notification received in background");
    }
  }

  notificationServices.requestNotificationPermission();
  //notificationServices.isTokenRefresh();
  notificationServices.getDeviceToken().then((value) {
    print("device token : $value");
  });
  // init firebase messaging
  await NotificationServices.initLocalNotifications();

  // listen to background notifications
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      /* navigatorkey.currentState!.push(MaterialPageRoute(
          builder: (context) =>
              ChatListPage(currentUserID: currentUser?.uid ?? "")));*/
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
    Future.delayed(const Duration(seconds: 1), () {
      // delay time for app initialization
      navigatorkey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  await fetchPrestations();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setupToken();
  }

  static Future<void> saveUserToken(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'token': token,
    });
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveUserToken(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveUserToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool isConnected = connectivity != ConnectivityResult.none;
          if (isConnected) {
            return const HomeScreen();
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Color(0xFF3E69FE),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Erreur de connexion",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Vérifiez votre connexion Internet .",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }
        },
        child: const HomeScreen(), // Ajoutez un widget enfant pour le OfflineBuilder
      ),
    );
  }
}

// si user est deja connecte on le redirige directement vers la page d acceuil
// This widget is the root of your application.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var admin = false;
  var isLogin=false;
  var isbloqued=false;
  var auth = FirebaseAuth.instance;
  late Future<String> roleFuture;
  late String role = '';
  late int type;
  Future<String> getUserRole(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();
        if(userData['role']== 'client'){
          type = 1;
        }
        else if(userData['role']== 'artisan')  {
          type = 2;
        }

        return userData['role'] ?? '';
      } else {
        print('No user found for email: $email');
        return ''; // Réinitialiser le rôle si aucun utilisateur n'est trouvé
      }
    } catch (e) {
      print('Error retrieving user role: $e');
      return ''; // Réinitialiser le rôle en cas d'erreur
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin();// Appel de la méthode pour vérifier l'état de connexion
    checkifadmin();
    checkifbloque();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Ajoute initialBinding ici pour initialiser le UserRepository
      initialBinding: BindingsBuilder(() {
        Get.put(UserRepository());
      }),

      home: Container(
        color: Colors.white, // Couleur de l'arrière-plan de la page
        child: Center(
          child: !isLogin
              ? const WelcomePage()
              : admin ?
          const AllSignalementsPage()
              : isbloqued ?
          const Banni()
              :(role == 'client')
              ?  const HomePage()
              : (role == 'artisan')
              ? const ActiviteaujourPage()
              : const LoginPage2(),
        ),
      ),

      //home: const CreationArtisanPage(),
      routes: {
        "/PublierDemandePage": (context) => const NotifDemande(),
        "/AccepteParArtisan": (context) => const DemandeAccepteePage(),
        "/ConfirmeParClient": (context) => const ActiviteaujourPage(),
        "/Message" : (context) => ChatListPage(type: type),
      },
    );
  }
  void checkifbloque() async{
    auth.authStateChanges().listen((User? user) async {
      try {
        final userdoc = await FirebaseFirestore.instance.collection('users')
            .doc(
            user!.uid)
            .get();
        Map<String, dynamic> data = userdoc.data() as Map<String, dynamic>;
        setState(() {
          isbloqued = data['bloque'];
        });
      }
      catch (e) {
        print("error : $e");
      }
    });
  }
  void checkIfLogin() async {
    auth.authStateChanges().listen((User? user) async {
      final useremail = auth.currentUser?.email;
      role = await getUserRole(useremail!);
      print(useremail);
      print(role);
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }
  void checkifadmin(){
    auth.authStateChanges().listen((User? user) async {
      if (user!.uid == 'jjjSB7ociHSHazUZ27iNYCiVCiD2') {
        setState(() {
          admin = true;
        });
      }
    });
  }
}

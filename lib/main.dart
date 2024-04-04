import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reda/Front/authentification/connexion.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: isLogin ? ProfilePage() : LoginPage(),
    );
  }
}

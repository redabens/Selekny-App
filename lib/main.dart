import 'package:flutter/material.dart';
import '../Front/WelcomeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: WelcomePage(),
    );
  }
}



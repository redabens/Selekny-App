import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:reda/Front/authentification/connexion.dart';
import 'package:reda/Front/authentification/forgotpassword.dart';
//import 'package:reda/Front/profile/profile.dart';
import '../Front/WelcomeScreen.dart';
import 'Front/profile.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the WidgetsBinding instance
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Delay the removal of the splash screen to ensure it's displayed for a certain duration
  Future.delayed(const Duration(seconds: 1), () {
    FlutterNativeSplash.remove();
  });
  runApp(WelcomePage());
}



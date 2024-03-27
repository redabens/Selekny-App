import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:untitled/Front/WelcomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the WidgetsBinding instance
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve the native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Delay the removal of the splash screen to ensure it's displayed for a certain duration
  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
  runApp(WelcomePage()); //welcome page screen
}



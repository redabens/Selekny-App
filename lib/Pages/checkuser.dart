import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  checkuser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // rediriger a la page d acceuil
    } else {
      // rediriger a la page d'inscription
    }
  }
}

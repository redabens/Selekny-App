import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final String title;

  const NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Bienvenue à $title'),
      ),
    );
  }
}
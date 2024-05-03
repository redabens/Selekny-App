import 'package:flutter/material.dart';
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aide'),
      ),
      body: const Center(

        child: Text('Contenu de la page détail'),
      ),
    );
  }
}
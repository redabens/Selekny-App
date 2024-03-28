import'package:flutter/material.dart';
import 'package:reda/Tile/Materiel_Tile.dart';

class PubDemandePage extends StatelessWidget {
  const PubDemandePage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Details de la Demande"),
          leading: IconButton( onPressed: (){},
          icon: Icon(Icons.arrow_back_ios_new),),
          ),
          body: ListView(
            children: const [
              MaterialTile(domaine: 'Nettoyage', prestation: 'Ponçage carrelage'),
            ],
          ),
        ),
    );
  }
}


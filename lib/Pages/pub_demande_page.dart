import 'package:flutter/material.dart';
import 'package:reda/Services/demande publication/getMateriel.dart';
import 'package:reda/Tile/Materiel_Tile.dart';

class PubDemandePage extends StatefulWidget {
  const PubDemandePage({super.key});

  @override
  State<PubDemandePage> createState() => _PubDemandePageState();
}

class _PubDemandePageState extends State<PubDemandePage> {
  String? materiel; // Declare materiel as nullable String
  String? prix;
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    _fetchMaterial('Nettoyage', 'Ponçage carrelage');
  }

  Future<void> _fetchMaterial(String domaine, String prestation) async {
    try {
      materiel = await getMateriel(domaine, prestation);
      prix = await getPrix(domaine, prestation);
      setState(() {}); // Update UI with fetched material
    } catch (e) {
      print("Erreur lors de la recherche de matériel : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details de la Demande"),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: ListView(
          children: [
            MaterialTile(domaine: 'Nettoyage', prestation: 'Ponçage carrelage', materiel: materiel),
          ],
        ),
      ),
    );
  }
}


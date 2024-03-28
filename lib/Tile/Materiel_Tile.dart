import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialTile extends StatefulWidget {
  const MaterialTile({
    super.key,
    required this.domaine,
    required this.prestation,
  });
  final String domaine;
  final String prestation;
  @override
  State<MaterialTile> createState() => _MaterialTileState();
}

class _MaterialTileState extends State<MaterialTile> {
  String? materiel =''; // Declare materiel as nullable String
  Future<void> getMateriel(String domaine, String prestation) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .where('Nom', isEqualTo: domaine)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String domaineId = querySnapshot.docs[0].id;
        final prestationsSnapshot = await FirebaseFirestore.instance
            .collection('Domaine')
            .doc(domaineId)
            .collection('Prestations')
            .where('nom_prestation', isEqualTo: prestation)
            .limit(1)
            .get();
        String prestationId = prestationsSnapshot.docs[0].id;
        if (prestationsSnapshot.docs.isNotEmpty) {
          materiel = prestationsSnapshot.docs[0].data()['materiel'] as String?;
          setState(() {}); // Update UI after fetching data
        }
      }
    } catch (e) {
      print("Error fetching data: $e"); // Handle potential errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.black54,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            child: const Row(
              children: [
                Icon(Icons.handyman_outlined),
                Text("Le matériel necéssaire:"),
              ],
              //titre
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text(
                    '. ${getMateriel(widget.domaine, widget.prestation)}', style: const TextStyle(color: Colors.grey,fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


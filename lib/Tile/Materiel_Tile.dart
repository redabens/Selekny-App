import 'package:flutter/material.dart';

class MaterialTile extends StatelessWidget {
  const MaterialTile({
    super.key,
    required this.domaine,
    required this.prestation,
    this.materiel, // Optional material string
  });
  final String domaine;
  final String prestation;
  final String? materiel; // Can be null

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
                Text("Le matériel nécessaire:"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  const Text(
                    '.',
                    style: TextStyle(color: Colors.grey, fontSize: 30),
                  ),
                  Text(
                    materiel != null ? ' $materiel' : '', // Display material only if available
                    style: const TextStyle(color: Colors.grey, fontSize: 25),
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



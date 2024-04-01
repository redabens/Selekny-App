import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reda/Pages/Home/home.dart';
import 'package:reda/Pages/voirtout_page.dart';
import 'package:reda/components/Prestation_container.dart';

class PrestationPage extends StatefulWidget {
  final int indexe;
  final String domaineID;
  const PrestationPage({
    super.key,
    required this.domaineID,
    required this.indexe,
  });

  @override
  State<PrestationPage> createState() => _PrestationPageState();
}

class _PrestationPageState extends State<PrestationPage> {
  List<Prestation> prestations = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getPrestations(); // Call the function to fetch prestations on initialization
  }

  Future<void> _getPrestations() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    try {
      // Récupérer les prestations de Firestore
      final prestationsSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .doc(widget.domaineID)
          .collection('Prestations')
          .get();

      // Mapper chaque document de prestation à un objet Prestation
      final futures = prestationsSnapshot.docs.map((doc) async {
        // Obtenir la référence de l'image dans Firebase Storage
        final reference = FirebaseStorage.instance.ref().child(doc.data()['image']);

        // Télécharger l'URL de l'image (handle potential errors)
        String? url;
        try {
          url = await reference.getDownloadURL();
          print(url);
        } catch (e) {
          print("Error downloading image URL: $e");
          // Handle the error here (e.g., display a placeholder image)
        }

        return Prestation(
          nomprestation: doc.data()['nom_prestation'],
          imageUrl: url ?? "placeholder_image.png", // Use downloaded URL or a placeholder
        );
      });

      // Attendre que toutes les images soient téléchargées
      final prestations = await Future.wait(futures);

      // Mettre à jour l'interface utilisateur après la récupération des données
      setState(() {
        this.prestations = prestations; // Update state with fetched data
        _isLoading = false; // Set loading state to false
      });
    } catch (e) {
      // Gérer les erreurs de manière appropriée
      print("Erreur lors de la récupération des prestations : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              if(widget.indexe == 1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VoirtoutPage()),
                );
              }
              else if(widget.indexe == 2){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );}
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Prestations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
            : Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: prestations.length,
                itemBuilder: (context, index) {
                  return Column( // Wrap in a Column for vertical spacing
                    children: [
                      Prestation(
                        nomprestation: prestations[index].nomprestation,
                        imageUrl: prestations[index].imageUrl,
                      ),
                      const SizedBox(height: 20), // Add spacing between containers
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




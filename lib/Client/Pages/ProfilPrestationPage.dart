import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Services/image_service.dart';
import '../components/ProfilPrestations_container.dart';

class ProfilPrestationPage extends StatefulWidget {
  final String idartisan;
  const ProfilPrestationPage({
    super.key,
    required this.idartisan,
  });

  @override
  State<ProfilPrestationPage> createState() => _ProfilPrestationPageState();
}

class _ProfilPrestationPageState extends State<ProfilPrestationPage> {
  List<ProfilPrestation> prestations = [];
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
      final querySnapshot1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.idartisan)
          .get();

      if (querySnapshot1.data()!.isNotEmpty) {
        Map<String, dynamic> data = querySnapshot1.data() as Map<String,
            dynamic>;
        final String domaine = data['domaine'];
        final List<dynamic> prestations = data['prestations'];
        List<ProfilPrestation> liste = [];
        for(int i =0; i<prestations.length; i++){
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
                .where('nom_prestation', isEqualTo: prestations[i])
                .limit(1)
                .get();
            Map<String,dynamic> data = prestationsSnapshot.docs.first.data() as Map<String,dynamic>;
            String imageUrl = await getImageUrl(data['image']);
            liste.add(ProfilPrestation(nomprestation: data['nom_prestation'], imageUrl: imageUrl));
          }
        }
          // Mettre à jour l'interface utilisateur après la récupération des données
          setState(() {
            this.prestations = liste; // Update state with fetched data
            _isLoading = false; // Set loading state to false
          });
      }
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
              Navigator.pop(context);
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
                      ProfilPrestation(
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
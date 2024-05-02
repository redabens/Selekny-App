import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/components/Domaine_container.dart';
import 'package:reda/Pages/homedefault.dart';

class VoirtoutPage extends StatefulWidget {
  final int type;
  const VoirtoutPage({
    super.key, required this.type,
  });

  @override
  State<VoirtoutPage> createState() => _VoirtoutPageState();
}

class _VoirtoutPageState extends State<VoirtoutPage> {
  List<Domaine> domaines = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getDomaines(); // Call the function to fetch prestations on initialization
  }

  Future<void> _getDomaines() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });
    try {
      // Récupérer les prestations de Firestore
      final domainesSnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .get();

      // Mapper chaque document de prestation à un objet Prestation
      final futures = domainesSnapshot.docs.map((doc) async {
        final String domaineID= doc.id;
        // Obtenir la référence de l'image dans Firebase Storage
        final reference = FirebaseStorage.instance.ref().child(doc.data()['Image']);

        // Télécharger l'URL de l'image (handle potential errors)
        String? url;
        try {
          url = await reference.getDownloadURL();
        } catch (e) {
          print("Error downloading image URL: $e");
          // Handle the error here (e.g., display a placeholder image)
        }

        return Domaine(
          domaineID: domaineID,
          nomdomaine: doc.data()['Nom'],
          imageUrl: url ?? "", type: 0, // Use downloaded URL or a placeholder
        );
      });

      // Attendre que toutes les images soient téléchargées
      final domaines = await Future.wait(futures);

      // Mettre à jour l'interface utilisateur après la récupération des données
      setState(() {
        this.domaines = domaines;
        Domaine domaine;
        for(domaine in domaines){
          print("${domaine.domaineID} et ${domaine.nomdomaine} et ${domaine.imageUrl}");
        }// Update state with fetched data
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
              Navigator.pop(context);
              /*if(widget.type==1){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeDefaultPage()),
                );
              }*/
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Domaines',
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
                itemCount: domaines.length,
                itemBuilder: (context, index) {
                  return Column( // Wrap in a Column for vertical spacing
                    children: [
                      Domaine(
                        domaineID: domaines[index].domaineID,
                        nomdomaine: domaines[index].nomdomaine,
                        imageUrl: domaines[index].imageUrl, type: widget.type,
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
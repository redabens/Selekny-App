import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reda/Services/prestation_service.dart';
import 'package:reda/components/Prestation_container.dart';

class PrestationPage extends StatefulWidget {
  final String domaineID;
  const PrestationPage({
    super.key,
    required this.domaineID,
  });

  @override
  State<PrestationPage> createState() => _PrestationPageState();
}

class _PrestationPageState extends State<PrestationPage> {
  final PrestationsService _PrestationsService = PrestationsService();
 Future<String> getPrestationPathImage(String prestationID) async{
  final prestationDoc = await FirebaseFirestore.instance
      .collection('Domaine')
      .doc(widget.domaineID)
      .collection('Prestations')
      .doc(prestationID)
      .get();

  if (prestationDoc.exists && prestationDoc.data() != null) {
  final pathImage = prestationDoc.get('PathImage') as String;
  final url = await FirebaseStorage.instance.ref().child(pathImage).getDownloadURL();
  return url;
  } else {
  return 'default_image_url';
  }
}
Future<String> getPrestationNom(String prestationID) async{
  final prestationDoc = await FirebaseFirestore.instance
      .collection('Domaine')
      .doc(widget.domaineID)
      .collection('Prestations')
      .doc(prestationID)
      .get();
  if (prestationDoc.exists && prestationDoc.data() != null) {
    final nomPrestation = prestationDoc.get('nom_prestation') as String;
    return nomPrestation;
  } else {
    return 'default_name';
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
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: const Text(
            'Prestations',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true
          ,
        ),
        body: Column(
          children:[
            const SizedBox(height: 20),
            Expanded(
              child: _buildPrestationList(),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPrestationList(){
    return StreamBuilder(
      stream: _PrestationsService.getPrestations(widget.domaineID), //_firebaseAuth.currentUser!.uid
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }
        final documents = snapshot.data!.docs;

        // Print details of each document
        for (var doc in documents) {
          print("Document Data: ${doc.data()}");
        }
        return FutureBuilder<List<Widget>>(
            future: Future.wait(snapshot.data!.docs.map((document) => _buildPrestationItem(document))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error loading comments ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(children: snapshot.data!);
            });
      },
    );
  } Future<Widget> _buildPrestationItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String profileImage = "assets/images/placeholder.png"; // Default image
    String nomprestation = "";
    try {
      print(document.id);
      profileImage = await getPrestationPathImage(document.id);
      print("l'url:$profileImage");
      nomprestation = await getPrestationNom(document.id);
      print("le nom:$nomprestation");
    } catch (error) {
      print("Error fetching user image: $error");
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Prestation(nomprestation: nomprestation, imageUrl: profileImage),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/AjoutPrestation/DetailsPrestation.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/AjoutPrestation/FormulaireAjoutPrestation.dart';
import 'package:reda/Pages/retourAuth.dart';
import '../../../Services/Domaine_service.dart';

class AjoutPrestationAunDomaine extends StatefulWidget {
  final String idDomaine;
  final String nomDomaine;
  const AjoutPrestationAunDomaine({
    super.key,
    required this.idDomaine,
    required this.nomDomaine});

  @override
  AjoutPrestationAunDomaineState createState() => AjoutPrestationAunDomaineState();

}

class AjoutPrestationAunDomaineState extends State<AjoutPrestationAunDomaine> {
  final DomainesService _domainesService = DomainesService();
  Future<String> getPrestationPathImage(String pathImage) async {

    // Retourner le PathImage
    final reference = FirebaseStorage.instance.ref().child(pathImage);
    try {
      // Get the download URL for the user image
      final downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print("Error fetching user image URL: $error");
      return ''; // Default image on error
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(nomdomaine: widget.nomDomaine,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15,),
          Expanded(
            child: _buildPrestationList(),
          ),

        ],
      ),
    );
  }
  Widget _buildPrestationList() {
    return StreamBuilder(
      stream: _domainesService.getPrestations(widget.idDomaine),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                return Center(child: Text('Error loading demandes encours:  ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 70,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFD9D9D9),
                            width: 3.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Image.asset('assets/add.png'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FormulaireAjoutPrestation(Domaineid: widget.idDomaine,)),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Ajouter une prestation',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFC4C4C4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ), // Encapsulez le contenu dynamique dans une méthode
                      ),
                      ]
                  ),
                );
              }
              // Combine prestation items with AjouterPrestation widget
              final children = snapshot.data!.map((domainItem) => domainItem).toList();
              children.add(
                Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 70,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFD9D9D9),
                            width: 3.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                icon: Image.asset('assets/add.png'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FormulaireAjoutPrestation(Domaineid: widget.idDomaine,)),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Ajouter une prestation',
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFC4C4C4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ), // Encapsulez le contenu dynamique dans une méthode
                      ),
                      ]
                  ),
                ),
              );
              children.add(const SizedBox(height: 10,),);
              return ListView(children: children);
            });
      },
    );
  }
  Future<Widget> _buildPrestationItem(DocumentSnapshot document) async {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String imageUrl = await getPrestationPathImage(data['image']);
    return Column( // Wrap in a Column for vertical spacing
      children: [
        Prestation(
          nomprestation: data['nom_prestation'],
          imageUrl: imageUrl,
          domaineId: widget.idDomaine,
          prestationId: document.id, prixmin: data['prixmin'],
          prixmax: data['prixmax'], unite: data['unite'], materiel: data['materiel'] ?? '',
        ),
        const SizedBox(height: 10), // Add spacing between containers
      ],
    );

  }
}



class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String nomdomaine;
  const MyAppBar({super.key,
    required this.nomdomaine});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false, // Désactiver la flèche de retour en arrière
          //backgroundColor: Colors.blue,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //SizedBox(width: 0),
              Container( // Enveloppez l'icône dans un Container pour créer un bouton carré
                height: 40, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(width: 80),
              Center( // Centrer le texte horizontalement
                child: Text(
                  nomdomaine,//nom prestation
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,

                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Prestation extends StatelessWidget {
  final String nomprestation;
  final String imageUrl;
  final String domaineId;
  final String prestationId;
  final int prixmin;
  final int prixmax;
  final String unite;
  final String materiel;
  const Prestation({super.key,
    required this.nomprestation,
    required this.imageUrl,
    required this.domaineId,
    required this.prestationId,
    required this.prixmin,
    required this.prixmax,
    required this.unite,
    required this.materiel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      //height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFC4C4C4),
          width: 2.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoPres(imagePath: imageUrl,),
          const SizedBox(width: 8),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child:RichText(
                    text: TextSpan(children: <TextSpan>[

                      TextSpan( text:nomprestation, style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),

                      ),
                    ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height:40,
            child: IconButton(
              icon: Image.asset('assets/forward.png'), // Remplacez le chemin par votre image
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPrestation(domaineID: domaineId,
                    prestationID: prestationId, imageUrl: imageUrl,
                    nomprestation: nomprestation, prixmin: prixmin,
                    prixmax: prixmax, unite: unite, materiel: materiel,),
                  ),
                );
              },
            ),
          ),


        ],
      ),
    );
  }
}

class PhotoPres extends StatelessWidget {
  final String imagePath;
  const PhotoPres({super.key,
    required this.imagePath,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 50,
      child: GestureDetector(
        onTap: (){},

        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Ajout du BorderRadius
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            height: 105,
            width: double.infinity,
          ),
        ),
      ),

    );
  }

}
class AjouterPrestation extends StatelessWidget {
  const AjouterPrestation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
          width: 3.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Image.asset('assets/add.png'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RetourAuth()),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ajouter une prestation',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFC4C4C4),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // Encapsulez le contenu dynamique dans une méthode
    );
  }
}

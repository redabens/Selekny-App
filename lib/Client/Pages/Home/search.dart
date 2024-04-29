import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';
import 'package:reda/Client/Services/demande%20publication/getMateriel.dart';

List<String> allPrestations = [];
List<String> prestationsIDs = [];
List<String> domaineIDs = [];
String domaineID = '';
String prestationID = '';

Future<void> fetchPrestations() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Domaine').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      QuerySnapshot prestationsSnapshot =
          await doc.reference.collection('Prestations').get();

      prestationsSnapshot.docs.forEach((prestationDoc) async {
        domaineID = doc.id;
        domaineIDs.add(domaineID);
        prestationID = prestationDoc.id;
        prestationsIDs.add(prestationID);
        String nomPrestation = prestationDoc['nom_prestation'];
        allPrestations.add(
          nomPrestation,
        );
      });
    }
  } catch (e) {
    print("Erreur lors de la récupération des prestations: $e");
  }
}

class CustomSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
          color: const Color(0xFF3E69FE))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xFF3E69FE));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in allPrestations) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () async {
            String prestationID = ''; // Remplacer par la vraie valeur de l'ID
            String domaineID = ''; // Remplacer par la vraie valeur de l'ID

            // Trouver l'index de l'élément dans la liste allPrestations
            int itemIndex = allPrestations.indexOf(result);

            // Utiliser l'index pour accéder aux ID correspondants
            if (itemIndex != -1 && itemIndex < prestationsIDs.length) {
              prestationID = prestationsIDs[itemIndex];
              domaineID = domaineIDs[itemIndex];
            }
            await getPrix(domaineID, prestationID);
            // await getPrixById(domaineID, prestationID);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsDemande(
                  domaineID: domaineID,
                  prestationID: prestationID,
                  nomprestation: result,
                ),
              ),
            );
          },
        );
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var item in allPrestations) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () async {
            String prestationID = ''; // Remplacer par la vraie valeur de l'ID
            String domaineID = ''; // Remplacer par la vraie valeur de l'ID

            // Trouver l'index de l'élément dans la liste allPrestations
            int itemIndex = allPrestations.indexOf(result);

            // Utiliser l'index pour accéder aux ID correspondants
            if (itemIndex != -1 && itemIndex < prestationsIDs.length) {
              prestationID = prestationsIDs[itemIndex];
              domaineID = domaineIDs[itemIndex];
            }
            await getPrixById(domaineID, prestationID);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsDemande(
                  domaineID: domaineID,
                  prestationID: prestationID,
                  nomprestation: result,
                ),
              ),
            );
          },
        );
      },
      itemCount: matchQuery.length,
    );
  }
}






/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  late List<Map<String, String>> prestations;
  late List<Map<String, String>> filteredPrestations;
  bool showList = false;

  @override
  void initState() {
    super.initState();
    prestations = [];
    filteredPrestations = [];
    fetchPrestations();
  }

  Future<void> fetchPrestations() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Domaine').get();

      List<Map<String, String>> allPrestations = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot prestationsSnapshot =
            await doc.reference.collection('Prestations').get();

        prestationsSnapshot.docs.forEach((prestationDoc) {
          String domaineID = doc.id;
          String prestationID = prestationDoc.id;
          String nomPrestation = prestationDoc['nom_prestation'];
          allPrestations.add({
            'domaineID': domaineID,
            'prestationID': prestationID,
            'nomPrestation': nomPrestation,
          });
        });
      }

      setState(() {
        prestations = allPrestations;
        filteredPrestations = prestations;
      });
    } catch (e) {
      print("Erreur lors de la récupération des prestations: $e");
    }
  }

  void filterPrestations(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredPrestations = prestations
            .where((prestation) => prestation['nomPrestation']!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      } else {
        filteredPrestations = prestations;
      }
      showList = query.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.2),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/Search_alt.png', width: 24, height: 24),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Chercher un service',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      filterPrestations(value);
                      showList = true;
                    });
                  },
                ),
              ),
            ],
          ),
          if (showList)
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  itemCount: filteredPrestations.length,
                  itemBuilder: (context, index) {
                    final prestation = filteredPrestations[index];
                    return ListTile(
                      title: Text(prestation['nomPrestation']!),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsDemande(
                              domaineID: prestation['domaineID']!,
                              prestationID: prestation['prestationID']!,
                              nomprestation: prestation['nomPrestation']!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}



*/




/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/PubDemande/detailsDemande.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  late List<String> prestations;
  late List<String> filteredPrestations;

  @override
  void initState() {
    super.initState();
    prestations = [];
    filteredPrestations = [];
    fetchPrestations();
  }

  Future<void> fetchPrestations() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Domaine').get();

      List<String> uniquePrestations = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot prestationsSnapshot =
            await doc.reference.collection('Prestations').get();

        prestationsSnapshot.docs.forEach((prestationDoc) {
          String nomPrestation = prestationDoc['nom_prestation'];
          String domaineId = doc.id;
          String prestationId = prestationDoc.id;
          print("Domaine : ${domaineId}");
          print("Prestation : ${prestationId}");
          if (!uniquePrestations.contains(nomPrestation)) {
            uniquePrestations.add(nomPrestation);
          }
        });
      }

      setState(() {
        prestations = uniquePrestations;
        filteredPrestations = prestations;
      });
    } catch (e) {
      print("Erreur lors de la récupération des prestations: $e");
    }
  }

  void filterPrestations(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredPrestations = prestations
            .where((prestation) =>
                prestation.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredPrestations = prestations;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.2),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/Search_alt.png', width: 24, height: 24),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Chercher un service',
                    border: InputBorder.none,
                  ),
                  onChanged: filterPrestations,
                ),
              ),
            ],
          ),
          SizedBox(
            // Limit the height of the ListView
            height: 100, // Set your desired height here
            child: ListView.builder(
              itemCount: filteredPrestations.length,
              itemBuilder: (context, index) {
                final prestation = filteredPrestations[index];
                return ListTile(
                  title: Text(prestation),
                  onTap: () {
                    String prestationID = filteredPrestations[index];
                    print("Tapped prestation : ${prestationID}");
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailsDemande(
                              domaineID: ,
                              prestationID: prestationID,
                              nomprestation: prestation)),
                    );*/
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/

/* Future<List<String>> fetchPrestations() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Domaine').get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot prestationsSnapshot =
            await doc.reference.collection('Prestations').get();

        prestationsSnapshot.docs.forEach((prestationDoc) {
          String nomPrestation = prestationDoc['nom_prestation'];
          uniquePrestations.add(nomPrestation);
        });
      }

      print("Prestations : ${uniquePrestations}");
    } catch (e) {
      print("Erreur lors de la récupération des prestations: $e");
    }

    return uniquePrestations;
  }
*/
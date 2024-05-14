import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reda/Client/Services/demande%20publication/getMateriel.dart';
import 'package:reda/Client/components/Date.dart';
import 'package:reda/Client/components/Demande.dart';
import 'package:reda/Services/ModifPrix.dart';
import 'Materiel.dart';
import 'Prix.dart';
import 'NomPrestation.dart';
import 'Urgence.dart';
import 'Suivant.dart';





class DetailsDemandeUrgente extends StatefulWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  const DetailsDemandeUrgente({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
  });

  @override
  DetailsDemandeUrgenteState createState() => DetailsDemandeUrgenteState();

}

class DetailsDemandeUrgenteState extends State<DetailsDemandeUrgente> {
  String? materiel=''; // Declare materiel as nullable String
  String? prix = '';
  Date datedebut = Date();
  bool urgence = true;
  int _rayonRecherche = 5; // Valeur initiale du rayon de recherche
  final ModifPrixService _modifPrixService = ModifPrixService();
  late Demande demandeinit = Demande(
      id_Client: "",
      id_Prestation: "",
      urgence: true,
      date_debut: "",
      date_fin: "",
      heure_debut: _getCurrentTime(), // Set current time in initState
      heure_fin: _getCurrentTime(),
      adresse: '',
      id_Domaine: '');
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    _fetchMaterial(widget.domaineID, widget.prestationID);
  }
  String _getCurrentTime() {
    // Get current time using DateTime
    final now = DateTime.now();
    // Format time as desired (e.g., "HH:mm")
    return DateFormat('HH:mm').format(now);
  }
  Future<void> _fetchMaterial(String domaineID, String prestationID) async {
    try {
      materiel = await getMaterielById(domaineID, prestationID);
      prix = await _modifPrixService.getPrixPrestation(domaineID, prestationID);
      setState(() {}); // Update UI with fetched material
    } catch (e) {
      print("Erreur lors de la recherche de matériel : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(domaineID: widget.domaineID,),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            NomPrestation(nomprestation: widget.nomprestation,),
            const SizedBox(width: 50, height: 25,),
            Materiel(materiel: materiel ?? 'rien',),
            const SizedBox(width: 50, height: 25,),
            Prix(prix: prix ?? 'prix',),
            const SizedBox(width: 50, height: 25,),
            Urgence(domaineID: widget.domaineID,prestationID: widget.prestationID,nomprestation: widget.nomprestation,demande: demandeinit, urgence: urgence,),
            const SizedBox(width: 50, height: 25,),
            Container(
              width: screenWidth * 0.85, // Prendre la largeur maximale disponible
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFEBE5E5),
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rayon de recherche:',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: screenWidth * 0.029,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropdownButton<int>(
                    value: _rayonRecherche,
                    items: [
                      for (int i in [5, 10, 15, 20, 25, 30]) // Boucle pour générer les options
                        DropdownMenuItem(
                          value: i,
                          child: Text('$i km'),
                        ),
                    ],
                    onChanged: (int? nouveauRayon) {
                      if (nouveauRayon != null) {
                        setState(() {
                          _rayonRecherche = nouveauRayon;
                          print("$_rayonRecherche");
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 50, height: 25,),
            Suivant(prestationID: widget.prestationID,demande: demandeinit,datedebut: datedebut,datefin: datedebut, domaineId: widget.domaineID, rayon: _rayonRecherche,),
          ],
        ),
      ),
    );
  }
}


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String domaineID;
  const MyAppBar({
    super.key, required this.domaineID
  });
  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                height:screenHeight* 0.05, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width:screenWidth*0.1,
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrestationPage(domaineID: domaineID, indexe: 2, type: 1,)),
                    );*/

                  },
                ),
              ),

              SizedBox(width:screenWidth*0.12),
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Détails de la demande',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
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

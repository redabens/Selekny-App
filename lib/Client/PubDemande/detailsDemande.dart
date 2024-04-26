import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Client/Services/demande%20publication/getMateriel.dart';
import 'package:reda/Client/components/Date.dart';
import 'package:reda/Client/components/Demande.dart';
import './Materiel.dart';
import './Prix.dart';
import './NomPrestation.dart';
import './Urgence.dart';
import './date.dart';
import './heure.dart';
import './Suivant.dart';





class DetailsDemande extends StatefulWidget {
  final String domaineID;
  final String prestationID;
  final String nomprestation;
  const DetailsDemande({
    super.key,
    required this.domaineID,
    required this.prestationID,
    required this.nomprestation,
  });

  @override
  State<DetailsDemande> createState() => DetailsDemandeState();

}

class DetailsDemandeState extends State<DetailsDemande> {
  late String? currentUserID;
  int _currentIndex = 0;
  String? materiel; // Declare materiel as nullable String
  String? prix;
  late Demande demandeinit = Demande(id_Client: "", id_Prestation: "", urgence: false, date_debut: "", date_fin: "", heure_debut: "", heure_fin: "", adresse: '', id_Domaine: '');
  late Date datedebut;
  late Date datefin ;
  @override
  void initState() {
    super.initState();
    // Fetch material on widget initialization
    _fetchMaterial(widget.domaineID, widget.prestationID);
  }
  Future<void> _fetchMaterial(String domaineID, String prestationID) async {
    try {
      materiel = await getMaterielById(domaineID, prestationID);
      prix = await getPrixById(domaineID, prestationID);
      setState(() {}); // Update UI with fetched material
    } catch (e) {
      print("Erreur lors de la recherche de matériel : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
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
              Urgence(domaineID: widget.domaineID,prestationID: widget.prestationID,nomprestation: widget.nomprestation,demande: demandeinit,),
              const SizedBox(width: 50, height: 25,),
              Dates(datedebut: datedebut,datefin: datefin,),
              const SizedBox(width: 50, height: 25,),
              Heure(demande: demandeinit,),
              const SizedBox(width: 50, height: 25,),
              Suivant(prestationID: widget.prestationID,demande: demandeinit,datedebut: datedebut,datefin: datefin, domaineId: widget.domaineID,),
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrestationPage(domaineID: domaineID, indexe: 2, type: 1,)),
                    );*/

                  },
                ),
              ),

             const SizedBox(width: 40),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DetailsPrestation extends StatefulWidget {
  final String domaineID;
  final String prestationID;
  const DetailsPrestation({
    super.key,
    required this.domaineID,
    required this.prestationID,

  });
  @override
  DetailsPrestationState createState() => DetailsPrestationState();

}

class DetailsPrestationState extends State<DetailsPrestation> {

  //les controlleur
 TextEditingController _controllerPrestation = TextEditingController();
  bool _isEditingNom = false;
 TextEditingController _controllerMateriel = TextEditingController();
  bool _isEditingMateriel = false;
 TextEditingController _controllerPrixmin = TextEditingController();
 TextEditingController _controllerPrixmax = TextEditingController();
  bool _isEditingPrix = false;
 TextEditingController _controllerUnite = TextEditingController();
  bool _isEditingUnit = false;
  String _selectedUnit = 'DA';

  //l'image
 String imagePath = '';
  String imageUrl = '';


  //---initialisation
  @override
  void initState() {
    super.initState();
   //initialisation des controlleurs par les champs de Prestation
   getPrestationData(widget.domaineID, widget.prestationID);
  }

//------------FONCTION TO GET PRESTATION FIELDS AND INITIALIZE THE CONTROLLERS-------------------
  Future<void> getPrestationData(String domaineID, String prestationID) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      DocumentSnapshot domaine = await firestore.collection('Domaine').doc(domaineID).get();
      if (!domaine.exists) {
        print('aucun domaine trouvé');
        _controllerPrestation.text = '';
        _controllerMateriel.text = '';
        _controllerPrixmin.text = '';
        _controllerPrixmax.text = '';
        _controllerUnite.text = 'DA';
        imagePath = '';
        imageUrl = '';

        return;
      }
      DocumentSnapshot prestation = await domaine.reference.collection('Prestations').doc(prestationID).get();
      if (!prestation.exists) {
        print('aucune prestation trouvée');
        _controllerPrestation.text = '';
        _controllerMateriel.text = '';
        _controllerPrixmin.text = '';
        _controllerPrixmax.text = '';
        _controllerUnite.text = '';
        imagePath = '';
        imageUrl = '';
        return;
      }
       //initialisation des controlleur si le domaine et la prestation existent
      _controllerPrestation.text = prestation.get('nom_prestation') ?? '';
      _controllerMateriel.text = prestation.get('materiel')??'';
      _controllerPrixmin.text = (prestation.get('prixmin') ?? 0).toString();
      _controllerPrixmax.text = (prestation.get('prixmax') ?? 0).toString();
      _controllerUnite.text =  prestation.get('unite')??'DA';
      imagePath = prestation.get('image');
      imageUrl = await storage.ref(imagePath).getDownloadURL();

    } catch (e) {
      print('Erreur lors de l\'obtention de la prestation: $e');
      _controllerPrestation.text = 'error getPrestationDtat';
      _controllerMateriel.text = '';
      _controllerPrixmin.text = '';
      _controllerUnite.text = 'DA';
      imageUrl='';
    }
  }

  //------------FUNCTION TO MODIFY ALL PRESTATION FIELDS WITH THE CONTROLLERS CONTENT-------------------
  Future<void> updatePrestation(String domaineID, String prestationID, String  newName,String newMateriel,String newPrixmin,String newPrixmax,String newUnite) async {
    try {
      int prixmin = int.tryParse(newPrixmin) ?? 0;
      int prixmax = int.tryParse(newPrixmax) ?? 0;

      DocumentReference domaine = FirebaseFirestore.instance.collection('Domaine').doc(domaineID);
      CollectionReference prestationsRef = domaine.collection('Prestations');
      DocumentReference prestation= prestationsRef.doc(prestationID);
      await prestation.update({
        'nom_prestation': newName,
        'materiel': newMateriel,
        'prixmin': prixmin,
        'prixmax':prixmax,
        'unite':newUnite,
      });
      print('Prestation mise à jour avec succès !');
    } catch (e) {
      print('Erreur lors de la mise à jour de la prestation : $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
               children: [
              const SizedBox(height: 20),
               Center(
               child: Column(
              children: [
   //-----------------------NOM PRESTATION-----------------------------------
               Container(
               width: MediaQuery.of(context).size.width * 0.9,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(
                     color: Colors.black.withOpacity(0.1),
                     width: 2.0,
                   ),

                 ),
                 padding: const EdgeInsets.all(14),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [


                             const SizedBox(width: 10),
                             Text(
                               'Le nom de la préstation :',
                               style: GoogleFonts.poppins(
                                 color: Colors.black,
                                 fontSize: 15,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                           ],
                         ),
                         IconButton(
                           icon: const Icon(Icons.edit),
                           onPressed: () {
                             setState(() {
                               _isEditingNom = !_isEditingNom;
                             });
                           },
                         ),
                       ],
                     ),
                     const SizedBox(height: 10, width: 20),
                     _isEditingNom
                         ? Container(
                       padding: const EdgeInsets.only(left: 10.0),
                       height: 50,
                       width: MediaQuery.of(context).size.width * 0.7, // Adjust width based on your needs
                       child: TextFormField(
                         controller: _controllerPrestation,
                         style: GoogleFonts.poppins(
                           color: const Color(0xFF6D6D6D),
                           fontSize: 13,
                           fontWeight: FontWeight.w700,
                         ),
                         decoration: const InputDecoration(
                           hintText: 'Entrez le nom de la préstation',
                           border: InputBorder.none,
                         ),
                         // Enable text wrapping for long text
                         maxLines: null, // Remove the limit on lines
                       ),
                     )
                         : Container(
                       padding: const EdgeInsets.only(left: 10.0),
                       width: MediaQuery.of(context).size.width * 0.7,
                       height: 40,
                       child: RichText(
                         text: TextSpan(children: <TextSpan>[
                           TextSpan(
                             text: _controllerPrestation.text,
                             style: GoogleFonts.poppins(
                               color: const Color(0xFF3E69FE),
                               fontSize: 14,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                         ]),
                       ),
                     ),
                   ],
                 ),
               ),
                   const SizedBox(height: 15,) ,
                //-----------------------MATERIEL-----------------------------------
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          'icons/materiel.png',
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Le matériel nécessaire :',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditingMateriel = !_isEditingMateriel;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _isEditingMateriel
                  ? Container(
                padding: const EdgeInsets.only(left: 10.0),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.7, // Adjust width based on your needs
                child: TextFormField(
                  controller: _controllerMateriel,
                  style: GoogleFonts.poppins(
                    color: Color(0xFF6D6D6D),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Entrez le matériel nécessaire',
                    border: InputBorder.none,
                  ),
                  // Enable text wrapping for long text
                  maxLines: null, // Remove the limit on lines
                ),
              )
                  : Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: _controllerMateriel.text,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF6D6D6D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
                const SizedBox(height: 15,) ,
                //-----------------------PRIX-----------------------------------
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black.withOpacity(0.1),
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(


            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        height: 23,
                        width: 23,
                        child: Image.asset(
                          'icons/prix.png',
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Prix approximatif :',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditingPrix = !_isEditingPrix;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '  Prix min :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _isEditingPrix
                      ? Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.6,

                    child:Column(
                      children:
                      [
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: _controllerPrixmin,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6D6D6D),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Entrez le matériel nécessaire',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number, // Clavier numérique
                          maxLength: 5, // Limite de 5 chiffres
                        ),
                      ],
                    ),
                  )
                      : Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: _controllerPrixmin.text,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF3E69FE),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '  Prix max :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _isEditingPrix
                      ? Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.6, // Adjust width based on your needs
                    child: Center(
                      child:TextFormField(
                        controller: _controllerPrixmax,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF6D6D6D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Entrez le prix max',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number, // Clavier numérique
                        maxLength: 5, // Limite de 5 chiffres
                      ),
                    ),
                  )
                      : Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: _controllerPrixmax.text,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF3E69FE),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
                const SizedBox(height: 15,) ,

           //-----------------------UNITE-----------------------------------
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 5.0),
                                height: 24,
                                width: 24,
                                child: Image.asset(
                                  'icons/Unit.png',
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                'L\'unité du prix :',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                _isEditingUnit = !_isEditingUnit;
                              });
                              if (!_isEditingUnit) {
                                // Fermer la liste déroulante lorsqu'on sort du mode d'édition
                                FocusScope.of(context).unfocus();
                              } else {
                                // Lorsque l'édition est activée, réinitialisez la valeur sélectionnée à la valeur actuelle
                                _selectedUnit = _controllerUnite.text;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10, width: 20),
                      _isEditingUnit
                          ? Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: DropdownButton<String>(
                          value: _selectedUnit,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedUnit = newValue!;
                            });
                            _controllerUnite.text = newValue!; // Utilisation de l'opérateur ! pour indiquer que newValue ne peut pas être null
                            setState(() {
                              _isEditingUnit = false; // Fermer la liste déroulante après la sélection
                            });
                            FocusScope.of(context).unfocus(); // Fermer le clavier après la sélection
                          },
                          items: <String>['DA','DA/h','DA/M', 'DA/M2', 'DA/Pièce'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: GoogleFonts.poppins(
                                fontSize: 14,fontWeight: FontWeight.w600,
                              ),),
                            );
                          }).toList(),
                        ),
                      )
                          : Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 30,
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: _controllerUnite.text,
                              style: GoogleFonts.poppins(
                                color: Color(0xFF3E69FE),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                //-------------------------MODIFIER L'IMAGE---------------------------------------------
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFEBE5E5),
              width: 2.0,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text(
                    'La photo de la préstation :',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                [
                  //SizedBox(width:5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                    child: GestureDetector(
                      onTap: () {
                        // Add your tap functionality here if needed
                      },
                      child: CachedNetworkImage(
                        imageUrl: imageUrl, // Replace with your image URL
                        placeholder: (context, url) => const CircularProgressIndicator(), // Optional
                        errorWidget: (context, url, error) => const Icon(Icons.error), // Optional
                        fit: BoxFit.cover, // Adjust the fit as necessary
                      ),
                    ),
                  ),

                  SizedBox(width:5),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9), // Couleur du bouton
                      borderRadius: BorderRadius.circular(8), // Border radius de 8
                    ),
                    child: TextButton.icon(
                      onPressed: () {

                      },
                      icon: Icon(Icons.file_upload, color: Color(0xFF323232)), // Icône pour importer une photo avec la couleur spécifiée
                      label: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'modifier la photo',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF323232),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent, // Rendre le fond transparent pour que la couleur de fond du Container soit visible
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Border radius de 8
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 10, width: 20),
            ],
          ),
        ),
                const SizedBox(height: 50,) ,


                //-----------------------BOUTON SAUV-----------------------------------
                   Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height:43, 
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                    color: const Color(0xFF3E69FE),
                    borderRadius: BorderRadius.circular(8),
                    ),
                      child: GestureDetector(
                    onTap: () async {
                     await updatePrestation(widget.domaineID, widget.prestationID, _controllerPrestation.text,_controllerMateriel.text,_controllerPrixmin.text,_controllerPrixmax.text,_controllerUnite.text);
                     await Future.delayed(const Duration(milliseconds: 300));
                         /* Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                AllSignalementsPage() //lazm la page de etesvoussur de sauvegarder
                            ),
                          );*/
                    },
                         child: Center(
                               child:Text(
                                 'Sauvegarder',
                                   style: GoogleFonts.poppins(
                                    color: Colors.white,
                                     fontSize: 14,
                                       fontWeight: FontWeight.w600,
                                           ),
                                           ),

                                          ),
                                         ),
                                        ),
                const SizedBox(height: 200) ,
                
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }
  @override
  void dispose() {
    _controllerPrestation.dispose();
    _controllerMateriel.dispose();
    _controllerPrixmin.dispose();
    _controllerPrixmax.dispose();
    _controllerUnite.dispose();
    super.dispose();
  }
}


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

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
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton( // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AjoutPrestationAunDomaine(),)
                    );*/

                  },
                ),
              ),

              const SizedBox(width: 40),
              Center(
                child: Text(
                  'Détails de la Préstation',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
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


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';




class FormulaireAjoutPrestation extends StatefulWidget {
  final String iddomaine;
  final String nomdomaine;
  const FormulaireAjoutPrestation({super.key,
    required this.iddomaine,
    required this.nomdomaine});

  @override
  FormulaireAjoutPrestationState createState() => FormulaireAjoutPrestationState();

}

class FormulaireAjoutPrestationState extends State<FormulaireAjoutPrestation> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: FormulaireScreen(),
    );
  }
}

class FormulaireScreen extends StatefulWidget {
  const FormulaireScreen({super.key});


  @override
  FormulaireScreenState createState() => FormulaireScreenState();

}

class FormulaireScreenState extends State<FormulaireScreen> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  bool _loading = false;
  String _selectedUnit='DA';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceminController = TextEditingController();
  final TextEditingController _pricemaxController = TextEditingController();
  final TextEditingController _materielController = TextEditingController();
  final TextEditingController _uniteController = TextEditingController();

  void handleSubmit () async {
    if (_formKey.currentState!.validate()) return; {

      final pricemin = _priceminController.value.text;
      final pricemax = _pricemaxController.value.text;
      final name = _nameController.value.text;
      final materiel = _materielController.value.text;
      final unite = _uniteController.value.text;

      setState(() => _loading=true);



      setState(() => _loading=false);

    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.4);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: Stack(
            children: [


              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40,),
                  Form(
                    key: _formKey, // Add this line to associate the Form with _formKey
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(

                          controller : _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir le Nom de la préstation';
                            }
                            return null;
                          },


                          decoration: InputDecoration(
                            labelText: 'Nom de la préstation',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                          ),

                        ),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: _materielController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir le matériel nécessaire';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Matériel nécessaire',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                            suffixIcon: const Icon(Icons.hardware,color: Color(0xFF3E69FE)), // Remplacement de l'icône
                          ),
                        ),

                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _priceminController,
                          validator: (value) {
                            if (value == null || value.isEmpty  || value.length > 5) {
                              return 'Le prix doit être composé de 5 chiffres';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Prix minimum',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            suffixIcon: const Icon(Icons.attach_money, color: Color(0xFF3E69FE)),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                        ),


                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _pricemaxController,
                          validator: (value) {
                            if (value == null || value.isEmpty  || value.length > 5) {
                              return 'Le prix doit être composé de 5 chiffres';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Prix maximum',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            suffixIcon: const Icon(Icons.attach_money, color: Color(0xFF3E69FE)),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),

                        DropdownButtonFormField(
                          value: _selectedUnit,
                          items: ['DA', 'DA/M', 'DA/M2', 'DA/pièce']
                              .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedUnit = value.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Unité',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(

                          'La photo de la préstation:',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          Container(
                            height: 45,


                            decoration: BoxDecoration(
                              color: const Color(0xFFD9D9D9), // Couleur du bouton
                              borderRadius: BorderRadius.circular(8), // Border radius de 8
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                // Ajoutez ici le code à exécuter lorsque le bouton est pressé
                              },
                              icon: const Icon(Icons.file_upload, color: Color(0xFF323232)), // Icône pour importer une photo avec la couleur spécifiée
                              label: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Importer une photo',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF323232),
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
                          ),],
                        ),

                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: () => handleSubmit(),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(const Size(350, 47)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.13),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF3E69FE),
                            ),
                          ),

                          child: _loading?
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            "Ajouter",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                      ],
                    ),
                  ),
                ],
              ),



            ],
          ),
        ),

      ),


    );
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

              const SizedBox(width: 40),
              Center( // Centrer le texte horizontalement
                child: Text(
                  'Ajouter une préstation',
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
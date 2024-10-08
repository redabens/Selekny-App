
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reda/Admin/Services/Domaine_service.dart';
import 'package:reda/Pages/user_repository.dart';
import 'AjoutPrestationAunDomaine.dart';
import 'package:google_fonts/google_fonts.dart';

class FormulaireAjoutPrestation extends StatefulWidget {
  final String Domaineid;
  const FormulaireAjoutPrestation({super.key, required this.Domaineid});

  @override
  FormulaireAjoutPrestationState createState() =>
      FormulaireAjoutPrestationState();
}

class FormulaireAjoutPrestationState extends State<FormulaireAjoutPrestation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FormulaireScreen(
        Domaineid: widget.Domaineid,
      ),
    );
  }
}

class FormulaireScreen extends StatefulWidget {
  final String Domaineid;
  const FormulaireScreen({super.key, required this.Domaineid});


  @override
  FormulaireScreenState createState() => FormulaireScreenState();
}

class FormulaireScreenState extends State<FormulaireScreen> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here
  final DomainesService _domainesService = DomainesService();
  bool _loading = false;
  String _selectedUnit = 'DZD';

  String fileName = '';
  String newUrlImg = '';
  late UserRepository userRepository;

  Future<void> uploadPrestationPicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        final imageUrl =
        await userRepository.uploadImage("Prestations/", image);
        // update user image record
        final uri = Uri.parse(imageUrl);
        fileName = uri.pathSegments.last;
        print("FILE NAME : $fileName");
        setState(() {
          newUrlImg = imageUrl.toString();
          print("Url img : $newUrlImg");
        });
      }
    } catch (e) {
      print("There is an error in uploading image in profile");
      // afficher l erreur dans le front
    }
  }



  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceminController = TextEditingController();
  final TextEditingController _pricemaxController = TextEditingController();
  final TextEditingController _materielController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRepository = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.4);

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key:
                    _formKey, // Add this line to associate the Form with _formKey
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nameController,
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
                            suffixIcon: const Icon(Icons.hardware,
                                color: Color(
                                    0xFF3E69FE)), // Remplacement de l'icône
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _priceminController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 5) {
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
                            suffixIcon: const Icon(Icons.attach_money,
                                color: Color(0xFF3E69FE)),
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
                            if (value == null ||
                                value.isEmpty ||
                                value.length > 5) {
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
                            suffixIcon: const Icon(Icons.attach_money,
                                color: Color(0xFF3E69FE)),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField(
                          value: _selectedUnit,
                          items: ['DZD','DA/h','DA/M', 'DA/M²', 'DA/Pièce']
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9), // Couleur du bouton
                                borderRadius: BorderRadius.circular(
                                    8), // Border radius de 8
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  uploadPrestationPicture();
                                },
                                icon: const Icon(Icons.file_upload,
                                    color: Color(
                                        0xFF323232)), // Icône pour importer une photo avec la couleur spécifiée
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
                                  backgroundColor: Colors
                                      .transparent, // Rendre le fond transparent pour que la couleur de fond du Container soit visible
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Border radius de 8
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: () {
                            if(fileName !=''
                                && _pricemaxController.value.text!=''
                                && _priceminController.value.text!=''
                                && _materielController.value.text != ''
                                && _nameController.value.text != '') {
                              _domainesService.ajouterPrestation(
                                  _nameController.value.text,
                                  int.tryParse(_pricemaxController.value.text)!,
                                  int.tryParse(_priceminController.value.text)!,
                                  _selectedUnit,
                                  _materielController.value.text,
                                  fileName,
                                  widget.Domaineid);
                              Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all<Size>(const Size(350, 47)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.13),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF3E69FE),
                            ),
                          ),
                          child: _loading
                              ? const SizedBox(
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

class Gestion extends StatefulWidget {
  const Gestion({super.key});

  @override
  GestionState createState() => GestionState();
}

class GestionState extends State<Gestion> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}

class AjoutDomaine extends StatefulWidget {
  const AjoutDomaine({super.key});

  @override
  AjoutDomaineState createState() => AjoutDomaineState();
}

class AjoutDomaineState extends State<AjoutDomaine> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}

class AjoutArtisan extends StatefulWidget {
  const AjoutArtisan({super.key});

  @override
  AjoutArtisanState createState() => AjoutArtisanState();
}

class AjoutArtisanState extends State<AjoutArtisan> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Column(
        children: [],
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
          automaticallyImplyLeading:
          false, // Désactiver la flèche de retour en arrière
          //backgroundColor: Colors.blue,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //SizedBox(width: 0),
              Container(
                // Enveloppez l'icône dans un Container pour créer un bouton carré
                height:
                40, // Définissez la hauteur et la largeur pour obtenir un bouton carré
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  // Utilisez un IconButton au lieu d'un MaterialButton pour avoir l'icône
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AjoutPrestationAunDomaine(
                            idDomaine: '',
                            nomDomaine: '',
                          )),
                    );
                  },
                ),
              ),

              const SizedBox(width: 40),
              Center(
                // Centrer le texte horizontalement
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
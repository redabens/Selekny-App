import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/AjoutDomaine/ajouterDomaine.dart';
import 'package:reda/Admin/Pages/artisaninscri.dart';
import 'package:reda/Pages/auth.dart';
import 'package:reda/Pages/usermodel.dart';
import 'package:reda/Services/ConvertAdr.dart';
import 'package:reda/Services/notifications.dart';
import '../../Admin/Pages/GestionsUsers/gestionArtisans_page.dart';
import '../../Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';

NotificationServices notificationServices = NotificationServices();
late String token;
late ValueNotifier<String> selectedDomaine;
List<String> domaines = [];
List<String> allPrestations = [];
List<String> selectedPrestations = [];

Future<void> getToken() async {
  token = await notificationServices.getDeviceToken() ?? '';
}

class CreationArtisanPage extends StatelessWidget {
  final String domaine;
  const CreationArtisanPage({super.key, required this.domaine});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: CreationArtisanScreen(domaine: domaine,),
      ),
    );
  }
}

class CreationArtisanScreen extends StatefulWidget {
  final String domaine;
  const CreationArtisanScreen({super.key, required this.domaine});

  @override
  State<CreationArtisanScreen> createState() => _CreationArtisanScreenState();
}

class _CreationArtisanScreenState extends State<CreationArtisanScreen> {
  int _currentIndex = 2;
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _loading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _numController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<List<String>> fetchPrestationsByDomaine(String selectedDomaine) async {
    List<String> prestations = [];

    if (selectedDomaine.isEmpty) {
      print('Erreur: Le domaine sélectionné est vide.');
      return prestations;
    }
    try {
      print(
          "Le domaine sélectionné: $selectedDomaine"); // Ajout d'un message de débogage
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Domaine')
          .where('Nom',
          isEqualTo: selectedDomaine) // Utilisation du nom du domaine
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String domaineId = querySnapshot.docs.first.id;
        QuerySnapshot prestationsSnapshot = await FirebaseFirestore.instance
            .collection('Domaine')
            .doc(domaineId)
            .collection('Prestations')
            .get();

        prestationsSnapshot.docs.forEach((prestationDoc) async {
          String nomPrestation = prestationDoc['nom_prestation'];
          prestations.add(nomPrestation);
        });
      }

      setState(() {
        allPrestations = prestations; // Mise à jour de la liste de prestations
      });

      print(
          "Prestations possibles: $prestations"); // Ajout d'un message de débogage
      return prestations;
    } catch (e) {
      print("Erreur lors de la récupération des prestations: $e");
      return prestations;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedPrestations.clear();
    selectedDomaine = ValueNotifier<String>(widget.domaine);
    fetchDomaines().then((domainesList) {
      setState(() {
        domaines = domainesList;
      });
    });

    fetchPrestationsByDomaine(widget.domaine); // Call on change
  }
  Future<List<String>> fetchDomaines() async {
    List<String> domaines = [];

    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('Domaine').get();

      for (var doc in querySnapshot.docs) {
        domaines.add(doc['Nom']);
      }
    } catch (e) {
      print("Erreur lors de la récupération des domaines: $e");
    }
    return domaines;
  }

  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      final adresse = _adresseController.value.text;
      final number = _numController.value.text;
      final name = _nameController.value.text;

      final Map position = await geocode(adresse);

      setState(() => _loading = true);

      await getToken();
      await signUp(email, password, name, number, adresse, position);

      setState(() => _loading = false);
    }
  }

  Future<void> signUp(String email, String password, String name, String number,
      String adresse, Map position) async {
    try {
      User? user = await _auth.signUpwithEmailAndPassword(email, password);
      String id = user != null ? user.uid : '';
      ArtisanModel newArtisan = ArtisanModel(
          id: id,
          nom: name,
          numTel: number,
          adresse: adresse,
          email: email,
          motDePasse: password,
          pathImage: '',
          latitude: position['latitude'],
          longitude: position['longitude'],
          statut: true,
          domaine: selectedDomaine.value,
          prestations: selectedPrestations,
          token: '',
          rating: 3.5,
          vehicule: false,
          bloque: false,
          nbsignalement: 0,
          workcount: 0);

      if (user != null) {
        print("User successfully created");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreationArtisanPage(domaine: 'Electricité')),
        );
        try {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(id)
              .set(newArtisan.toJson());

          print('Document added successfully');
          print("ID auth : $id");
        } on FirebaseAuthException catch (e) {
          print("Error adding document: $e");
        }
      } else {
        print("Some error happend");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print('The password provided is too weak');
      } else if (e.code == "email-already-in-use") {
        print('The account already exists for that email');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.4);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.white,),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 40),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 82,
                      height: 88,
                    ),
                    SizedBox(height:screenHeight*0.03),
                    Text(
                      'Creation compte artisan',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight*0.11),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedDomaine.value,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            decoration: InputDecoration(
                              labelText: 'Domaine',
                              labelStyle: GoogleFonts.poppins(
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPrestations.clear();
                                selectedDomaine.value = newValue ?? '';
                                fetchPrestationsByDomaine(newValue ?? '');
                              });
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => CreationArtisanPage(domaine: newValue!),),
                              );
                            },

                            items: domaines.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14)),
                                );
                              },
                            ).toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez sélectionner un domaine";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height:screenHeight*0.01),
                          TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir le nom';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Nom',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                            ),
                          ),
                          SizedBox(height:screenHeight*0.02),
                          TextFormField(
                            controller: _adresseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir l'adresse";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Adresse',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.location_pin),
                            ),
                          ),
                          SizedBox(height:screenHeight*0.01),
                          TextFormField(
                            controller: _numController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Numero obligatoire';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.phone),
                              prefixIcon: CountryCodePicker(
                                onChanged: (CountryCode? code) {
                                  print(code);
                                },
                                initialSelection: 'DZ',
                                favorite: const ['DZ'],
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: true,
                                alignLeft: false,
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                          SizedBox(height:screenHeight*0.01),

                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez saisir l'email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.alternate_email),
                            ),
                          ),
                          SizedBox(height:screenHeight*0.01),
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir le mot de passe';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Créer mot de passe',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
                          ),
                          SizedBox(height:screenHeight*0.008),
                          TextFormField(
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer le mot de passe';
                              } else {
                                if (value != _passwordController.value.text) {
                                  return 'Les mots de passe ne correspondent pas';
                                }
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Confirmer mot de passe',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:screenHeight*0.01),
                    DropdownButtonFormField<String>(
                      value: null,
                      hint:  Text(
                        'Sélectionner les prestations',
                        style: GoogleFonts.poppins(  fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          if (newValue != null && newValue == 'Tout') {
                            selectedPrestations = List.from(allPrestations);
                          } else {
                            if (selectedPrestations.contains('Tout')) {
                              selectedPrestations.remove('Tout');
                            }
                            if (selectedPrestations.contains(newValue)) {
                              selectedPrestations.remove(newValue);
                            } else {
                              selectedPrestations.add(newValue!);
                            }
                          }
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Tout',
                          child: Text('Sélectionner tout',style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600)),
                        ),
                        ...allPrestations.map<DropdownMenuItem<String>>(
                              (prestation) {
                            return DropdownMenuItem<String>(
                              value: prestation,
                              child:Text(prestation,style: GoogleFonts.poppins(fontSize: 13),overflow:TextOverflow.ellipsis,textWidthBasis: TextWidthBasis.parent, softWrap: true, maxLines: 2),
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    SizedBox(height:screenHeight*0.01),
                    Wrap(
                      spacing: 2.0,
                      runSpacing: 4.0,
                      children: selectedPrestations.map((prestation) {
                        return Chip(
                          label: Expanded (child:Text(prestation,style: GoogleFonts.poppins(fontSize: 13),overflow:TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,), ),
                          onDeleted: () {
                            setState(() {
                              selectedPrestations.remove(prestation);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height:screenHeight*0.03),
                    ElevatedButton(
                      onPressed: () async {
                        await handleSubmit();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Artisan(),),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all<Size>(const Size(350, 47)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          :  Text(
                        "Créer compte artisan",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height:screenHeight*0.01),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AllSignalementsPage(),),
                );
              },
              child: Container(
                height: screenHeight*0.04,
                child: Image.asset(
                  'icons/signalement.png',
                  color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GestionArtisansPage(),),
                );


              },
              child: Container(
                height:screenHeight*0.04,
                child: Image.asset(
                  'icons/gestion.png',
                  color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CreationArtisanPage(domaine: 'Electricité',),),
                );

              },
              child: Container(
                height: screenHeight*0.04,
                child: Image.asset(
                  'icons/ajoutartisan.png',
                  color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DomainServicePage(),)
                );

              },
              child: Container(
                height: screenHeight*0.04,
                child: Image.asset(
                  'icons/ajoutdomaine.png',
                  color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

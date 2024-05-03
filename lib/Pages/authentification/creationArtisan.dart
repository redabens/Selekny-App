import 'package:flutter/material.dart';
import 'package:reda/Pages/auth.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Pages/usermodel.dart';
import 'package:reda/Services/ConvertAdr.dart';
import 'package:reda/Services/notifications.dart';
import '../WelcomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';

NotificationServices notificationServices = NotificationServices();
late String token;
late ValueNotifier<String> selectedDomaine;
late List<String> domaines = [];
late List<String> allPrestations = [];
List<String> selectedPrestations = [];

Future<void> getToken() async {
  token = await notificationServices.getDeviceToken() ?? '';
}

class CreationArtisanPage extends StatelessWidget {
  const CreationArtisanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: CreationArtisanScreen(),
      ),
    );
  }
}

class CreationArtisanScreen extends StatefulWidget {
  const CreationArtisanScreen({Key? key}) : super(key: key);

  @override
  _CreationArtisanScreenState createState() => _CreationArtisanScreenState();
}

class _CreationArtisanScreenState extends State<CreationArtisanScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _loading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

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
    selectedDomaine = ValueNotifier<String>('');
    fetchDomaines().then((domainesList) {
      setState(() {
        domaines = domainesList;
        selectedDomaine.value = domaines.isNotEmpty ? domaines.first : '';
      });
    });

    selectedDomaine.addListener(() {
      fetchPrestationsByDomaine(selectedDomaine.value); // Call on change
    });
  }

  @override
  void dispose() {
    selectedDomaine.dispose();
    super.dispose();
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
      final job = _jobController.value.text;

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
          rating: 4,
          vehicule: false,
          nbsignalement: 0,
          workcount: 0);

      if (user != null) {
        print("User successfully created");
        UserRepository userRepository = UserRepository();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomePage()),
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
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.4);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35, top: 60),
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
                    width: 85,
                    height: 90,
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Creation compte Artisan',
                    style: TextStyle(
                      fontSize: 27,
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
                  const SizedBox(height: 85),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                            suffixIcon: const Icon(Icons.location_pin),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedDomaine.value,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          decoration: InputDecoration(
                            labelText: 'Domaine',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDomaine.value = newValue ?? '';
                              fetchPrestationsByDomaine(newValue ?? '');
                              selectedPrestations.clear();
                            });
                          },
                          items: domaines.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
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
                        const SizedBox(height: 10),
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
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: const UnderlineInputBorder(),
                            suffixIcon: const Icon(Icons.alternate_email),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                            labelStyle: TextStyle(
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
                        const SizedBox(height: 6),
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
                            labelStyle: TextStyle(
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
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: null,
                    hint: Text('Sélectionner les prestations'),
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
                        child: Text('Sélectionner tout'),
                      ),
                      ...allPrestations.map<DropdownMenuItem<String>>(
                        (prestation) {
                          return DropdownMenuItem<String>(
                            value: prestation,
                            child: Text(prestation),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: selectedPrestations.map((prestation) {
                      return Chip(
                        label: Text(prestation),
                        onDeleted: () {
                          setState(() {
                            selectedPrestations.remove(prestation);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () => handleSubmit(),
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
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Créer compte artisan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

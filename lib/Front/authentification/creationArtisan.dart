import 'package:flutter/material.dart';
import '../WelcomeScreen.dart';
import 'connexion.dart';
import 'package:http/http.dart' as http;
import 'package:reda/Back/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Back/respositories/user_repository.dart';
import 'package:reda/Back/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Back/services/ConvertAdr.dart';

class CreationArtisanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',

      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(),

      home: Scaffold(
        body: CreationArtisanScreen(),
      ),
    );
  }
}

class CreationArtisanScreen extends StatefulWidget {
  @override
  _CreationArtisanScreenState createState() => _CreationArtisanScreenState();
}

class _CreationArtisanScreenState extends State<CreationArtisanScreen> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  bool _showPassword = false;
  // String _email = '';
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

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      final adresse = _adresseController.value.text;
      final number = _numController.value.text;
      final name = _nameController.value.text;
      final job = _jobController.value.text;

      final Map position = await geocode(adresse);

      setState(() => _loading = true);

      void _signUp() async {
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
            domaine: job,
          );
          // ajouter l utilisateur a la base de donnees firestore
          // CollectionReference users =
          //FirebaseFirestore.instance.collection('users');

          if (user != null) {
            print("User successfully created");
            UserRepository userRepository = UserRepository();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
            try {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(id)
                  .set(newArtisan.toJson());

              print('Document added successfully');
              print("ID auth : ${id}");
            } on FirebaseAuthException catch (e) {
              print("Error adding document: $e");
            }
          } else {
            print("Some error happend");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == "weak-password") {
            print('The password provided is too weak');
            // afficher une erreur dans le UI
          } else if (e.code == "email-already-in-use") {
            print('The account already exists for that email');
            // afficher une erreur dans le UI
          }
        } catch (e) {
          print(e.toString());
        }
      }

      _signUp();
      setState(() => _loading = false);
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
                    'lib/Front/assets/logo.png',
                    width: 85,
                    height: 90,
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Creation compte Artisan',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'Nunito Sans',
                    ),
                  ),
                ],
              ),
            ),
            // Login fields
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 85),
                  Form(
                    key:
                        _formKey, // Add this line to associate the Form with _formKey
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
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
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
                            border: UnderlineInputBorder(),
                            suffixIcon: Icon(Icons.location_pin),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _numController,
                          validator: (value) {
                            if (value == '+213' ||
                                value == null ||
                                value.isEmpty) {
                              return 'Numero obligatoire';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '+213',
                            suffixIcon: Icon(Icons.phone),
                            prefixIcon: Image.asset(
                              'lib/Front/assets/Algeria.png',
                              width: 14,
                              height: 14,
                            ),
                          ),

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          keyboardType: TextInputType.phone,
                          // initialValue:  '+213',
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _jobController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez saisir le domaine de l'artisan ";
                            }
                            return null;
                          },
                          // onSaved: (value) {
                          //   _email = value ?? '';
                          // },
                          //
                          decoration: InputDecoration(
                            labelText: 'Domaine',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez saisir l'email";
                            }
                            return null;
                          },
                          // onSaved: (value) {
                          //   _email = value ?? '';
                          // },
                          //
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: textColor,
                            ),
                            border: UnderlineInputBorder(),
                            suffixIcon: Icon(Icons.alternate_email),
                          ),
                        ),
                        SizedBox(height: 10),
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
                            border: UnderlineInputBorder(),
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
                        SizedBox(height: 6),
                        TextFormField(
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez confirmer le mot de passe';
                            } else {
                              // Check if it matches the value in the "Créer mot de passe" field
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
                            border: UnderlineInputBorder(),
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
                  SizedBox(height: 25),
                  // signUp button
                  ElevatedButton(
                    onPressed: () => handleSubmit(),
                    child: _loading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Créer compte artisan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(350, 47)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.13),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF3E69FE),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  SizedBox(height: 12),
                  // Row for additional text widgets
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

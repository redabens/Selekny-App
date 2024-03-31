import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WelcomeScreen.dart';
import 'connexion.dart';
import 'package:reda/Back/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Back/respositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reda/Back/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: InscriptionScreen(),
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  bool _showPassword = false;
  String _email = '';
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
                      'Inscrivez-vous !',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                            decoration: InputDecoration(
                              labelText: 'Nom',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre Nom';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Adresse',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.location_pin),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre adresse';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.phone),
                              prefixIcon: Image.asset(
                                'lib/Front/assets/Algeria.png',
                                width: 14,
                                height: 14,
                              ),
                            ),
                            initialValue: '+213 ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Numero obligatoir';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(Icons.alternate_email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value ?? '';
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Créer mot de passe',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre mot de passe';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirmer mot de passe',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer votre mot de passe';
                              }
                              // Check if it matches the value in the "Créer mot de passe" field
                              if (value != _passwordController.text) {
                                return 'Les mots de passe ne correspondent pas';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        // Check if the form is valid
                        if (_formKey.currentState!.validate()) {
                          _signUp();
                        }
                      },
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(350, 47)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    Center(
                      child: Text(
                        'En vous inscrivant, vous acceptez nos\n'
                        'conditons et notre politique de confidentialité',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Row for additional text widgets
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous avez déjà un compte?',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Action when "Se connecter" is pressed
                            // go to the LogIn page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String name = _nameController.text;
    String numTel = _phoneNumberController.text;
    String email = _emailController.text;
    String adresse = _addressController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    try {
      User? user = await _auth.signUpwithEmailAndPassword(email, password);
      String id = user != null ? user.uid : '';
      ClientModel newClient = ClientModel(
          id: id,
          nom: name,
          numTel: numTel,
          adresse: adresse,
          email: email,
          motDePasse: password);
      // ajouter l utilisateur a la base de donnees firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      if (user != null) {
        print("User successfully created");
        UserRepository userRepository = UserRepository();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage()),
        );
        try {
          await userRepository.createUser(newClient);
          print('Document added successfully');
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
}

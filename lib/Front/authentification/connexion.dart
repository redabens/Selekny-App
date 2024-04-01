import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'forgotpassword.dart';
import 'inscription.dart';
import 'package:reda/Back/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Role { client, artisan }

String errorMessage = '';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _email = '';
  String _password = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  //  Authentification's functions
  void _signin() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    try {
      User? user = await _auth.signInwithEmailAndPassword(email, password);
      print("User connection success");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Afficher a l utilisateur une erreur lui indiquant que cet utlisateur n existe pas
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // aussi avertir l utilisateur que le mot de passe entre est faux et ne coincide pas avec celui entre lors de l inscription
      }
    }
  }

  void authenticateWithGoogle() async {
    try {
      await _auth.signInWithGoogle();
      if (context.mounted) {
        // rediriger vers la page d acceuil
      }
    } catch (e) {
      print("There is an error in sign in with google$e");
    }
  }

  void authenticateWithFacebook() async {
    try {
      await _auth.signInWithFacebook();
      if (context.mounted) {
        // rediriger vers la page d acceuil
      }
    } catch (e) {
      print("There is an error in sign in with facebook $e");
      //afficher une erreur
    }
  }

  Future<String> getUserRole(String email) async {
    DocumentSnapshot? userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(email).get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        return userData['role'] ??
            ''; // Utilisation de ?? pour fournir une valeur par défaut si 'role' n'existe pas ou si userData est null
      }
    }

    return ''; // Valeur par défaut si userSnapshot est null ou si l'utilisateur n'existe pas
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, top: 60),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'lib/Front/assets/logo.png',
                      width: 85,
                      height: 90,
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Connexion',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Login fields

              // Login fields
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 120),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
// Email field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          border: const UnderlineInputBorder(),
                          suffixIcon: const Icon(Icons.alternate_email),
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
                      const SizedBox(height: 20),
// Password field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre mot de passe';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                      ),
                      const SizedBox(height: 35),
                      const SizedBox(
                        height: 35,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 0),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• Choisissez votre statut :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .black, // Adjust the color as needed
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
// ToggleSwitch
                          ToggleSwitch(
                            minWidth: 170.0,
                            minHeight: 35.0,
                            cornerRadius: 20,
                            initialLabelIndex: 0,
                            activeBgColor: const [Color(0xFF3E69FE)],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.black.withOpacity(0.15),
                            inactiveFgColor: Colors.black,
                            labels: const ['Client', 'Prestataire'],
                            onToggle: (index) {
// Here we can handle the toggle change
                            },
                          ),
                          const SizedBox(height: 20),
// Login button
                          ElevatedButton(
                            onPressed: () {
                              // Validate the form before proceeding
                              if (_formKey.currentState!.validate()) {
                                // Save the form data
                                _formKey.currentState!.save();

                                // Simulate login process (replace with actual authentication logic)
                                // For example, check if email and password are correct
                                if (_email == 'user@example.com' &&
                                    _password == 'password') {
                                  // If login successful, navigate to home screen
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                } else {
                                  // If login failed, show error message (replace with your error handling)
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          ' email ou mot de passe invalide'),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(216, 37)),
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
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
// Row for additional text widgets
                          const SizedBox(height: 20),

                          Center(
                            child: Text(
                              '_____________________   ou   _____________________',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.35),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ), //
//
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
// Action when Facebook button is pressed
                                  authenticateWithFacebook();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  elevation: 8,
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.facebook,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
// Action when Google button is pressed
                                  authenticateWithGoogle();
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  elevation: 8, // Add shadow
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.telegram,
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
// Action when WhatsApp button is pressed
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  elevation: 4, // Add shadow
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordPage()),
                                  );
//Action here
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 42),
                              TextButton(
                                onPressed: () {
// Action when "S'inscrire" is pressed
// Navigate to the registration page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InscriptionPage()),
                                  );
                                },
                                child: const Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Adjust the color as needed
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

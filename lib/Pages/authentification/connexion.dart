import 'package:flutter/material.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Avenir.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/VousEtesBanni.dart';
import 'package:reda/Pages/auth.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'forgotpassword.dart';
import 'inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { client, artisan }

String errorMessage = '';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: const Scaffold(
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

  bool _loading = false;
  String selectedRole = 'client';
  int selectedindex = 0;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  String role = ''; // Variable globale pour stocker le rôle de l'utilisateur

  Future<void> getUserRole(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();
        role = userData['role'] ?? '';
      } else {
        print('No user found for email: $email');
        role = ''; // Réinitialiser le rôle si aucun utilisateur n'est trouvé
      }
    } catch (e) {
      print('Error retrieving user role: $e');
      role = ''; // Réinitialiser le rôle en cas d'erreur
    }
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Save the form data
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      setState(() => _loading = true);

      //  Authentification's functions
      void signin() async {
        try {
          User? user = await _auth.signInwithEmailAndPassword(email, password);
          if(user!.uid != 'jjjSB7ociHSHazUZ27iNYCiVCiD2') {
            final userdoc = await FirebaseFirestore.instance.collection('users')
                .doc(user.uid)
                .get();
            print(user.uid);
            Map<String, dynamic> data = userdoc.data() as Map<String, dynamic>;
            final bloque = data['bloque'];
            print('$bloque');
            if (!bloque) {
              await getUserRole(email);
              print("Role : " + role);
              if (role == selectedRole) {
                print("User connection success");
                if (role == 'client') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const HomePage()),
                  );
                }
                else if (role == 'artisan') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const ActiviteAvenir()),
                  );
                }
                //rediriger vers la page d acceuil
              } else {
                print(
                    "User don t match , user's email not found with that email");
                // afficher une erreur dans le UI  'cet utilisateur n existe pas'
              }
            }
            else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const Banni()),
              );
            }
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AllSignalementsPage()),
            );
          }
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

      signin();

      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black;

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
                      'assets/logo.png',
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
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: isDark
                                ? Colors.white
                                : Colors.black.withOpacity(0.4),
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
                      ),
                      const SizedBox(height: 20),
// Password field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(
                            color: isDark
                                ? Colors.white
                                : Colors.black.withOpacity(0.4),
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
                      ),
                      const SizedBox(height: 35),
                      const SizedBox(
                        height: 35,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• Choisissez votre statut :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : Colors
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
                            initialLabelIndex: selectedindex,
                            activeBgColor: const [Color(0xFF3E69FE)],
                            activeFgColor: Colors.white,
                            inactiveBgColor: isDark
                                ? Colors.grey.shade300
                                : Colors.black.withOpacity(0.15),
                            inactiveFgColor:
                            isDark ? Colors.black : Colors.black,
                            labels: const ['Client', 'Artisan'],
                            onToggle: (index) {
// Here we can handle the toggle change

                              setState(() {
                                selectedindex = index ?? -1;
                                selectedRole =
                                index == 0 ? 'client' : 'artisan';
                              });
                            },
                          ),
                          const SizedBox(height: 20),
// Login button
                          ElevatedButton(
                            onPressed: () => handleSubmit(),
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
                            child: _loading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text(
                              'Se connecter',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Center(
                            child: Text(
                              '_____________________   ou   _____________________',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.35),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ), //
                          const SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  elevation: 8, // Add shadow
                                ),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.telegram_outlined, // icon google
                                    color: Colors.lightBlue,
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
                                            const ForgotPasswordPage()),
                                  );
//Action here
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 42),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InscriptionPage()),
                                  );
                                },
                                child: Text(
                                  "S'inscrire",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.9),
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

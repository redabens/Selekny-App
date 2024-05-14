
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/activiteaujour.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/VousEtesBanni.dart';
import 'package:reda/Pages/auth.dart';
import 'package:reda/main.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'forgotpassword.dart';
import 'inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { client, artisan }

String errorMessage = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: const Scaffold(
        body: LoginScreen(),
      ),
      routes: {
        "client": (context) => const HomePage(),
        "artisan": (context) => const ActiviteaujourPage(),
        "admin" : (context) => const AllSignalementsPage(),
        "bloquer" : (context) => const Banni(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String selectedRole = 'client';
  late int type = 0;
  int selectedindex = 0;
  bool isLoading = false;
  late UserCredential userCredential;
  String role = ''; // Variable globale pour stocker le rôle de l'utilisateur
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  void authenticateWithGoogle() async {
    try {
      setState(() {
        isLoading = true; // Démarre le chargement
      });

      userCredential = await _auth.signInWithGoogle();
      String? email = userCredential.user?.email;
      print('$email');
      bool emailexist = await _auth.checkEmailExists(email!);
      if (emailexist) {
        await getUserRole(email);
        if (role == 'client') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (role == 'artisan') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActiviteaujourPage()),
          );
        }
      } else {
        print("Cette email n'existe pas");
        Fluttertoast.showToast(
          msg: "Cet utilisateur n'existe pas , veuillez vous inscrire.",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InscriptionPage(type: 1)),
        );
      }
    } catch (e) {
      print("There is an error in sign in with google$e");
    } finally {
      setState(() {
        isLoading = false; // Arrête le chargement
      });
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
  Future<void> signin(String email, String password) async {
    try {
      await _firebaseAuthService.signInwithEmailAndPassword(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Afficher a l utilisateur une erreur lui indiquant que cet utlisateur n existe pas
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // aussi avertir l utilisateur que le mot de passe entre est faux et ne coincide pas avec celui entre lors de l inscription
      }
    }
    await Future.value(null);
  }
  Future<void> handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Save the form data
      final email = _emailController.value.text;
      print(email);
      final password = _passwordController.value.text;
      //  Authentification's functions
      await signin(email,password);
    }
    await Future.value(null);
  }
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                    SizedBox(height:screenHeight*0.04),
                    Text(
                      'Connexion',
                      style: GoogleFonts.poppins(
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
                      SizedBox(height: screenHeight*0.06),
// Email field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(
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
                      SizedBox(height: screenHeight*0.01),
// Password field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: GoogleFonts.poppins(
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
                      SizedBox(height:screenHeight*0.07),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• Choisissez votre statut :',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : Colors
                                      .black, // Adjust the color as needed
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:screenHeight*0.030),
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
                          SizedBox(height:screenHeight*0.03),
// Login button
                          ElevatedButton(
                            onPressed: (){
                              handleSubmit();
                              const HomeScreen();
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenWidth*0.5, 37)),
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
                            child:  Text(
                              'Se connecter',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight*0.030),

                          Center(
                            child: Text(
                              '__________   ou   ___________',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: isDark
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.35),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ), //

                          SizedBox(height: screenHeight*0.030),
                          ElevatedButton(
                            onPressed: (){
                              authenticateWithGoogle();
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(screenWidth*0.8, 37)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13.13),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFDDDDDD),
                              ),
                            ),
                            // Espacement entre l'icône et le texte
                            child:  isLoading
                                ? const CircularProgressIndicator() // Afficher le chargement si isLoading est vrai
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png',height:18,width: 18,),
                                const SizedBox(width:12),
                                Text(
                                  'Se connecter avec Google',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),

                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:screenHeight*0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ForgotPasswordPage(type: 1,)),
                                  );
//Action here
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  style: GoogleFonts.poppins(
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width:screenWidth*0.042),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const InscriptionPage(type: 1,)),
                                  );
                                },
                                child: Text(
                                  "S'inscrire",
                                  style: GoogleFonts.poppins(
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

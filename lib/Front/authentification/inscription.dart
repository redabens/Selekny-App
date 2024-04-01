<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../WelcomeScreen.dart';
import 'connexion.dart';
import 'package:http/http.dart' as http;




class InscriptionPage extends StatelessWidget {
=======
import 'package:flutter/material.dart';
import '../WelcomeScreen.dart';
import 'connexion.dart';
import 'package:reda/Back/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Back/respositories/user_repository.dart';
import 'package:reda/Back/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InscriptionPage extends StatelessWidget {
  const InscriptionPage({super.key});

>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',
<<<<<<< HEAD

      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(),

      home: Scaffold(

=======
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
>>>>>>> main
        body: InscriptionScreen(),
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
<<<<<<< HEAD

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();

=======
  const InscriptionScreen({super.key});

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
>>>>>>> main
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  bool _showPassword = false;
<<<<<<< HEAD
 // String _email = '';
  bool _loading = false;
=======
  String _email = '';
>>>>>>> main
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
<<<<<<< HEAD
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _numController = TextEditingController();

    void handleSubmit () async {
      if (_formKey.currentState!.validate()) return; {
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      final adresse = _adresseController.value.text;
      final number = _numController.value.text;
      final name = _nameController.value.text;

      setState(() => _loading=true);

      //back pour rayane here

      setState(() => _loading=false);

    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.4);

=======
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
>>>>>>> main
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
<<<<<<< HEAD
                    SizedBox(height: 3),
                    Text(
=======
                    const SizedBox(height: 3),
                    const Text(
>>>>>>> main
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
<<<<<<< HEAD
                    SizedBox(height: 85),
                    Form(
                      key: _formKey, // Add this line to associate the Form with _formKey
                      child: Column(
                        children: [
                          TextFormField(

                            controller : _nameController,
=======
                    const SizedBox(height: 85),
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
                              border: const UnderlineInputBorder(),
                            ),
>>>>>>> main
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre Nom';
                              }
                              return null;
                            },
<<<<<<< HEAD


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
=======
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Adresse',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.location_pin),
                            ),
>>>>>>> main
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre adresse';
                              }
                              return null;
                            },
<<<<<<< HEAD

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
                              if (value == '+213' || value == null || value.isEmpty) {
                                return 'Numero obligatoir';
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: '+213',

                              suffixIcon: Icon(Icons.phone),
                              prefixIcon:
                              Image.asset(
=======
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.phone),
                              prefixIcon: Image.asset(
>>>>>>> main
                                'lib/Front/assets/Algeria.png',
                                width: 14,
                                height: 14,
                              ),
                            ),
<<<<<<< HEAD

                            style: TextStyle(
                              fontWeight :FontWeight.bold,
                            ),
                            keyboardType: TextInputType.phone,
                           // initialValue:  '+213',

                          ),

                          SizedBox(height: 10),
                          TextFormField(
                            controller: _emailController,
=======
                            initialValue: '+213 ',
                            style: const TextStyle(
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
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: const Icon(Icons.alternate_email),
                            ),
>>>>>>> main
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre email';
                              }
                              return null;
                            },
<<<<<<< HEAD
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
=======
                            onSaved: (value) {
                              _email = value ?? '';
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Créer mot de passe',
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
>>>>>>> main
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir votre mot de passe';
                              }
                              return null;
                            },
<<<<<<< HEAD

                            decoration: InputDecoration(
                              labelText: 'Créer mot de passe',
                              labelStyle: TextStyle(
                                color: textColor,
                              ),
                              border: UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword ? Icons.visibility : Icons.visibility_off,
=======
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Confirmer mot de passe',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
>>>>>>> main
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
<<<<<<< HEAD

                          ),
                          SizedBox(height: 6),
                          TextFormField(
                            controller: _confirmPasswordController,
=======
>>>>>>> main
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez confirmer votre mot de passe';
                              }
<<<<<<< HEAD
                              else {
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
                                  _showPassword ? Icons.visibility : Icons.visibility_off,
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

                      child: _loading?
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                                strokeWidth: 2,
                            ),
                          )
                          : Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(Size(350, 47)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
=======
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
                    const SizedBox(height: 25),
                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        // Check if the form is valid
                        if (_formKey.currentState!.validate()) {
                          _signUp();
                        }
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(350, 47)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
>>>>>>> main
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.13),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
<<<<<<< HEAD
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
                          color: isDark? Colors.white:Colors.black.withOpacity(0.35),
=======
                          const Color(0xFF3E69FE),
                        ),
                      ),
                      child: const Text(
                        'S\'inscrire',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'En vous inscrivant, vous acceptez nos\n'
                        'conditons et notre politique de confidentialité',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.35),
>>>>>>> main
                          fontWeight: FontWeight.normal,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                      ),
                    ),
<<<<<<< HEAD
                    SizedBox(height: 12),
=======
                    const SizedBox(height: 15),
>>>>>>> main
                    // Row for additional text widgets
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous avez déjà un compte?',
                          style: TextStyle(
<<<<<<< HEAD
                            color: isDark? Colors.white:Colors.black.withOpacity(0.5),
=======
                            color: Colors.black.withOpacity(0.5),
>>>>>>> main
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Action when "Se connecter" is pressed
                            // go to the LogIn page
                            Navigator.push(
                              context,
<<<<<<< HEAD
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                              color: isDark?Colors.white:Colors.black,
=======
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(
                              color: Colors.black,
>>>>>>> main
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
<<<<<<< HEAD
=======

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
          MaterialPageRoute(builder: (context) => const WelcomePage()),
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
>>>>>>> main
}

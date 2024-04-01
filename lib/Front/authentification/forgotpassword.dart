import 'package:flutter/material.dart';
import 'inscription.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ForgotPasswordScreen(),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  void resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email de réinitialisation envoyé.'),
        ),
      );
    } catch (e) {
      print('Error sending reset email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Erreur lors de l\'envoi de l\'email de réinitialisation.'),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _email = '';

  final TextEditingController _emailController = TextEditingController();

  bool _isEnvoyerClicked = false;

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
                      "Mot de passe oublié",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Saisissez votre email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          border: const UnderlineInputBorder(),
                          suffixIcon: const Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (_isEnvoyerClicked &&
                              (value == null || value.isEmpty)) {
                            return 'Veuillez saisir votre email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEnvoyerClicked = true;
                        });
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Entrer le code recu'),
                                content: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: "ex: 00000",
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Retour'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Envoyer'),
                                    onPressed: () {
                                      resetPassword(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(const Size(216, 37)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.13),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3E69FE),
                        ),
                      ),
                      child: const Text(
                        'Envoyer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous n'avez pas un compte?",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 9),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const InscriptionPage()),
                            );
                          },
                          child: const Text(
                            "Inscription",
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
}

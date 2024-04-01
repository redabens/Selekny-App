import 'package:flutter/material.dart';
import 'inscription.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
=======
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
>>>>>>> main
      home: Scaffold(
        body: ForgotPasswordScreen(),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
<<<<<<< HEAD
=======
  const ForgotPasswordScreen({super.key});

>>>>>>> main
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
<<<<<<< HEAD
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.5);

=======
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
>>>>>>> main
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
<<<<<<< HEAD
                    SizedBox(height: 5),
                    Text(
                      "Mot de passe oublié",
                      style: TextStyle(
=======
                    const SizedBox(height: 5),
                    const Text(
                      "Mot de passe oublié",
                      style: TextStyle(
                        color: Colors.black,
>>>>>>> main
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
<<<<<<< HEAD
                    SizedBox(height: 60),
=======
                    const SizedBox(height: 60),
>>>>>>> main
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Saisissez votre email",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
<<<<<<< HEAD
                          color: textColor,
=======
                          color: Colors.black.withOpacity(0.5),
>>>>>>> main
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
<<<<<<< HEAD
                            color: textColor,
                          ),
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
=======
                            color: Colors.black.withOpacity(0.4),
                          ),
                          border: const UnderlineInputBorder(),
                          suffixIcon: const Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (_isEnvoyerClicked &&
                              (value == null || value.isEmpty)) {
>>>>>>> main
                            return 'Veuillez saisir votre email';
                          }
                          return null;
                        },
<<<<<<< HEAD

                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                         final  _email = _emailController.value.text;
=======
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
>>>>>>> main
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
<<<<<<< HEAD

                                title: const Text('Entrer le code recu'),
                                content: TextFormField(
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "ex: 00000",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir le code';
                                    }
                                    return null;
                                  },
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Retour',
                                    style: TextStyle(
                                      color:Colors.black ,
                                    ),
                                    ),
                                    style: ButtonStyle(
                                      // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.10),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        Colors.grey.shade400,
                                      ),
                                      elevation: MaterialStateProperty.all<double>(7),
                                      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                                    ),
=======
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
>>>>>>> main
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
<<<<<<< HEAD
                                    child: const Text('Envoyer',
                                    style: TextStyle(color:Colors.white,)),
                                    style: ButtonStyle(
                                      // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.10),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        Color(0xFF3E69FE),
                                      ),
                                      elevation: MaterialStateProperty.all<double>(7),
                                      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                                    ),
                                    onPressed: () {
                                      final _code = _codeController.value.text;
                                      setState(() => _loading=true);

                                      //back pour rayane here

                                      setState(() => _loading=false);

                                      // Handle the submit action
=======
                                    child: const Text('Envoyer'),
                                    onPressed: () {
                                      resetPassword(context);
>>>>>>> main
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
<<<<<<< HEAD

                      child: _loading?
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ) : Text(
=======
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
>>>>>>> main
                        'Envoyer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
<<<<<<< HEAD
                      style: ButtonStyle(
                        // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFF3E69FE),
                        ),
                        elevation: MaterialStateProperty.all<double>(7),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),

                    ),
                    SizedBox(height: 30),
=======
                    ),
                    const SizedBox(height: 30),
>>>>>>> main
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous n'avez pas un compte?",
                          style: TextStyle(
<<<<<<< HEAD
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 9),
=======
                            color: Colors.black.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 9),
>>>>>>> main
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
<<<<<<< HEAD
                              MaterialPageRoute(builder: (context) => InscriptionPage()),
                            );
                          },
                          child: Text(
                            "Inscription",
                            style: TextStyle(
                              color: isDark? Colors.white:Colors.black.withOpacity(0.9),
=======
                              MaterialPageRoute(
                                  builder: (context) => const InscriptionPage()),
                            );
                          },
                          child: const Text(
                            "Inscription",
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
}
<<<<<<< HEAD


=======
>>>>>>> main

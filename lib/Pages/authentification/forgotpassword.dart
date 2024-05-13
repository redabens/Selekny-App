import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reda/Pages/auth.dart';
import 'inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuthService auth = FirebaseAuthService();

class ForgotPasswordPage extends StatelessWidget {
  final int type;
  const ForgotPasswordPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: ForgotPasswordScreen(type: type,),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  final int type;
  const ForgotPasswordScreen({super.key, required this.type,});

  @override 
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black.withOpacity(0.5);

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
                      "Mot de passe oublié",
                      style: TextStyle(
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
                          color: textColor,
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
                            color: textColor,
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
                    ),
                    const SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        print("Email : $email");
                        final emailexist = await auth.checkEmailExists(email);
                        if (!emailexist) {
                          Fluttertoast.showToast(
                            msg: "Cet email n'existe pas, Veuillez réessayer.",
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                          );
                        } else {
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text('Email de réinitialisation envoyé.'),
                              ),
                            );
                          } catch (e) {
                            print('Error sending reset email: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Erreur lors de l\'envoi de l\'email de réinitialisation.'),
                              ),
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3E69FE),
                        ),
                        elevation: MaterialStateProperty.all<double>(7),
                        shadowColor:
                        MaterialStateProperty.all<Color>(Colors.black),
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
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 9),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InscriptionPage(type: widget.type,),
                              ),
                            );
                          },
                          child: Text(
                            "Inscription",
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.9),
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
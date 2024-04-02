import 'package:flutter/material.dart';
import 'inscription.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: ForgotPasswordScreen(),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

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
                      'lib/Front/assets/logo.png',
                      width: 85,
                      height: 90,
                    ),
                    SizedBox(height: 5),
                    Text(
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
                    SizedBox(height: 60),
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
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre email';
                          }
                          return null;
                        },

                      ),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez saisir votre email';
                          }
                          return null;
                        };

                            },




                      child: Text(
                        'Envoyer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                          Color(0xFF3E69FE),
                        ),
                        elevation: MaterialStateProperty.all<double>(7),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),

                    ),
                    SizedBox(height: 30),
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
                        SizedBox(width: 9),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InscriptionPage()),
                            );
                          },
                          child: Text(
                            "Inscription",
                            style: TextStyle(
                              color: isDark? Colors.white:Colors.black.withOpacity(0.9),
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



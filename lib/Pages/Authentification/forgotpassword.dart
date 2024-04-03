import 'package:flutter/material.dart';
import 'inscription.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Scaffold(
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
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

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
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                         final  _email = _emailController.value.text;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(

                                title: const Text('Entrer le code recu'),
                                content: TextFormField(
                                  controller: _codeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  decoration: const InputDecoration(
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
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Retour',
                                    style: TextStyle(
                                      color:Colors.black ,
                                    ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.10),
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                        const Color(0xFF3E69FE),
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
                                    },
                                    child: const Text('Envoyer',
                                    style: TextStyle(color:Colors.white,)),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.10),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF3E69FE),
                        ),
                        elevation: MaterialStateProperty.all<double>(7),
                        shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),

                      child: _loading?
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ) : const Text(
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



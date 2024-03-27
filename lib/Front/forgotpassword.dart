import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/Front/verificationemail.dart';
import 'inscription.dart';


class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  ForgotPasswordScreen(),
      ),

    );
  }
}
class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 35,right: 35, top: 60),
          child: Stack(
            children: [
              Center(

                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/logo.png',
                      width: 85,
                      height: 90,
                    ),
                    SizedBox(height: 5),
                    Text(
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

              // Login fields
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
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),


                    // Login fields
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        border: UnderlineInputBorder(),
                        suffixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                    SizedBox(height: 30),
                        // Login button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Verificationemail()),
                            );

                          },
                          child: Text(
                            'Envoyer',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(Size(216, 37)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.13),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3E69FE),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

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
                     SizedBox(width: 9), //9
                        TextButton(
                          onPressed: () {
                            // Action when "Se connecter" is pressed
                            // go to the LogIn page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InscriptionPage()),
                            );
                          },
                          child: Text(
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

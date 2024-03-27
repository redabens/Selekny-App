import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/Front/forgotpassword.dart';
import 'inscription.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  LoginScreen(),
        ),

    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
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
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
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

                    SizedBox( height: 35,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                          children: [
                            Text(
                              '• Choisissez votre statut :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Adjust the color as needed
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // ToggleSwitch
                        ToggleSwitch(
                          minWidth: 170.0,
                          minHeight: 35.0,
                          cornerRadius: 20,
                          initialLabelIndex: 0,
                          activeBgColor: [Color(0xFF3E69FE)],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.black.withOpacity(0.15),
                          inactiveFgColor: Colors.black,
                          labels: ['Client', 'Prestataire'],
                          onToggle: (index) {
                            // Here we can handle the toggle change
                          },
                        ),
                        SizedBox(height: 20),
                        // Login button
                        ElevatedButton(
                          onPressed: () {

                          },
                          child: Text(
                            'Se connecter',
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
                        // Row for additional text widgets
                        SizedBox(height: 20),

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
                        ),//
                        //
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Action when Facebook button is pressed
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                elevation: 8,
                              ),
                              child: CircleAvatar(
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
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                elevation: 8, // Add shadow
                              ),
                              child: CircleAvatar(
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
                                shape: CircleBorder(),
                                elevation: 4, // Add shadow
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.apple,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                                );
                                //Action here
                              },
                                child:
                                Text(
                                  'Mot de passe oublié?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),


                            SizedBox(width: 42),
                            TextButton(
                              onPressed: () {
                                // Action when "S'inscrire" is pressed
                                // Navigate to the registration page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => InscriptionPage()),
                                );
                              },
                              child: Text(
                                "S'inscrire",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Adjust the color as needed
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
            ],
          ),
        ),
      ),
    );
  }
}

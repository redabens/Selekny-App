import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'forgotpassword.dart';
import 'inscription.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _email = '';
  String _password = '';


  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    var textColor = isDark ? Colors.white : Colors.black;


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
                      'lib/Front/assets/logo.png',
                      width: 85,
                      height: 90,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Connexion',
                     style: TextStyle(
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
                            SizedBox(height: 60),
// Email field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: isDark ? Colors.white :Colors.black.withOpacity(0.4),
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
                              onSaved: (value) {
                                _email = value ?? '';
                              },
                            ),
                            SizedBox(height: 20),
// Password field
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                labelStyle: TextStyle(
                                  color: isDark ? Colors.white :Colors.black.withOpacity(0.4),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir votre mot de passe';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value ?? '';
                              },
                            ),
                            SizedBox(height: 35),
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
                                        color: isDark ? Colors.white : Colors.black, // Adjust the color as needed
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
                                  inactiveBgColor: isDark? Colors.grey.shade300 : Colors.black.withOpacity(0.15),
                                  inactiveFgColor: isDark?Colors.black : Colors.black,
                                  labels: ['Client', 'Prestataire'],
                                  onToggle: (index) {
// Here we can handle the toggle change
                                  },
                                ),
                                SizedBox(height: 20),
// Login button
                                ElevatedButton(
                                  onPressed: () {
                                    // Validate the form before proceeding
                                    if (_formKey.currentState!.validate()) {
                                      // Save the form data
                                      _formKey.currentState!.save();

                                      // Simulate login process (replace with actual authentication logic)
                                      // For example, check if email and password are correct
                                      if (_email == 'user@example.com' && _password == 'password') {
                                        // If login successful, navigate to home screen
                                        Navigator.pushReplacementNamed(context, '/home');
                                      } else {
                                        // If login failed, show error message (replace with your error handling)
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                ' email ou mot de passe invalide',
                                          ),
                                          ),
                                        );
                                      }
                                    }
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
                                      color: isDark? Colors.white : Colors.black.withOpacity(0.35),
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
                                          Icons.telegram_outlined,
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
                                          color: isDark?Colors.white: Colors.black.withOpacity(0.5),
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
                                          color: isDark? Colors.white:Colors.black.withOpacity(0.9),
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

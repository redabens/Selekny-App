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
      home: const Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  bool _loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      // Save the form data
      final email = _emailController.value.text;
      final password = _passwordController.value.text;
      setState(() => _loading=true);

      //back pour rayane here

      setState(() => _loading=false);

    }
  }

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
                    const SizedBox(height: 5),
                    const Text(
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
                            const SizedBox(height: 60),
// Email field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: isDark ? Colors.white :Colors.black.withOpacity(0.4),
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
                            const SizedBox(height: 20),
// Password field
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                labelStyle: TextStyle(
                                  color: isDark ? Colors.white :Colors.black.withOpacity(0.4),
                                ),
                                border: const UnderlineInputBorder(),
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

                            ),
                            const SizedBox(height: 35),
                            const SizedBox( height: 35,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 0),

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
                                const SizedBox(height: 20),
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
                                  onPressed: () => handleSubmit (),
                                  child: _loading?
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  ) : Text(
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
                                SizedBox(height: 20),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {

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

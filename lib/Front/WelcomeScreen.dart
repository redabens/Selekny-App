import 'package:flutter/material.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'authentification/inscription.dart';
import 'authentification/connexion.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Image.asset(
                    'lib/Front/assets/workersimg.png', // Replace with your image path
                    width: 336,
                    height: 300,
                  ),
                  Text(
                    'Gagnez Du Temps\nAvec Nous !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      shadows: [
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 70.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        color: Color(0xFF3E69FE),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(330, 52)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.13),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      elevation: MaterialStateProperty.all<double>(5),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Color(0xFF3E69FE)),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InscriptionPage()),
                      );
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(330, 52)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF3E69FE),
                      ),
                      elevation: MaterialStateProperty.all<double>(7),
                      shadowColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(height: 170),
                ],
              ),
            ),
            Positioned(
              right: 5.0,
              bottom: 0.0,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen()), //to home page not login
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Ignorer ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 8.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward,
                        color: Theme.of(context).iconTheme.color, size: 19),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

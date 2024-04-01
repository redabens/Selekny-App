import 'package:flutter/material.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'authentification/inscription.dart';
import 'authentification/connexion.dart';

class WelcomePage extends StatelessWidget {
<<<<<<< HEAD
=======
  const WelcomePage({super.key});

>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
<<<<<<< HEAD
      home: Scaffold(
=======
      home: const Scaffold(
>>>>>>> main
        body: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
<<<<<<< HEAD
=======
  const WelcomeScreen({super.key});

>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
<<<<<<< HEAD
                  SizedBox(height: 60),
=======
                  const SizedBox(height: 60),
>>>>>>> main
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
<<<<<<< HEAD
                          offset: Offset(3.0, 3.0),
=======
                          offset: const Offset(3.0, 3.0),
>>>>>>> main
                          blurRadius: 8.0,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
<<<<<<< HEAD
                  SizedBox(height: 70.0),
=======
                  const SizedBox(height: 70.0),
>>>>>>> main
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
<<<<<<< HEAD
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
                      minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
=======
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(330, 52)),
>>>>>>> main
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.13),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      elevation: MaterialStateProperty.all<double>(5),
<<<<<<< HEAD
                      shadowColor: MaterialStateProperty.all<Color>(Color(0xFF3E69FE)),
                    ),
                  ),
                  SizedBox(height: 12),
=======
                      shadowColor: MaterialStateProperty.all<Color>(const Color(0xFF3E69FE)),
                    ),
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(
                        color: Color(0xFF3E69FE),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
>>>>>>> main
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
<<<<<<< HEAD
                        MaterialPageRoute(builder: (context) => InscriptionPage()),
                      );
                    },
                    child: Text(
=======
                        MaterialPageRoute(builder: (context) => const InscriptionPage()),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(const Size(330, 52)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF3E69FE),
                      ),
                      elevation: MaterialStateProperty.all<double>(7),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: const Text(
>>>>>>> main
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
<<<<<<< HEAD
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF3E69FE),
                      ),
                      elevation: MaterialStateProperty.all<double>(7),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(height: 170),
=======
                  ),
                  const SizedBox(height: 170),
>>>>>>> main
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()), //to home page not login
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
<<<<<<< HEAD
                            offset: Offset(3.0, 3.0),
=======
                            offset: const Offset(3.0, 3.0),
>>>>>>> main
                            blurRadius: 8.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Theme.of(context).iconTheme.color, size: 19),
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

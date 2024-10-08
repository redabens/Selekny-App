import 'package:flutter/material.dart';
import 'package:reda/Pages/homedefault.dart';
import 'authentification/inscription.dart';
import 'authentification/connexion.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: const Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.15),
                  Image.asset(
                    'assets/workersimg.png', // Replace with your image path
                    width: 336,
                    height: 320,
                  ),
                  Text(
                    'Gagnez Du Temps\nAvec Nous !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      shadows: [
                        Shadow(
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight*0.05),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(330, 52)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.13),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Colors.white,
                      ),
                      elevation: WidgetStateProperty.all<double>(5),
                      shadowColor:
                          WidgetStateProperty.all<Color>(const Color(0xFF3E69FE)),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InscriptionPage(type: 1,)),
                      );
                    },
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all<Size>(const Size(330, 52)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.12),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        const Color(0xFF3E69FE),
                      ),
                      elevation: WidgetStateProperty.all<double>(7),
                      shadowColor:
                          WidgetStateProperty.all<Color>(Colors.black),
                    ),
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight*0.15,)
                ],
              ),
            ),
            Positioned(
              right: 12.0,
              bottom: 30.0,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const HomeDefaultPage()), //to home page not login
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
                            offset: const Offset(3.0, 3.0),
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

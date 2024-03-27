import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Front/WelcomeScreen.dart';
import 'connexion.dart';



class InscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        body: InscriptionScreen(),
      ),
    );
  }
}

class InscriptionScreen extends StatefulWidget {
  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    child: Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 35,right: 35, top: 60),
    child: Stack(
    children: [
    Positioned(
    top: 0,
    left:0,
    right: 0,
    child:
    Column(
    children: [

    Image.asset(
    'lib/assets/logo.png',
    width: 85,
    height: 90,
    ),

    SizedBox(height: 3),
    Text(
    'Inscrivez-vous !',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    // Login fields
    Padding(
    padding: const EdgeInsets.only(left: 0, top: 60),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    SizedBox(height: 85),

      TextFormField(
        decoration: InputDecoration(
          labelText: 'Nom',
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
          ),
          border: UnderlineInputBorder(),
        ),
      ),
      SizedBox(height: 10),

      TextFormField(
        decoration: InputDecoration(
            labelText: 'Adresse',
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.4),

            ),
            border: UnderlineInputBorder(),
            suffixIcon: Icon(Icons.location_pin)
        ),
      ),
      SizedBox(height: 10),
      TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        prefixIcon:
        Image.asset(
          'lib/assets/Algeria.png',
          width: 14,
          height: 14,
        ),
      ),
      initialValue: '+213 ',
      style: TextStyle(
        fontWeight :FontWeight.bold,
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Champ obligatoire';
        }
        return null;
      },
    ),

      SizedBox(height: 10),

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
      SizedBox(height: 10),


      TextFormField(
        decoration: InputDecoration(
          labelText: 'Creer mot de passe',
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

      SizedBox( height: 8,),

      TextFormField(
        decoration: InputDecoration(
          labelText: 'Confirmer mot de passe',
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

          SizedBox(height: 25),
          // Login button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
            child: Text(
              'S\'inscrire',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ), 
              
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(350, 47)),
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
          SizedBox(height: 10),

      Center(
        child: Text(
          'En vous inscrivant, vous acceptez nos\n'
              'conditons et notre politique de confidentialité',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.35),
            fontWeight: FontWeight.normal,
            fontSize: 11,
          ),
          maxLines: 2,
        ),
      ),//
      SizedBox(height: 15),
//

      // Row for additional text widgets
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Vous avez deja un compte?',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),

              TextButton(
                onPressed: () {
                  // Action when "Se connecter" is pressed
                  // go to the LogIn page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Se connecter",
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

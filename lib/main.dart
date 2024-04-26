import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Artisan/Pages/NotifUrgente.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/WelcomeScreen.dart';
import 'package:reda/Pages/authentification/creationArtisan.dart';
import 'firebase_options.dart';
import 'package:reda/Services/ConvertAdr.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
double radians(double degrees) => degrees * pi / 180;
double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371.01; // Rayon de la Terre en km

  double dLat = radians(lat2 - lat1);
  double dLon = radians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(radians(lat1)) * cos(radians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // Distance en km
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*try {
    final results1 = await geocode('Bab Ezzouar, Hay Moussalaha, Alger, Algérie');
    final double latitude1 = results1['latitude'];
    final double longitude1 = results1['longitude'];
    print('Latitude: $latitude1, Longitude: $longitude1');
    final results2 = await geocode('Musee El Bardo, Alger, Algérie');
    final double latitude2 = results2['latitude'];
    final double longitude2 = results2['longitude'];
    print('Latitude: $latitude2, Longitude: $longitude2');
    print("Calculer distance :");
    final double distance = haversineDistance(latitude1,longitude1,latitude2,longitude2);
    print('la distance est : $distance km');
  } on Exception catch (e) {
    print('Une erreur est survenue : $e');
  }*/
  // el bardo : Latitude: 36.7199646, Longitude: 3.1991359;
  runApp(const MyApp());
}
/*void main() {
  runApp(const MyApp());
}*/

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;
  late String role ;
  Future<String> getUserRole(String email) async {

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();
        return userData['role'] ?? '';
      } else {
        print('No user found for email: $email');
        return ''; // Réinitialiser le rôle si aucun utilisateur n'est trouvé
      }
    } catch (e) {
      print('Error retrieving user role: $e');
      return''; // Réinitialiser le rôle en cas d'erreur
    }
  }
  @override
  void initState() {
    super.initState();
    checkIfLogin(); // Appel de la méthode pour vérifier l'état de connexion
  }

  void checkIfLogin() async {
    auth.authStateChanges().listen((User? user) async {
      final useremail = auth.currentUser?.email;
      role = await getUserRole(useremail!) ;
      print(useremail);
      print(role);
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

// si user est deja connecte on le redirige directement vers la page d acceuil
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: !isLogin ? const WelcomePage() : (role== 'client') ? const HomePage(): const NotifUrgente(),
      // const CreationArtisanPage(),
      //const ChatListPage(currentUserID:'hskvyxfATXnpgG8vsZlc'),
      //const PrestationPage(domaineID: "FhihjpW4MAKVi7oVUtZq"),
      //const PubDemandePage(),
      //const LoginScreen(),
      //const HomePage(),
      //const AfficherCommentairePage(artisanID: "kzChUvel32DSmy3ERjKI"),
      //const AjouterCommentairePage(nomPrestataire:"Reda" ,artisanID: "kzChUvel32DSmy3ERjKI"),
      //const ChatPage(receiverUserEmail:"ms_iratni@esi.dz", receiverUserID: "eOILQzRtIQlxwCGKhFMy"),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
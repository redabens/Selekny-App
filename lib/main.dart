import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Admin/Services/signalement_service.dart';
import 'package:reda/Artisan/Pages/Activit%C3%A9/Activit%C3%A9Avenir.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/Chat/chat_page.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
import 'package:reda/Pages/Commentaires/Ajouter_commentaire_page.dart';
import 'package:reda/Pages/WelcomeScreen.dart';
import 'Admin/Pages/Signalements/DetailsSignalement_page.dart';
import 'Admin/Pages/Signalements/AllSignalements_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // el bardo : Latitude: 36.7199646, Longitude: 3.1991359;
  runApp(const MyApp());
}
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
    SignalementsService _SignalementService = SignalementsService();
    print('oooooooooooooooooofffff main main');
    //_SignalementService.sendSignalement('poGC2ByeJPekcaN0NiSdAWDW7Oz2', 'il a également manqué de courtoisie pendant toute la durée de lintervention. Il semblait pressé et peu intéressé par mon problème. De plus, après avoir prétendument réparé la fuite, le problème est réapparu dès le lendemain. Je suis très insatisfait du service fourni par ce plombie');
    /*final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final currentUserId =_firebaseAuth.currentUser!.uid;*/
    return MaterialApp(
      //title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
      //DetailsSignalement(signaleurName: 'signaleurName', signalantName: 'signalantName', signaleurJob: 'signaleurJob', signalantJob: 'signalantJob', date: 'date', heure: 'heure', raison: 'raison')
      //AllSignalementsPage(),
      //const ChatPage(receiverUserID: 'Tz5EKrFdU7hWobWnkOIohVB3aWz2', currentUserId: 'IiRyRcvHOzgjrRX8GgD4M5kAEiJ3', type: 1)
     // const AjouterCommentairePage(nomPrestataire: 'mohamed benabed', artisanID: 'Tz5EKrFdU7hWobWnkOIohVB3aWz2'),
      !isLogin ? const WelcomePage() : (role== 'client') ? const HomePage(): const ActiviteAvenir(),
      //const ProfilePage(),
      //const CreationArtisanPage(),
      //const ChatListPage(type: 1,),
      //const PrestationPage(domaineID: "FhihjpW4MAKVi7oVUtZq"),
      //const PubDemandePage(),
      //const LoginScreen(),
      //const HomePage(),
      //const AfficherCommentairePage(artisanID: "kzChUvel32DSmy3ERjKI"),
      //const AjouterCommentairePage(nomPrestataire:"Reda" ,artisanID: "kzChUvel32DSmy3ERjKI"),
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
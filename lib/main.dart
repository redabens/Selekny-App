import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifUrgente.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Client/Pages/Home/search.dart';
import 'package:reda/Pages/WelcomeScreen.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Services/notifications.dart';
import 'firebase_options.dart';
import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityProvider() {
    _initConnectivity();
  }

  ConnectivityResult get connectivityResult => _connectivityResult;

  void _initConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(result);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectivityStatus(result);
    });
  }

  void _updateConnectivityStatus(ConnectivityResult result) {
    _connectivityResult = result;
    notifyListeners();
  }
}

class ConnectivityWidget extends StatelessWidget {
  final Widget child;

  const ConnectivityWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final connectivityProvider = Provider.of<ConnectivityProvider>(context);
        final connectivityResult = snapshot.data;

        if (connectivityResult == ConnectivityResult.none) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Color(0xFF3E69FE),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Erreur de connexion",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Vérifiez votre connexion Internet et réessayez.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        }

        return child;
      },
    );
  }
}

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

User? currentUser = FirebaseAuth.instance.currentUser;

final navigatorkey = GlobalKey<NavigatorState>();
NotificationServices notificationServices = NotificationServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ConnectivityResult connectivityResult =
  await Connectivity().checkConnectivity();

  final ConnectivityProvider connectivityProvider = ConnectivityProvider();
  connectivityProvider._updateConnectivityStatus(connectivityResult);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 /* var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'selekny',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Selekny',
  );
  print("/nNotificationChannelResult : ${result}");*/

  // el bardo : Latitude: 36.7199646, Longitude: 3.1991359;
  Future firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("Some notification received in background");
    }
  }

  notificationServices.requestNotificationPermission();
  //notificationServices.isTokenRefresh();
  notificationServices.getDeviceToken().then((value) {
    print("device token : $value");
  });
  // init firebase messaging
  await NotificationServices.initLocalNotifications();

  // listen to background notifications
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      /* navigatorkey.currentState!.push(MaterialPageRoute(
          builder: (context) =>
              ChatListPage(currentUserID: currentUser?.uid ?? "")));*/
    }
  });

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      NotificationServices.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // to handle in terminated state

  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      // delay time for app initialization
      navigatorkey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  await fetchPrestations();
  runApp(ChangeNotifierProvider.value(
    value: connectivityProvider,
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectivityWidget(
        child: MyApp(),
      ),
    ),
  ));
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
  late bool isLogin = false;
  var auth = FirebaseAuth.instance;
  late Future<String> roleFuture;
  late String role = '';
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
      return ''; // Réinitialiser le rôle en cas d'erreur
    }
  }

  String _token = '';

  static Future<void> saveUserToken(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'token': token,
    });
  }

  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await saveUserToken(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveUserToken);
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin(); // Appel de la méthode pour vérifier l'état de connexion
    setupToken();
  }

  void checkIfLogin() async {
    auth.authStateChanges().listen((User? user) async {
      final useremail = auth.currentUser?.email;
      role = await getUserRole(useremail!);
      print(useremail);
      print(role);
      if (user != null && mounted) {
        await Future.delayed(const Duration(milliseconds: 2000));
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
    return GetMaterialApp(
      // Ajoute initialBinding ici pour initialiser le UserRepository
      initialBinding: BindingsBuilder(() {
        Get.put(UserRepository());
      }),
      home: ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: ConnectivityWidget(
            child: Container(
              color: Colors.white, // Couleur de l'arrière-plan de la page
              child: Center(
                child: !isLogin
                    ? const WelcomePage()
                    : (role == 'client')
                    ? const HomePage()
                    : const NotifUrgente(),
              ),
            ),
          ),

          /*  routes: {
          "/message": (context) =>
              ChatListPage(currentUserID: currentUser?.uid ?? ""),
        },*/
        ),
      ),
    );
  }
// const CreationArtisanPage(),
//const ChatListPage(currentUserID:'hskvyxfATXnpgG8vsZlc'),
//const PrestationPage(domaineID: "FhihjpW4MAKVi7oVUtZq"),
//const PubDemandePage(),
//const LoginScreen(),
//const HomePage(),
//const AfficherCommentairePage(artisanID: "kzChUvel32DSmy3ERjKI"),
//const AjouterCommentairePage(nomPrestataire:"Reda" ,artisanID: "kzChUvel32DSmy3ERjKI"),
//const ChatPage(receiverUserEmail:"ms_iratni@esi.dz", receiverUserID: "eOILQzRtIQlxwCGKhFMy"),
}







/*class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      child: const LoadingWidget(),
      connectivityBuilder: (BuildContext context,
          ConnectivityResult connectivity, Widget child) {
        final bool isConnected = connectivity != ConnectivityResult.none;
        if (isConnected) {
          return !isLogin
              ? const WelcomePage()
              : (role == 'client')
                  ? const HomePage()
                  : const NotifUrgente();
        } else {
          return const OfflineWidget();
        }
      },
    );
  }
}

*/








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
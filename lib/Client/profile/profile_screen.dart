import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reda/Pages/authentification/connexion.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Pages/usermodel.dart';
import 'profile_menu.dart';
import 'update_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: const Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String tProfile = 'Profile';
  String tProfileHeading = '';
  String tProfileSubHeading = '';

  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepository();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    String? email = currentUser?.email;

    if (email != null) {
      try {
        UserModel? userModel = await userRepository.getUserDetails(email);
        print("User data retrieved successfully");
        setState(() {
          tProfileHeading = userModel.nom;
          tProfileSubHeading = email;
          print(tProfile);
          print(tProfileHeading);
          print("User data fetched inside setState");
        /*QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('User')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData = querySnapshot.docs.first.data();
          tProfileHeading= userData['name'] ?? '';
          tProfileSubHeading = email;
        }*/
        print("User data fetched");
        });
      } catch (e) {
        print("Error occured in fetchdata : ${e.toString()}");
      }
    } else {
      print("Email doesn't exist ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3FC),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
        ),
        title: Center(
          child: Text(
            tProfile,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        //actions: [
        //  IconButton(onPressed: () {}, icon: Icon(isDark ? Icons.sunny : Icons.mode_night_outlined),)
        //],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/profile.JPG'),
                    ),
                  ),
                  Positioned(
                    //edit small icon
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        print('Edit button tapped');
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.shade300,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(tProfileHeading,
                  style: Theme.of(context).textTheme.bodyMedium),
              Text(tProfileSubHeading,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 50),

              /// -- MENU
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade300
                          : Colors.black.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -20),
                    ),
                  ],
                ),
                child: Expanded(
                  child: Column(
                    children: [
                      ProfileMenuWidget(
                        title: "Editer le profile",
                        icon: Icons.person_outline_outlined,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen()),
                          );
                        },
                      ),
                      ProfileMenuWidget(
                          title: "Mode sombre",
                          icon: Icons.mode_night_outlined,
                          onPress: () {}),
                      ProfileMenuWidget(
                        title: "Devenir prestataire",
                        icon: Icons.work_outline_outlined,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        title: "Se deconnecter",
                        icon: Icons.logout_outlined,
                        endIcon: false,
                        onPress: () {
                          // Show AlertDialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("SE DECONNECTER"),
                              content: const Text(
                                  "etes-vous sur de vouloir vous déconnecter ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.10),
                                      ),
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                      Color(0xFF3E69FE),
                                    ),
                                    elevation:
                                    MaterialStateProperty.all<double>(7),
                                    shadowColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                  ),
                                  child: Text(
                                    "NON",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Deconnexion de l utilisateur
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage()), //to home page not login
                                    );
                                  },
                                  child: Text(
                                    "OUI",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.10),
                                      ),
                                    ),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                      Colors.grey.shade400,
                                    ),
                                    elevation:
                                    MaterialStateProperty.all<double>(7),
                                    shadowColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
//'assets/profile.JPG'
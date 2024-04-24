import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reda/Back/models/usermodel.dart';
import 'package:reda/Front/authentification/connexion.dart';
import 'profile_menu.dart';
import 'update_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Back/respositories/user_repository.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData.light(), // Use light theme by default
      darkTheme: ThemeData.dark(), // Define dark theme
      home: Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String tProfile = 'Profile';
  String tProfileHeading = '';
  String tProfileSubHeading = '';
  String imageUrl = '';

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
        imageUrl = await userRepository.getImgUrl(email);
        print("img url : " + imageUrl);
        print("User data retrieved successfully");
        setState(() {
          tProfileHeading = userModel.nom;
          tProfileSubHeading = email;
          print(tProfile);
          print(tProfileHeading);
          print("User data fetched inside setState");
        });

        print("User data fetched");
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
                color: Color(0xFFF1F3FC),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),
          title: Center(
            child: Text(
              tProfile,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(20), // Ajout de padding
                child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Centrage des enfants
                    children: [
                      const SizedBox(height: 10),
                      // Image de profil
                      imageUrl.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  50), // Ajout du BorderRadius
                              child: Image.network(
                                imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.account_circle,
                              size: 150,
                              color: Colors.grey[400],
                            ),
                      Text(tProfileHeading,
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(tProfileSubHeading,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 50),

                      /// -- MENU
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Theme.of(context).colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
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
                                      builder: (context) =>
                                          UpdateProfileScreen(),
                                    ),
                                  ).then((updatedUserData) {
                                    // Handle the updated user data here
                                    if (updatedUserData != null) {
                                      // Update the profile page with the updated user data
                                      setState(() {
                                        tProfileHeading = updatedUserData.nom;
                                        tProfileSubHeading =
                                            updatedUserData.email;
                                        imageUrl = updatedUserData.pathImage;
                                      });
                                    }
                                  });
                                  ;
                                },
                              ),
                              ProfileMenuWidget(
                                title: "Mode sombre",
                                icon: Icons.mode_night_outlined,
                                onPress: () {},
                              ),
                              ProfileMenuWidget(
                                title: "Devenir prestataire",
                                icon: Icons.work_outline_outlined,
                                onPress: () {},
                              ),
                              ProfileMenuWidget(
                                title: "Se déconnecter",
                                icon: Icons.logout_outlined,
                                endIcon: false,
                                onPress: () {
                                  // Show AlertDialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("SE DECONNECTER"),
                                      content: Text(
                                        "Êtes-vous sûr de vouloir vous déconnecter ?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Fermer le dialogue
                                            Navigator.pop(context);
                                          },
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
                                            // Déconnexion de l'utilisateur
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "OUI",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                    ]))));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:reda/Client/Pages/Demandes/demandeEncours_page.dart';
import 'package:reda/Client/Pages/Home/home.dart';
import 'package:reda/Pages/Chat/chatList_page.dart';
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
      debugShowCheckedModeBanner: false,
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
  int _currentIndex = 3;
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
  Future<String> getUserPathImage(String userID) async {
    // Récupérer le document utilisateur
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(userID).get();

    // Vérifier si le document existe
    if (userDoc.exists) {
      // Extraire le PathImage
      print('here');
      String pathImage = userDoc['pathImage'];
      print(pathImage);
      // Retourner le PathImage
      final reference = FirebaseStorage.instance.ref().child(pathImage);
      try {
        // Get the download URL for the user image
        final downloadUrl = await reference.getDownloadURL();
        return downloadUrl;
      } catch (error) {
        print("Error fetching user image URL: $error");
        return ''; // Default image on error
      }
    } else {
      // Retourner une valeur par défaut si l'utilisateur n'existe pas
      return '';
    }
  }
  Future<void> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    String? email = currentUser?.email;

    if (email != null) {
      try {
        UserModel? userModel = await userRepository.getUserDetails(email);
        imageUrl = await getUserPathImage(currentUser!.uid);
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
          title: Center(
            child: Text(
              tProfile,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20), // Ajout de padding
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
                          borderRadius: const BorderRadius.only(
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
                              offset: const Offset(0, -20),
                            ),
                          ],
                        ),
                        child: Expanded(
                          flex: 1, // Set the flex ratio if needed
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
                                          const UpdateProfileScreen(),
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
                                      title: const Text("SE DECONNECTER"),
                                      content: const Text(
                                        "Êtes-vous sûr de vouloir vous déconnecter ?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Fermer le dialogue
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
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
                                                    const LoginPage(),
                                              ),
                                            );
                                          },
                                          child: const Text(
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
                    ])
            )
        ),
      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: const Color(0xFFF8F8F8),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex, // Assurez-vous de mettre l'index correct pour la page de profil
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage(),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/accueil.png',
                  color: _currentIndex == 0 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DemandeEncoursPage(),),
                );


              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/demandes.png',
                  color: _currentIndex == 1 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatListPage(type: 1,),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/messages.png',
                  color: _currentIndex == 2 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage(),),
                );

              },
              child: Container(
                height: 40,
                child: Image.asset(
                  'assets/profile.png',
                  color: _currentIndex == 3 ? const Color(0xFF3E69FE) : Colors.black,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
//'assets/profile.JPG'
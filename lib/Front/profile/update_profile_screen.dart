import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reda/Front/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reda/Back/respositories/user_repository.dart';
import 'package:reda/Back/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // Strings
  String tFullName = 'Rachad Bachir';
  String tEditProfile = 'Editer le Profile       ';
  String tProfile = 'Profile';
  String tProfileHeading = 'Profile Heading';
  String tProfileSubHeading = 'Profile Sub Heading';
  String tEmail = 'Email';
  String tPhoneNo = 'numero';
  String tPassword = 'Ancien mot de passe';
  String tadress = 'Adresse';
  String Id = '';
  String name = '';
  String email1 = '';
  String numtel = '';
  String adresse = '';
  String oldPassword = '';
  String newPassword = '';
  String newName = '';
  String newEmail = '';
  String newAdress = '';
  String newPhoneNumber = '';
  bool isLoading = true;

  // Colors
  Color tPrimaryColor = Colors.white;
  Color tDarkColor = Colors.black;

  // Form height
  double tFormHeight = 20.0;

  String password = '';
  String confirmPassword = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserRepository userRepository;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userRepository = UserRepository();
    fetchUserData();
  }

  Future<String?> getUserIdFromFirestore(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si un document correspondant est trouvé, retournez son ID
        return querySnapshot.docs.first.id;
      } else {
        print('Aucun utilisateur trouvé pour l\'adresse e-mail : $email');
        return null;
      }
    } catch (e) {
      print(
          'Erreur lors de la recherche de l\'utilisateur dans Firestore : $e');
      return null;
    }
  }

  Future<void> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;
    String? email = currentUser?.email;
    String? id = await getUserIdFromFirestore(email ?? '');

    if (email != null) {
      try {
        userModel = await userRepository.getUserDetails(email);
        print("User data retrieved successfully");
        setState(() {
          Id = id ?? '';
          name = userModel.nom;
          email1 = email;
          numtel = userModel.numTel;
          adresse = userModel.adresse;
          oldPassword = userModel.motDePasse;
          isLoading = false;
          print("User data fetched inside setState");
        });
        print("User data fetched");
        print("le id : $Id");
      } catch (e) {
        print("Error occured in fetchdata : ${e.toString()}");
      }
    } else {
      print("Email doesn't exist ");
    }
  }

  Future<void> saveChanges() async {
    UserModel updatedUser = UserModel(
        id: Id,
        nom: newName == '' ? name : newName,
        numTel: newPhoneNumber == '' ? numtel : newPhoneNumber,
        adresse: newAdress == '' ? adresse : newAdress,
        email: newEmail == '' ? email1 : newEmail,
        role: userModel.role,
        motDePasse: newPassword == '' ? password : newPassword,
        pathImage: userModel.pathImage,
        latitude: userModel.latitude,
        longitude: userModel.longitude);

    await userRepository.updateUser(updatedUser);

    print(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.rectangle,
              borderRadius:
                  BorderRadius.circular(9), // Adjust border radius as needed
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tEditProfile,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Affichage de l'indicateur de chargement
            : Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // -- IMAGE with ICON
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                  image: AssetImage(
                                      'lib/Front/assets/profile.JPG'))),
                        ),
                        Positioned(
                          //edit small icon
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // Add your onTap logic here
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
                    const SizedBox(height: 50),

                    // -- Form Fields
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'nom/prenom',
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                newName = value;
                              },
                              initialValue:
                                  name, // importer depuis firestore !!!!!!!!!!!!!!!!!!!!!!!!!!
                            ),

                            SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: tEmail,
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                newEmail = value;
                              },
                              initialValue:
                                  email1, // importer depuis firestore !!!!!!!!!!!!!!!!!!!!!!!!!!
                            ),
                            SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: tPhoneNo,
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                newPhoneNumber = value;
                              },
                              initialValue:
                                  numtel, // importer depuis firestore !!!!!!!!!!!!!!!!!!!!!!!!!!
                            ),
                            SizedBox(height: tFormHeight - 20),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: tadress,
                                labelStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                                border: UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                newAdress = value;
                              },
                              initialValue:
                                  adresse, // importer depuis firestore !!!!!!!!!!!!!!!!!!!!!!!!!!
                            ),

                            SizedBox(height: tFormHeight),
                            // Old Password TextFormField
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: tPassword,
                              ),
                              onChanged: (value) {
                                password = value;
                              },
                              // verifier si password == oldpassword          ************************************************************
                            ),
                            SizedBox(height: tFormHeight),
                            // Password TextFormField
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Nouveau mot de passe',
                              ),
                              onChanged: (value) {
                                // Store the new password value if needed
                                newPassword = value;
                              },
                            ),
                            SizedBox(height: tFormHeight - 20),
                            // Confirm Password TextFormField
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirmer le nouveau mot de passe',
                              ),
                              validator: (value) {
                                if (value != newPassword) {
                                  return 'Les mots de passe ne correspondent pas';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                confirmPassword = value;
                              },
                            ),
                            SizedBox(height: tFormHeight + 20),
                            // -- Form Submit Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (password.isEmpty) {
                                    // Display an error message if old password is not provided
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Ancien mot de passe manquant'),
                                          content: Text(
                                              'Veuillez entrer votre ancien mot de passe pour sauvegarder les modifications.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return; // Exit onPressed function
                                  }

                                  // Form is valid, perform action
                                  // Check if the old password matches the current password

                                  try {
                                    // Re-authenticate the user to verify the old password
                                    AuthCredential credential =
                                        EmailAuthProvider.credential(
                                            email: email1,
                                            password: oldPassword);
                                    await FirebaseAuth.instance.currentUser
                                        ?.reauthenticateWithCredential(
                                            credential);
                                    print("avant updater");

                                    // Old password matches, proceed with further actions
                                    await saveChanges(); // Call the function to update user data
                                    print("Donnes mis a jour avec success");
                                  } catch (e) {
                                    // Handle re-authentication error
                                    print('Erreur de réauthentification : $e');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Erreur de réauthentification'),
                                          content: Text(
                                              'Votre ancien mot de passe est incorrect. Veuillez réessayer.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('Sauvegarder',
                                    style: TextStyle(color: tPrimaryColor)),
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(330, 52)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(13.13),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color(0xFF3E69FE),
                                  ),
                                  elevation:
                                      MaterialStateProperty.all<double>(5),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Color(0xFF3E69FE)),
                                ),
                              ),
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

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reda/Pages/user_repository.dart';
import 'package:reda/Pages/usermodel.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

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
  String oldImgUrl = '';
  double latitude = 0;
  double longitude = 0;
  String newUrlImg = '';
  String fileName = '';

  bool isLoading = true;

  // Colors
  Color tPrimaryColor = Colors.white;
  Color tDarkColor = Colors.black;

  // Form height
  double tFormHeight = 20.0;

  String password = '';
  String confirmPassword = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          latitude = userModel.latitude;
          longitude = userModel.longitude;
          oldImgUrl = userModel.pathImage;
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
        pathImage: fileName,
        latitude: userModel.latitude,
        longitude: userModel.longitude, token: userModel.token);

    try {
      await userRepository.updateUser(updatedUser);
      //  afficher a l utilisateur le succes de la sauvegarde
    } catch (e) {
      print("Error in saving profile edit : ${e.toString()}");
    }

    print(updatedUser);
  }

  Future<void> uploadUserProfilPicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        final imageUrl =
        await userRepository.uploadImage("Users/Images/Profile/", image);
        // update user image record
        final uri = Uri.parse(imageUrl);
        fileName = uri.pathSegments.last;
        print("FILE NAME : ${fileName}");
        setState(() {
          newUrlImg = imageUrl.toString();
          print("Url img : ${newUrlImg}");
        });
      }
    } catch (e) {
      print("There is an error in uploading image in profile");
      // afficher l erreur dans le front
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        leading: IconButton(
          onPressed: () {
            UserModel updatedUser = UserModel(
                id: Id,
                nom: newName == '' ? name : newName,
                numTel: newPhoneNumber == '' ? numtel : newPhoneNumber,
                adresse: newAdress == '' ? adresse : newAdress,
                email: newEmail == '' ? email1 : newEmail,
                role: userModel.role,
                motDePasse: newPassword == '' ? password : newPassword,
                pathImage: newUrlImg,
                latitude: userModel.latitude,
                longitude: userModel.longitude, token: userModel.token);
            Navigator.pop(context, updatedUser);
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
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
            ? const Center(
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
                      borderRadius: BorderRadius.circular(60),
                      child: oldImgUrl.isEmpty && newUrlImg.isEmpty
                          ? Icon(
                        Icons.account_circle,
                        size: 120,
                        color: Colors.grey[400],
                      ) // Placeholder si aucune image n'est disponible
                          : Image.network(
                        newUrlImg.isNotEmpty
                            ? newUrlImg
                            : oldImgUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Appeler la fonction pour télécharger une nouvelle image depuis la galerie
                        uploadUserProfilPicture();
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
                          border: const UnderlineInputBorder(),
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
                          border: const UnderlineInputBorder(),
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
                          border: const UnderlineInputBorder(),
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
                          border: const UnderlineInputBorder(),
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
                        decoration: const InputDecoration(
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
                        decoration: const InputDecoration(
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
                                    title: const Text(
                                        'Ancien mot de passe manquant'),
                                    content: const Text(
                                        'Veuillez entrer votre ancien mot de passe pour sauvegarder les modifications.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
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
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(330, 52)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(13.13),
                              ),
                            ),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                              const Color(0xFF3E69FE),
                            ),
                            elevation:
                            MaterialStateProperty.all<double>(5),
                            shadowColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF3E69FE)),
                          ),
                          child: Text('Sauvegarder',
                              style: TextStyle(color: tPrimaryColor)),
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
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reda/Front/profile/profile_screen.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);
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

  // Colors
  Color tPrimaryColor = Colors.white;
  Color tDarkColor = Colors.black;

  // Form height
  double tFormHeight = 20.0;

  String password = '';
  String confirmPassword = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Container(
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
                            image: AssetImage('lib/Front/assets/profile.JPG'))),
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
                        initialValue:
                            'Rachad Bachir', // Set the initial value here
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
                        initialValue:
                            'mr_bachir@esi.dz', // Set the initial value here
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
                        initialValue:
                            '+213658557616', // Set the initial value here
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
                        initialValue:
                            'Bab ezzouare ,Alger Algerie', // Set the initial value here
                      ),
                      SizedBox(height: tFormHeight),
                      // Password TextFormField
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: tPassword,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: tFormHeight - 20),
// Confirm Password TextFormField
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirmer le mot de passe',
                        ),
                        validator: (value) {
                          if (value != password) {
                            return 'Verifier votre mot de passe';
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, perform action
                              // Passwords match, proceed with further actions
                            } else {
                              // Form is not valid due to password mismatch
                              // You can display an error message or perform any other action
                              print('Passwords do not match');
                            }
                          },
                          child: Text('Sauvegarder',
                              style: TextStyle(color: tPrimaryColor)),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(330, 52)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.13),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF3E69FE),
                            ),
                            elevation: MaterialStateProperty.all<double>(5),
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

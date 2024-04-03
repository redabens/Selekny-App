import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reda/Front/profile/profile_screen.dart';

class UpdateProfileScreen extends StatelessWidget {
   UpdateProfileScreen({Key? key}) : super(key: key);
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   //Controllers
   final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _confirmPasswordController = TextEditingController();
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _nameController = TextEditingController();
   final TextEditingController _adresseController = TextEditingController();
   final TextEditingController _numController = TextEditingController();


   String tEditProfile = 'Editer le Profile       ';

               //variables pour prendre mn firestore
   String tFullName = 'Rachad Bachir';
   String tEmail = 'mr_bachir@esi.dz';
   String tAdresse = 'Bab ezzouar ,Alger Algerie';
   String tnumero = '+213658557616';

   // Form height
   double tFormHeight = 20.0;


   @override
  Widget build(BuildContext context) {
     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,

      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF121212) : Colors.white,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(  //icon retour
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(9), // Adjust border radius as needed
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
              // photo de profile
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('lib/Front/assets/profile.JPG'))), //URL va etre recupere du firestore
                  ),
                  Positioned(
                    //edit small icon
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Add your onTap logic here
                        print('sara can work here');
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
          padding: const EdgeInsets.only(left: 30,right: 30),
          child:
              Form(
                child: Column(
                  children: [
                    TextFormField(
                    //  controller: _nameController,
                      decoration:  InputDecoration(
                        labelText: 'nom/prenom',
                        labelStyle: TextStyle( color: Colors.grey.shade400,), border: UnderlineInputBorder(),
                      ),
                      initialValue: tFullName, // Set the initial value here

                    ),
                     SizedBox(height: tFormHeight - 20),

                    TextFormField(
                    //  controller: _emailController,
                      decoration:  InputDecoration(
                        labelText: tEmail,
                        labelStyle: TextStyle( color: Colors.grey.shade400,), border: UnderlineInputBorder(),
                      ),
                      initialValue: tEmail, // Set the initial value here
                    ),

                     SizedBox(height: tFormHeight - 20),

                    TextFormField(
                    //  controller: _numController,
                      decoration:  InputDecoration(
                        labelText: 'Numero',
                        labelStyle: TextStyle( color: Colors.grey.shade400,), border: UnderlineInputBorder(),
                      ),
                      initialValue: tnumero, // Set the initial value here
                    ),

                    SizedBox(height: tFormHeight - 20),

                    TextFormField(
                   //   controller: _adresseController,
                      decoration:  InputDecoration(
                        labelText: 'Adresse',
                        labelStyle: TextStyle( color: Colors.grey.shade400,), border: UnderlineInputBorder(),
                      ),
                      initialValue: tAdresse, // Set the initial value here

                    ),
                     SizedBox(height: tFormHeight ),

                    TextFormField(
                   //   controller: _passwordController,
                      obscureText: true,
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: 'Ancien mot de passe',
                      ),


                    ),
                     SizedBox(height: tFormHeight -20 ),

                    TextFormField(
                    //  controller: _confirmPasswordController,
                      obscureText: true,
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                      ),





                    ),


                    SizedBox(height: tFormHeight +20),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(

                        child:  Text('Sauvegarder', style: TextStyle(color: Colors.white)),

                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.13),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF3E69FE),
                          ),
                          elevation: MaterialStateProperty.all<double>(5),
                          shadowColor: MaterialStateProperty.all<Color>(Color(0xFF3E69FE)),
                        ),


                        onPressed: (){
                          _formKey.currentState!.validate();
                         },
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
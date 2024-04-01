import 'package:flutter/material.dart';
import 'package:reda/Front/WelcomeScreen.dart';
import 'profile_menu.dart';
import 'update_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  String tProfile = 'Profile       ';
  String tProfileHeading = 'Bachir Rachad';
  String tProfileSubHeading = 'mr_bachir@esi.dz';
  String tEditProfile = 'Editer le Profile';

  Color tPrimaryColor = const Color(0xFF3E69FE); // Use the appropriate color code or define your color
  Color tDarkColor = Colors.black.withOpacity(0.8); // Use the appropriate dark color or define your color

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
          decoration: const BoxDecoration(

          ),
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
                      child: Image.asset('lib/Front/assets/profile.JPG'),
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
              Text(tProfileHeading, style: Theme.of(context).textTheme.bodyMedium),
              Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyMedium),
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
                      color: Theme.of(context).brightness == Brightness.light ? Colors.grey.shade300 : Colors.black.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset( 0,-20),
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
                          MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
                        );
                      },
                    ),
                    ProfileMenuWidget(title: "Mode sombre", icon: Icons.mode_night_outlined, onPress: () {}),
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
                            content: const Text("etes-vous sur de vouloir vous déconnecter ?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color(0xFF3E69FE),
                                  ),
                                  elevation: MaterialStateProperty.all<double>(7),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
                                child: const Text(
                                  "NON",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WelcomePage()), //to home page not login
                                  );                                },
                                style: ButtonStyle(
                                  // minimumSize: MaterialStateProperty.all<Size>(Size(330, 52)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.grey.shade400,
                                  ),
                                  elevation: MaterialStateProperty.all<double>(7),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
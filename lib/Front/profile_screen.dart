import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import 'profile_menu.dart';
import 'update_profile_screen.dart';



class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  String tProfile = 'Profile       ';
  String tProfileHeading = 'Bachir Rachad';
  String tProfileSubHeading = 'mr_bachir@esi.dz';
  String tEditProfile = 'Editer le Profile';

  Color tPrimaryColor = Color(0xFF3E69FE); // Use the appropriate color code or define your color
  Color tDarkColor = Colors.black; // Use the appropriate dark color or define your color

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEBEFFF),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFEBEFFF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
    decoration: BoxDecoration(
      color: Color(0xFFEBEFFF),
    ),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 130,
                    height: 130,
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
              Text(tProfileHeading, style: Theme.of(context).textTheme.headline4),
              Text(tProfileSubHeading, style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 50),


              /// -- MENU
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
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
                        Get.defaultDialog(
                          title: "LOGOUT",
                          titleStyle: const TextStyle(fontSize: 20),
                          content: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            child: Text("Are you sure, you want to Logout?"),
                          ),
                          confirm: Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                side: BorderSide.none,
                              ),
                              child: const Text("Yes"),
                            ),
                          ),
                          cancel: OutlinedButton(
                            onPressed: () => Get.back(),
                            child: const Text("No"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

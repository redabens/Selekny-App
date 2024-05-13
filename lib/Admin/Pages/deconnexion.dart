
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Admin/Pages/Signalements/AllSignalements_page.dart';

import '../../Pages/authentification/connexion.dart';

class Deconnecter extends StatefulWidget {

const Deconnecter({Key? key, }) : super(key: key);

@override
_DeconnecterState createState() => _DeconnecterState();
}

class _DeconnecterState extends State<Deconnecter> {
final TextEditingController _commentController = TextEditingController();

@override
void initState() {
super.initState();
}

@override
void dispose() {
_commentController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
final double screenWidth = MediaQuery.of(context).size.width;
final double screenHeight = MediaQuery.of(context).size.height;

return Scaffold(
backgroundColor: Colors.white,
body: GestureDetector(
onTap: () {
Navigator.pop(context); // Return to the previous page
},
child: Stack(
children: [
const AllSignalementsPage(), // Background page
Container(
color: Color.fromRGBO(128, 128, 128, 0.7), // Semi-transparent gray overlay
width: double.infinity,
height: double.infinity,
),
Center(
child: Container(
padding: EdgeInsets.all(screenWidth * 0.08),
width: screenWidth * 0.8,
height: screenHeight *0.25,// Proportional width
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(screenWidth * 0.05),
border: Border.all(color: Colors.grey),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Text(
'êtes vous sur de se déconnecter de l\'application ?',
style: GoogleFonts.poppins(
fontSize: screenWidth * 0.045,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: screenHeight * 0.02),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
GestureDetector(
onTap: () {
  FirebaseAuth.instance.signOut();
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
        const LoginPage()),
  );
},
child: Container(
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(screenWidth * 0.04),
    border:Border.all(color:Color(0xFF3E69FE),width: 2.0 ),
),
padding: EdgeInsets.symmetric(
horizontal: screenWidth * 0.06,
vertical: screenWidth * 0.03,
),
child: Text(
'OUI',
style: GoogleFonts.poppins(
color: Color(0xFF3E69FE),
fontWeight: FontWeight.w600,
fontSize: 14,
),
),
),
),
SizedBox(width: screenWidth * 0.06),
GestureDetector(
onTap: () {
Navigator.pop(context);
},
child: Container(
decoration: BoxDecoration(
color: Color(0xFF3E69FE),
borderRadius: BorderRadius.circular(screenWidth * 0.04),
),
padding: EdgeInsets.symmetric(
horizontal: screenWidth * 0.05,
vertical: screenWidth * 0.03,
),
child: Text(
'NON',
style: GoogleFonts.poppins(
color: Colors.white,
fontWeight: FontWeight.w600,
fontSize: 15,
),
),
),
),
],
),
],
),
),
),
],
),
),
);
}
}


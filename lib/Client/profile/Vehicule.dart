import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


class Vehicule extends StatefulWidget {
  const Vehicule({
    super.key,
  });
  @override
  _VehiculeState createState() => _VehiculeState();
}

class _VehiculeState extends State<Vehicule> {
  late bool vehicule;
  Future<void> getVehiculeStatut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            vehicule = userDoc.get('vehicule');
          });
        } else {
          print("User not found");
        }
      } catch (e) {
        print("Error fetching vehicule status: $e");
      }
    } else {
      print("No user logged in");
    }
    await Future.value(Null);
  }
  @override
  void initState() {
    super.initState();
    getVehiculeStatut();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 350,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.car_crash_outlined,
                size: 20, // You can adjust the size as needed
                color: Colors.blueAccent, // Specify the color if needed
              ),
              const SizedBox(width: 20),
              Text(
                'Statut véhiculé',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width:   130,),

              VehiculeSwitch(vehicule: vehicule,),


            ],
          ),

          // Ajoutez plus de widgets Text ici pour les éléments supplémentaires
        ],
      ),
    );
  }
}





class VehiculeSwitch extends StatefulWidget {
  final bool vehicule ;
  const VehiculeSwitch({
    super.key,
    required this.vehicule,
  });

  @override
  State<VehiculeSwitch> createState() => _VehiculeSwitchState();
}

Future<bool> getVehiculeStatut() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  if (user != null) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        bool vehiculeStatus = userDoc.get('vehicule');
        return vehiculeStatus;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      print("Error fetching vehicule status: $e");
      throw e;
    }
  } else {
    throw Exception("No user logged in");
  }
}

class _VehiculeSwitchState extends State<VehiculeSwitch> {
  late bool _vehiculeActivated;

  Future<void> changeVehicule() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userID = user.uid;
      DocumentReference userRef =
      FirebaseFirestore.instance.collection('users').doc(userID);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        bool currentVehicule = userSnapshot['vehicule'] ?? false;

        await userRef.update({'vehicule': !currentVehicule});
      } else {
        throw Exception('User document not found');
      }
    }

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _vehiculeActivated = widget.vehicule;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _vehiculeActivated = !_vehiculeActivated;
        });
        changeVehicule();
      },
      child: Container(
        width: 48,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _vehiculeActivated ? const Color(0xFF5F9EA0) : const Color(0xFF777777),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: _vehiculeActivated ? 26.0 : 0.0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
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
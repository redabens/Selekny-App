

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/signalement_service.dart';
import 'DetailsSignalement_page.dart';
import 'AllSignalements_page.dart';

class EtesVousSur extends StatefulWidget {
  final String signalementID;
  final String signaleurID;
  final String signalantID;
  final String signaleurName;
  final String signalantName;
  final String signaleurJob;
  final String signalantJob;
  final String date;
  final String heure;
  final String raison;
  final String signaleurUrl;
  final String signalantUrl;
  final int nbsignalement;
  const EtesVousSur({super.key, required this.signalementID,
    required this.signaleurID, required this.signalantID,
    required this.signaleurName, required this.signalantName,
    required this.signaleurJob, required this.signalantJob,
    required this.date, required this.heure,
    required this.raison, required this.signaleurUrl,
    required this.signalantUrl, required this.nbsignalement,});

  @override
  EtesVousSurState createState() => EtesVousSurState();

}

class EtesVousSurState extends State<EtesVousSur> {
  final auth = FirebaseAuth.instance;
  Future<void> blockUser(String uid) async {
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable('blockUser');
    try {
      final result = await callable({'uid': uid}); // Pass the user ID
      print('User blocked: ${result.data}'); // Handle success message (optional)
    } catch (error) {
      print('Error blocking user: $error'); // Handle errors
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
        [
          DetailsSignalement(signalementID:widget.signalementID,signaleurID: widget.signaleurID,
            signalantID: widget.signalantID,signaleurName: widget.signaleurName,
            signalantName: widget.signalantName, signaleurJob: widget.signaleurJob,
            signalantJob: widget.signalantJob, date: widget.date, heure: widget.heure,
            raison: widget.raison,signaleurUrl: widget.signaleurUrl,
            signalantUrl: widget.signalantUrl,nbsignalement: widget.nbsignalement,),
          Container(
            color: const Color.fromRGBO(128,128,128,0.7),
            width: double.infinity,
            height: double.infinity,
          ),

          Center(
            child: Container(
              height: 180,
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFC4C4C4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MianAxisSize.min,
                children:
                [
                  RichText(
                    text: TextSpan(children: <TextSpan>[

                      TextSpan( text:'Cet utilisateur sera empêché d\'utiliser l\'application'  , style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),),


                    ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan( text:'Êtes-vous sûr de cette action ?'  , style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),),

                    ],
                    ),
                  ),
                  const SizedBox(height:25),
                  Buttons(userid: widget.signalantID, signalementID: widget.signalementID,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String userid;
  final String signalementID;
  const Buttons({super.key, required this.userid, required this.signalementID});
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
        [
          Oui(userid: userid, signalementID: signalementID,),
          const Non(),
        ],
      ),
    );

  }
}
class Oui extends StatelessWidget {
  final String userid;
  final String signalementID;
  Oui({super.key, required this.userid, required this.signalementID});
  final SignalementsService _SignalementService = SignalementsService();
  // final VoidCallback onPressed;
  void changeBloque(String userid){
    final userref = FirebaseFirestore.instance.collection('users').doc(userid);
    try {
      userref.update({'bloque': true});
    }catch(e){
      print('$e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: ()  {
          changeBloque(userid);
          _SignalementService.deleteSignalement(signalementID);
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AllSignalementsPage()//lazm le signalement se supprime et le statut bloque vrai
          ),
        );
        },
        child: Center(
          child:Text(
            'Oui',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

        ),
      ),
    );

  }
}
class Non extends StatelessWidget {
  const Non({super.key});



  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child:Text(
            'Non',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

        ),
      ),
    );

  }
}

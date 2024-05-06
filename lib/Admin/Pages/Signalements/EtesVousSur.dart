

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DetailsSignalement_page.dart';
import 'AllSignalements_page.dart';

class EtesVousSur extends StatefulWidget {
  const EtesVousSur({super.key});

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
          const DetailsSignalement(signalementID:'////',signaleurID: '///',signalantID: '////',signaleurName: '//////', signalantName: 'fdfdfd', signaleurJob: '///////', signalantJob: '/////', date: '/////', heure: '/////', raison: '/////',signaleurUrl: '///',signalantUrl: '///',nbsignalement: 0,),
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
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFC4C4C4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MianAxisSize.min,
                children:
                [
                  RichText(
                    text: TextSpan(children: <TextSpan>[

                      TextSpan( text:'L\'utilisateur sera supprimé definitivement de l’application.'  , style: GoogleFonts.poppins(
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
                  const Buttons(),
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
  const Buttons({super.key});
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: 35,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
        [
          Oui(),
          Non(),
        ],
      ),
    );

  }
}
class Oui extends StatelessWidget {
  const Oui({super.key});
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFF3E69FE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllSignalementsPage()//lazm le compte se supprime
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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsSignalement(signalementID:'////',signaleurID: '///',signalantID: '////',signaleurName: '//////', signalantName: 'fdfdfd', signaleurJob: '///////', signalantJob: '/////', date: '/////', heure: '/////', raison: '/////',signaleurUrl: '///',signalantUrl: '//',nbsignalement: 0,)//lazm la page de bloquer ici

          ),
        ),
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

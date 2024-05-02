
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DetailsSignalement_page.dart';
import 'AllSignalements_page.dart';

class EtesVousSur extends StatefulWidget {
  @override
  EtesVousSurState createState() => EtesVousSurState();

}

class EtesVousSurState extends State<EtesVousSur> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
        [
          DetailsSignalement(signalementID:'////',signaleurID: '///',signalantID: '////',signaleurName: '//////', signalantName: 'fdfdfd', signaleurJob: '///////', signalantJob: '/////', date: '/////', heure: '/////', raison: '/////',signaleurUrl: '///',signalantUrl: '///',),
          Container(
            color: Color.fromRGBO(128,128,128,0.7),
            width: double.infinity,
            height: double.infinity,
          ),

          Center(
            child: Container(
              height: 180,
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFC4C4C4)),
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
                  SizedBox(height: 5),
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
                  SizedBox(height:25),
                  Buttons(),
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
          Oui(),
          Non(),
        ],
      ),
    );

  }
}
class Oui extends StatelessWidget {


  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFF3E69FE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllSignalementsPage()//lazm le compte se supprime
          ),
        ),
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


  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsSignalement(signalementID:'////',signaleurID: '///',signalantID: '////',signaleurName: '//////', signalantName: 'fdfdfd', signaleurJob: '///////', signalantJob: '/////', date: '/////', heure: '/////', raison: '/////',signaleurUrl: '///',signalantUrl: '//',)//lazm la page de bloquer ici

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
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reda/Artisan/Pages/Notifications/NotifDemande.dart';

class Jobsandcomments extends StatelessWidget {
  const Jobsandcomments({super.key});

  @override

  Widget build(BuildContext context) {
    return Container(
      height: 80,

      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // Align children to the start
        children: [
          Jobs(),
          Comments(),
        ],
      ),

    );

  }
}



class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
      ),



      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
        [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                const SizedBox(width: 5,),
                Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child:Text(

                    '2',//compteur qui compte le nombre de jobs a faire auj
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ]
          ),
          const SizedBox(height: 5,),
          const Phrase(),

        ],
      ),



    );
  }

}


class Phrase extends StatelessWidget {
  const Phrase({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        children:
        [
          const SizedBox(width: 5,),
          Container(
            height: 15,
            width: 15,
            child: const ImageIcon(
              AssetImage('assets/task.png'),
            ),
          ),
          const SizedBox(width: 3,),
          Text(
            'jobs à faire aujourd\'hui',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,

            ),
          ),
        ],
      ),


    );
  }
}

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        child: Column(
            children:
            [
              const SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  const SizedBox(width: 5,),
                  Container(
                    height: 20,
                    width:20,
                    child: const ImageIcon(
                      AssetImage('assets/comments.png'),

                    ),

                  ),
                ],
              ),
              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                [

                  Container(

                    child:Text(
                      'mes commentaires', //compteur qui compte le nombre de jobs a faire auj
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  Container(
                    height: 20,
                    width: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotifDemande()),
                        );
                      },
                      child:const ImageIcon(
                        AssetImage('assets/forward.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ),

      ),
    );
  }

}
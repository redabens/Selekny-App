import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
=======
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
import 'AllSignalements_page.dart';
import 'EtesVousSur.dart';
import 'package:reda/Admin/components/GestionsUsers/gestionUsers_container.dart';
import 'package:reda/Admin/Services/signalement_service.dart';

class DetailsSignalement extends StatefulWidget {
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

  const DetailsSignalement({
<<<<<<< HEAD
    Key? key,
=======
    super.key,
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
    required this.signalementID,
    required this.signaleurID,
    required this.signalantID,
    required this.signaleurName,
    required this.signalantName,
    required this.signaleurJob,
    required this.signalantJob,
    required this.date,
    required this.heure,
    required this.raison,
    required this.signaleurUrl,
    required this.signalantUrl
<<<<<<< HEAD
  }) : super(key: key);
=======
  });
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b


  @override
  _DetailsSignalementState createState() => _DetailsSignalementState();
}

class _DetailsSignalementState extends State<DetailsSignalement> {
<<<<<<< HEAD
  int _currentIndex = 0;
  SignalementsService _SignalementService = SignalementsService();
=======
  final SignalementsService _SignalementService = SignalementsService();
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
<<<<<<< HEAD
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 15),
=======
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 15),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  // SignalerPar
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Signalement effectué par :',
                          style: GoogleFonts.poppins(
<<<<<<< HEAD
                            color: Color(0xFF685D5D),
=======
                            color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 5),
=======
                        const SizedBox(height: 5),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                        DetGestionUsers(
                          userName: widget.signaleurName,
                          job: widget.signaleurJob,
                          profileImage: widget.signaleurUrl,
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: 25),
=======
                  const SizedBox(height: 25),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  // UserSignaler
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'L\'utilisateur signalé est :',
                          style: GoogleFonts.poppins(
<<<<<<< HEAD
                            color: Color(0xFF685D5D),
=======
                            color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 5),
=======
                        const SizedBox(height: 5),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                        DetGestionUsers(
                          userName: widget.signalantName,
                          job: widget.signalantJob,
                          profileImage: widget.signalantUrl,
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: 25),
=======
                  const SizedBox(height: 25),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  // Motif
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Motif du signalement :',
                          style: GoogleFonts.poppins(
<<<<<<< HEAD
                            color: Color(0xFF685D5D),
=======
                            color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Color(0xFFC4C4C4),
=======
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFC4C4C4),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                              width: 2.0,
                            ),
                          ),
                          child: Text(
                            widget.raison,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: 30),
=======
                  const SizedBox(height: 30),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  // Date
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date du signalement :',
                          style: GoogleFonts.poppins(
<<<<<<< HEAD
                            color: Color(0xFF685D5D),
=======
                            color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
<<<<<<< HEAD
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Text(
                              widget.date,
                              style: GoogleFonts.poppins(
                                color: Color(0xFF685D5D),
=======
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              widget.date,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
<<<<<<< HEAD
                            SizedBox(width: 10),
                            Text(
                              'à 18:17',
                              style: GoogleFonts.poppins(
                                color: Color(0xFF685D5D),
=======
                            const SizedBox(width: 10),
                            Text(
                              'à 18:17',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF685D5D),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: 15),
=======
                  const SizedBox(height: 15),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Ignorer Button
                        GestureDetector(
                          onTap: () async{
                            _SignalementService.deleteSignalement(widget.signalementID);
<<<<<<< HEAD
                            await Future.delayed(Duration(milliseconds: 300));
=======
                            await Future.delayed(const Duration(milliseconds: 300));
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllSignalementsPage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.41,
<<<<<<< HEAD
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFFC4C4C4),
=======
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC4C4C4),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Ignorer',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Bloquer Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EtesVousSur()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
<<<<<<< HEAD
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF0000),
=======
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF0000),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Bloquer',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
<<<<<<< HEAD
  Size get preferredSize => Size.fromHeight(70);
=======
  Size get preferredSize => const Size.fromHeight(70);
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
<<<<<<< HEAD
                  color: Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
=======
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Icon(
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0xFF33363F),
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllSignalementsPage()),
                    );
                  },
                ),
              ),
<<<<<<< HEAD
              SizedBox(width: 40),
=======
              const SizedBox(width: 40),
>>>>>>> 025829b883452b8e096dc1e25d03a2a53f499a4b
              Center(
                child: Text(
                  'Détails du signalement',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

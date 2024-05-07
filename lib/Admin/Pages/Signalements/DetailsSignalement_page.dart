
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final int nbsignalement;

  const DetailsSignalement({
    super.key,
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
    required this.signalantUrl,
    required this.nbsignalement
  });


  @override
  _DetailsSignalementState createState() => _DetailsSignalementState();
}

class _DetailsSignalementState extends State<DetailsSignalement> {
  final SignalementsService _SignalementService = SignalementsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 15),
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
                            color: const Color(0xFF685D5D),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        DetGestionUsers(
                          userName: widget.signaleurName,
                          job: widget.signaleurJob,
                          profileImage: widget.signaleurUrl,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // UserSignaler
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'L\'utilisateur signalé est :',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF685D5D),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        DetGestionUsers(
                          userName: widget.signalantName,
                          job: widget.signalantJob,
                          profileImage: widget.signalantUrl,
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    child: Text(
                      'Cet utilisateur a été signalé ${widget.nbsignalement} fois.',  // Utilisation du paramètre
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

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
                            color: const Color(0xFF685D5D),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFC4C4C4),
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
                  const SizedBox(height: 30),
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
                            color: const Color(0xFF685D5D),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Text(
                              widget.date,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF685D5D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.heure,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF685D5D),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Ignorer Button
                        GestureDetector(
                          onTap: () async{
                            await  _SignalementService.deleteSignalement(widget.signalementID);
                            // await _SignalementService.incrementSignalement(widget.signalantID);
                            await Future.delayed(const Duration(milliseconds: 300));
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AllSignalementsPage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.41,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC4C4C4),
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
                              MaterialPageRoute(builder: (context) => EtesVousSur(signalementID:widget.signalementID,signaleurID: widget.signaleurID,
                                signalantID: widget.signalantID,signaleurName: widget.signaleurName,
                                signalantName: widget.signalantName, signaleurJob: widget.signaleurJob,
                                signalantJob: widget.signalantJob, date: widget.date, heure: widget.heure,
                                raison: widget.raison,signaleurUrl: widget.signaleurUrl,
                                signalantUrl: widget.signalantUrl,nbsignalement: widget.nbsignalement,)),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF0000),
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
  Size get preferredSize => const Size.fromHeight(70);

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
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: const Icon(
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
              const SizedBox(width: 40),
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

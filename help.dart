import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aide', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On est là pour vous aider',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dites-nous votre problème afin que nous puissions vous aider',
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Questions fréquentes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildQuestionItem(
                    context,
                    'Comment devenir prestataire?',
                    Icons.search,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageDevenirPrestataire()),
                      );
                    },
                  ),
                  _buildQuestionItem(
                    context,
                    'Un service n\'est pas disponible?',
                    Icons.search,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageServiceIndisponible()),
                      );
                    },
                  ),
                  _buildQuestionItem(
                    context,
                    'Un prestataire a annulé un rendez-vous?',
                    Icons.search,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageAnnulationRendezVous()),
                      );
                    },
                  ),
                  _buildQuestionItem(
                    context,
                    'Comment effectuer le paiement d\'un artisan?',
                    Icons.search,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentArtisan()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Vous n\'avez pas trouvé votre réponse?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 190.0),
                  child: TextButton(
                    onPressed: () {
                      // Naviguer vers la page de contact-nous
                    },
                    child: Text(
                      'Contactez-nous',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem(BuildContext context, String question, IconData icon, Function() onPressed) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          question,
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
        onTap: onPressed,
      ),
    );
  }
}

class PageDevenirPrestataire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment devenir prestataire?'),
      ),
      body: Center(
        child: Text('Contenu de la page "Comment devenir prestataire?"'),
      ),
    );
  }
}

class PageServiceIndisponible extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Un service n\'est pas disponible?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Vous pouvez vérifier la liste de tous les domaines à partir de :\n'
                    '\n'
                    '- Accédez à la page d\'accueil dans la barre de navigation\n'
                    '- Sélectionnez dans la partie "Service à domicile" l\'option "Voir tout"\n'
                    '\n'
                    'Si vous n\'avez pas trouvé le service ou le domaine que vous recherchez, veuillez envoyer un message à l\'administration de "Selekny" pour leur suggérer de l\'ajouter s\'il y a des opportunités.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageAnnulationRendezVous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Un prestataire a annulé un rendez-vous?'),
      ),
      body:
    Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
    children: [
    Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 2,
    blurRadius: 5,
    offset: Offset(0, 3),
    ),
    ],
    ),
        child: Text('Si un artisan à annuler un rendez vous sans justification vous pouvez le signaler .\n'
            '\n'
            'Comment signaler un artisan ?\n'
            '\n'
            'Pour signaler un artisan :\n'
            '-Acceder au profil de l\'artisan concerné \n'
            '-Cliquez sur le boutton signaler \n'
            '-Justifier votre signalement et cliquez sur envoyer.\n ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

    ),
    ],
    ),
    ),
    );
  }
}

class PaymentArtisan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment effectuer le paiement d\'un artisan?'),
      ),
      body:     Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text('Pour le payement , il se feras main à main en cas de problème veuillez signalé l\'artisan en mentionnant que c\'est un problème de payement ou veuillez contacter l\'administration "selekny"\n'
                  '\n'
              ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            ),
          ],
        ),
      ),
    );
  }
}
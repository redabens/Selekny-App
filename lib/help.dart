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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.black), // icône de recherche en noir
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Exemple: Comment faire une demande',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recherches fréquentes:',
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
                    Icons.search, // icône de recherche en noir
                        () {
                      // Naviguer vers la page correspondante
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageDevenirPrestataire()),
                      );
                    },
                  ),
                  _buildQuestionItem(
                    context,
                    'Un service n\'est pas disponible?',
                    Icons.search, // icône de recherche en noir
                        () {
                      // Naviguer vers la page correspondante
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageServiceIndisponible()),
                      );
                    },
                  ),
                  _buildQuestionItem(
                    context,
                    'Un prestataire a annulé un rendez-vous?',
                    Icons.search, // icône de recherche en noir
                        () {
                      // Naviguer vers la page correspondante
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageAnnulationRendezVous()),
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
                  padding: const EdgeInsets.only(left:190.0), // Ajustement de la position du texte "Contactez-nous"
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
    return ListTile(
      leading: Icon(icon, color: Colors.black), // icône de recherche en noir
      title: Text(
        question,
        style: TextStyle(color: Colors.blue, fontSize: 14),
      ),
      onTap: onPressed,
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
      body: Center(
        child: Text('Contenu de la page "Un service n\'est pas disponible?"'),
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
      body: Center(
        child: Text('Contenu de la page "Un prestataire a annulé un rendez-vous?"'),
      ),
    );
  }
}

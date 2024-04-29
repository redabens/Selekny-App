import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> geocode(String address) async {
  // 1. Construire l'URL de la requête
  const apiKey = 'AIzaSyAqfX5dUIIq6rPwNa9J7_yAUPeyf_-xjEQ'; // Remplacez par votre clé API google map

  const baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json?address=';
  final url = Uri.parse('$baseUrl${Uri.encodeQueryComponent(address)}&key=$apiKey');
  print(Uri.encodeQueryComponent(address));
  print(url);
  // 2. Envoyer la requête GET
  final response = await http.get(url);

  // 3. Gérer la réponse
  if (response.statusCode == 200) {
    final results = jsonDecode(response.body);
    // Vérifier si on a au moins un résultat
    if (results['results'].isNotEmpty) {
      // Extraire les informations de localisation du premier résultat
      final firstResult = results['results'][0];
      return {
        'latitude': firstResult['geometry']['location']['lat'],
        'longitude': firstResult['geometry']['location']['lng'],
        // Extraire d'autres informations si nécessaire (adresse formatée, etc.)
      };
    } else {
      throw Exception('Aucun résultat trouvé pour cette adresse');
    }
  } else {
    throw Exception('Erreur lors de la récupération des données : ${response.statusCode}');
  }
}
// test code
/*
try {
    final results1 = await geocode('National Museum of the Bardo, Algiers, Algeria');
    final double latitude1 = results1['latitude'];
    final double longitude1 = results1['longitude'];
    print('Latitude: $latitude1, Longitude: $longitude1');
    final results2 = await geocode('Great Mosque of Constantine, Constantine, Algeria');
    final double latitude2 = results2['latitude'];
    final double longitude2 = results2['longitude'];
    print('Latitude: $latitude2, Longitude: $longitude2');
  } on Exception catch (e) {
    print('Une erreur est survenue : $e');
  }
*/
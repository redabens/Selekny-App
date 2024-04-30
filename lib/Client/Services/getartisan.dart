import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getArtisan(String artisanId) async {
  // Get the document snapshot for the artisan
  final docRef = FirebaseFirestore.instance.collection('users').doc(artisanId);
  final snapshot = await docRef.get();

  // Check if the document exists
  if (snapshot.exists) {
    return snapshot;
  } else {
    // Handle the case where the document doesn't exist (optional)
    print("Artisan document not found for ID: $artisanId");
    return Future.error("Artisan document not found"); // Or throw an exception
  }
}
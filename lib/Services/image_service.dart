import 'package:firebase_storage/firebase_storage.dart';


Future<String> getImageUrl(String imagePath) async {
  try {
    final reference = FirebaseStorage.instance.ref().child(imagePath);
    final url = await reference.getDownloadURL();
    return url;
  } catch (error) {
    print('Error getting image URL: $error');
    return ''; // Or return a default placeholder URL if desired
  }
}
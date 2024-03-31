import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';


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
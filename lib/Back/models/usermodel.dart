import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String nom;
  final String numTel;
  final String adresse;
  final String email;
  final String motDePasse;
  final String role;
  final String pathImage;

  UserModel(
      {required this.id,
      required this.nom,
      required this.numTel,
      required this.adresse,
      required this.email,
      required this.motDePasse,
      required this.role,
      required this.pathImage});

  UserModel.empty()
      : id = '',
        nom = '',
        numTel = '',
        adresse = '',
        email = '',
        motDePasse = '',
        role = '',
        pathImage = '';
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? '',
        nom: json['nom'] ?? '',
        numTel: json['numTel'] ?? '',
        adresse: json['adresse'] ?? '',
        email: json['email'] ?? '',
        motDePasse: json['motDePasse'] ?? '',
        role: json['role'] ?? '',
        pathImage: json['pathImage'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'numTel': numTel,
      'adresse': adresse,
      'email': email,
      'motDePasse': motDePasse,
      'role': role,
      'pathImage': pathImage
    };
  }

  UserModel copyWith(
      {String? nom,
      String? numTel,
      String? adresse,
      String? email,
      String? motDePasse,
      String? role,
      String? pathImage}) {
    return UserModel(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        numTel: numTel ?? this.numTel,
        adresse: adresse ?? this.adresse,
        email: email ?? this.email,
        motDePasse: motDePasse ?? this.motDePasse,
        role: role ?? this.role,
        pathImage: pathImage ?? this.pathImage);
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        nom: data['nom'],
        numTel: data['numTel'],
        adresse: data['adresse'],
        email: data['email'],
        motDePasse: data['motdepasse'],
        role: data['role'],
        pathImage: data['pathImage']);
  }
}

class ClientModel extends UserModel {
  ClientModel({
    required String id,
    required String nom,
    required String numTel,
    required String adresse,
    required String email,
    required String motDePasse,
    required String pathImage,
  }) : super(
          id: id,
          nom: nom,
          numTel: numTel,
          adresse: adresse,
          email: email,
          motDePasse: motDePasse,
          role: 'client',
          pathImage:
              pathImage, // Passer pathImage au constructeur de la classe mère
        );
}

class ArtisanModel extends UserModel {
  final bool statut;
  final double note;
  final List<String> commentaires;

  ArtisanModel({
    required super.id,
    required super.nom,
    required super.numTel,
    required super.adresse,
    required super.email,
    required super.motDePasse,
    required super.pathImage,
    required this.statut,
    required this.note,
    required this.commentaires,
  }) : super(
          role: 'artisan',
        );
}

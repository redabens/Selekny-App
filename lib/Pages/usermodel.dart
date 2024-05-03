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
  final double latitude;
  final double longitude;
  final bool vehicule;
  final int nbsignalement;
  final String token;

  UserModel({
    required this.id,
    required this.nom,
    required this.numTel,
    required this.adresse,
    required this.email,
    required this.motDePasse,
    required this.role,
    required this.pathImage,
    required this.latitude,
    required this.longitude,
    required this.vehicule,
    required this.nbsignalement,
    required this.token,
  });

  UserModel.empty()
      : id = '',
        nom = '',
        numTel = '',
        adresse = '',
        email = '',
        motDePasse = '',
        role = '',
        pathImage = '',
        latitude = 0,
        longitude = 0,
        vehicule = false,
        nbsignalement = 0,
        token = '';
  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      numTel: json['numTel'] ?? '',
      adresse: json['adresse'] ?? '',
      email: json['email'] ?? '',
      motDePasse: json['motDePasse'] ?? '',
      role: json['role'] ?? '',
      pathImage: json['pathImage'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      vehicule: json['vehicule'],
      nbsignalement: json['nbsignalement'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'numTel': numTel,
      'adresse': adresse,
      'email': email,
      'motDePasse': motDePasse,
      'role': role,
      'pathImage': pathImage,
      'latitude': latitude,
      'longitude': longitude,
      'vehicule': vehicule,
      'token': token
    };
  }

  UserModel copyWith(
      {String? nom,
      String? numTel,
      String? adresse,
      String? email,
      String? motDePasse,
      String? role,
      String? pathImage,
      double? latitude,
      double? longitude,
      bool? vehicule,
      int? nbsignalement,
      String? token}) {
    return UserModel(
      id: id ?? id,
      nom: nom ?? this.nom,
      numTel: numTel ?? this.numTel,
      adresse: adresse ?? this.adresse,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      role: role ?? this.role,
      pathImage: pathImage ?? this.pathImage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      vehicule: vehicule ?? this.vehicule,
      nbsignalement: nbsignalement ?? this.nbsignalement,
      token: token ?? this.token,
    );
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
      pathImage: data['pathImage'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      vehicule: data['vehicule'],
      nbsignalement: data['nbsignalement'],
      token: data['token'],
    );
  }
}

class ClientModel extends UserModel {
  ClientModel(
      {required super.id,
      required super.nom,
      required super.numTel,
      required super.adresse,
      required super.email,
      required super.motDePasse,
      required super.pathImage,
      required super.longitude,
      required super.latitude,
      required super.vehicule,
      required super.nbsignalement,
      required super.token})
      : super(role: 'client');
}

class ArtisanModel extends UserModel {
  final bool statut;
  final String domaine;
  final List<String> prestations;
  int rating = 4;
  int workcount = 0;

  ArtisanModel(
      {required super.id,
      required super.nom,
      required super.numTel,
      required super.adresse,
      required super.email,
      required super.motDePasse,
      required super.pathImage,
      required this.statut,
      required super.latitude,
      required super.longitude,
      required this.domaine,
      required super.vehicule,
      required super.nbsignalement,
      required super.token,
      required this.rating,
      required this.workcount,
      required this.prestations})
      : super(role: 'artisan');

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['statut'] = statut;
    data['domaine'] = domaine;
    data['rating'] = rating;
    data['workcount'] = workcount;
    data['prestations'] = prestations;
    return data;
  }

  static ArtisanModel fromJson(Map<String, dynamic> json) {
    return ArtisanModel(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      numTel: json['numTel'] ?? '',
      adresse: json['adresse'] ?? '',
      email: json['email'] ?? '',
      motDePasse: json['motDePasse'] ?? '',
      pathImage: json['pathImage'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      statut: json['statut'],
      domaine: json['domaine'],
      prestations: json['prestations'],
      rating: json['rating'],
      vehicule: json['vehicule'],
      nbsignalement: json['nbsignalement'],
      token: json['token'],
      workcount: json['workcount'],
    );
  }
}

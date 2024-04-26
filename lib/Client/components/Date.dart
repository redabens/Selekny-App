import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

class Date {
  late int _jour;
  late String _mois;
  late int _annee;

  Date(){
    DateTime now = DateTime.now();

// Extract the day of the month (integer)
    int day = now.day;

    _jour = day;
    final formatter = DateFormat('MMMM'); // Change 'MMMM' to 'MMM' for abbreviation
    String monthString = formatter.format(now);

    _mois = monthString;
    int year = now.year;

    _annee = year;
  }

  // Getters
  int getjour() => _jour;
  String getmois() => _mois;
  int getannee()=> _annee;

  // Setters
  void setjour(int jour) {
    if (jour < 1 || jour > 31) {
      throw ArgumentError("Le jour doit être compris entre 1 et 31");
    }
    _jour = jour;
  }

  void setmois(String mois) {
    _mois = mois;
  }

  void setannee(int annee) {
    _annee = annee;
  }
  void setjournow(){
    DateTime now = DateTime.now();

// Extract the day of the month (integer)
    int day = now.day;

    _jour = day;
  }
  void setmoisnow(){
    DateTime now = DateTime.now();

    // Format the month as a string (full month name)
    final formatter = DateFormat('MMMM'); // Change 'MMMM' to 'MMM' for abbreviation
    String monthString = formatter.format(now);

    _mois = monthString;
  }
  void setanneenow(){
    DateTime now = DateTime.now();

    int year = now.year;

    _annee = year;
  }
  // Méthodes
  @override
  String toString() {
    return "$_jour $_mois $_annee";
  }

  bool isValide() {
    // TODO: Implémenter la logique de validation de la date
    return true;
  }
}
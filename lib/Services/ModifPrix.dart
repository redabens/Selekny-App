import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ModifPrixService extends ChangeNotifier {
  bool isSpecialDate() {
    // Obtenir la date d'aujourd'hui
    DateTime now = DateTime.now();
    List<DateTime> specialDates = [
      DateTime(2024, 6, 16),
      DateTime(2024, 6, 17),
      DateTime(2024, 6, 18),
      DateTime(2024, 7, 7),
      DateTime(2024, 7, 8),
      DateTime(2024, 7, 9),
      DateTime(2024, 7, 16),
      DateTime(2024, 7, 17),
      DateTime(2024, 7, 18),
      DateTime(2024, 9, 15),
      DateTime(2024, 9, 16),
      DateTime(2024, 9, 17),
      DateTime(2024, 12, 31),
      DateTime(2025, 1, 1),
      DateTime(2025, 3, 30),
      DateTime(2025, 3, 31),
      DateTime(2025, 6, 6),
      DateTime(2025, 6, 7),
      DateTime(2025, 6, 8),
      DateTime(2025, 7, 5),
      DateTime(2025, 7, 6),
      DateTime(2025, 7, 7),
      DateTime(2025, 9, 4),
      DateTime(2025, 9, 5),
      DateTime(2025, 9, 6),
      DateTime(2025, 3, 19),
      DateTime(2025, 3, 20),
      DateTime(2026, 5, 25),
      DateTime(2026, 5, 26),
      DateTime(2026, 5, 27),
      DateTime(2026, 6, 16),
      DateTime(2026, 6, 17),
      DateTime(2026, 8, 25),
      DateTime(2026, 8, 26),
    ];

    // Vérifier si la date d'aujourd'hui est présente dans la liste des dates spéciales
    return specialDates.contains(DateTime(now.year, now.month, now.day));
  }
  bool isWeekend() {
    // Obtenir la date d'aujourd'hui
    DateTime now = DateTime.now();

    // Obtenir le jour de la semaine (1 = lundi, 7 = dimanche)
    int weekday = now.weekday;

    // Vérifier si c'est vendredi (weekday = 5) ou samedi (weekday = 6)
    if (weekday == DateTime.friday || weekday == DateTime.saturday) {
      return true; // C'est vendredi ou samedi
    } else {
      return false; // Ce n'est ni vendredi ni samedi
    }
  }
  Future<String> getPrixPrestation(String domaineId, String prestationId) async{
    final firestore = FirebaseFirestore.instance;
    final prestationsSnapshot = await FirebaseFirestore.instance
        .collection('Domaine')
        .doc(domaineId)
        .collection('Prestations')
        .doc(prestationId)
        .get();
    Map<String,dynamic> data = prestationsSnapshot.data() as Map<String, dynamic>;
    final int prixmin = data['prixmin'];
    print(prixmin.toString());
    final int prixmax = data['prixmax'];
    final String unite = data['unite'];
    if (isSpecialDate()) {
      double moy = (((prixmax + prixmin) / 2) * 0.4);
      int prixMoyen = moy.toInt(); // Round down to nearest integer
      return "${prixmin + prixMoyen}-${prixmax + prixMoyen} $unite";
    } else if (isWeekend()) {
      double moy = (((prixmax + prixmin) / 2) * 0.2);
      int prixMoyenWeekend = moy.toInt(); // Round down to nearest integer
      return "${prixmin + prixMoyenWeekend}-${prixmax + prixMoyenWeekend} $unite";
    }
      else{
        return "$prixmin-$prixmax $unite";

      }
  }
}
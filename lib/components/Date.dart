class Date {
  late int _jour;
  late String _mois;
  late int _annee;

  Date(int jour, String mois, int annee) {
    _jour = jour;
    _mois = mois;
    _annee = annee;
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
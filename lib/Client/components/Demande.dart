
class Demande {
  late String id_Client;
  late String id_Artisan;
  late String id_Prestation;
  late bool urgence;
  late String date_debut;
  late String date_fin;
  late String heure_debut;
  late String heure_fin;
  Demande({
    required this.id_Client,
    required this.id_Artisan,
    required this.id_Prestation,
    required this.urgence,
    required this.date_debut,
    required this.date_fin,
    required this.heure_debut,
    required this.heure_fin,
  });

Map<String, dynamic> toMap(){
  return{
    'id_Client': id_Client,
    'id_Artisan': id_Artisan,
    'id_Prestation': id_Prestation,
    'urgence': urgence,
    'date_debut': date_debut,
    'date_fin':  date_fin,
    'heure_debut': heure_debut,
    'heure_fin': heure_fin,
  };
}
  void setIdClient(String idClient){
    id_Client = idClient;
  }
  void setIdArtisan(String idArtisan){
    id_Artisan = idArtisan;
  }
  void setIdPrestation(String idPrestation){
    id_Prestation = idPrestation;
  }
  void setUrgence(bool urgence){
    this.urgence =urgence;
  }
  void setDateDebut(String dateDebut) {
    date_debut = dateDebut;
  }

  void setDateFin(String dateFin) {
    date_fin = dateFin;
  }

  void setHeureDebut(String heureDebut) {
    heure_debut = heureDebut;
  }

  void setHeureFin(String heureFin) {
    heure_fin = heureFin;
  }
}
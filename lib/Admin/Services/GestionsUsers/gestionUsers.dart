class GestionUsers{
  final String userID;
  final String job;

  GestionUsers({
    required this.userID,
    required this.job,
  });

  Map<String, dynamic> toMap(){
    return{
      'userID':userID,
      'job':job,
    };
  }
}
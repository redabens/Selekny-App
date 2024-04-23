import "package:cloud_firestore/cloud_firestore.dart";
import 'package:get/get.dart';
import 'package:reda/Pages/usermodel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final db = FirebaseFirestore.instance;
  Future<void> createUser(UserModel user) async {
    await db.collection("users").add(user
        .toJson()); // ajouter  .whenComplete pour dire a l utilisateur que son compte a ete cree  ou une erreur;
  }

  Future<UserModel> getUserDetails(String email) async {
    print("Fetching user details for email: $email");
    Map<String, dynamic> userData = {};
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      userData = querySnapshot.docs.first.data();
    } else {
      print('No user found for email: $email');
    }
    print("User data fetched: $userData");
    UserModel userModel = UserModel.fromJson(userData);
    print(userModel);
    return userModel;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await db.collection("users").get();
    final userdata =
    snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<void> removeUser(UserModel user) async {
    try {
      await db.collection("users").doc(user.id).delete();
      print("Utilisateur supprime avec succes");
    } catch (e) {
      print('Erreur lors de la suppression de l\'utilisateur $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    print("je suis dans update user");
    print(user.toJson());
    print("user id : ${user.id}");
    await db.collection("users").doc(user.id).update(user.toJson());
  }
}

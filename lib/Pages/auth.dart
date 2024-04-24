import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? user = FirebaseAuth.instance.currentUser;

  Future<User?> signUpwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        try {
          await user.sendEmailVerification();
          print("Email sent successfully to : " + email);
        } catch (e) {
          print("Some error occured in sending email verification");
        }
      }

      return credential.user;
    } catch (e) {
      print("Somme error occured in sign up$e");
    }
    return null;
  }

  Future<User?> signInwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Somme error occured in sign in");
      print(e.toString());
      rethrow;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }

  Future<void> sendEmailVerification() async {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print("Erreur dans la verification du mail$e");
      //afficher une erreur a l utilisateur
    }
  }

  static Future saveUserToken(String token) async {
    Map<String, dynamic> data = {"email": user!.email, "token": token};
    try {
      await FirebaseFirestore.instance
          .collection("userToken")
          .doc(user!.email)
          .set(data);
      print("Token added");
    } catch (e) {
      print("There is an error in saving user's token");
      print(e.toString());
    }
  }
}
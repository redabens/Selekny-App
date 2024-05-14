import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? user = FirebaseAuth.instance.currentUser;

  Future<bool> checkEmailExists(String email) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final query = usersCollection.where('email', isEqualTo: email).limit(1);

    final querySnapshot = await query.get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> verifyPassword(String email, String password) async {
    try {
      // Authentification de l'utilisateur avec l'email et le mot de passe
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Si l'authentification réussit, le mot de passe est correct
      return true;
    } on FirebaseAuthException catch (e) {
      // Si une erreur FirebaseAuthException est levée, le mot de passe est incorrect
      print('Erreur d\'authentification : ${e.code}');
      return false;
    }
  }

  Future<User?> signUpwithEmailAndPassword(
      String email, String password) async {
    try {
      if (!email.contains('@gmail.com')) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'L\'email doit être un email Gmail.',
        );
      }

      // Vérification du mot de passe
      if (password.length < 8) {
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'Le mot de passe doit contenir au moins 8 caractères.',
        );
      }
      bool emailExists = await checkEmailExists(email);
      if (emailExists) {
        // Email already exists, show error message
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'L\'email exist deja essayez un autre.',
        );
      }

      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        try {
          await user.sendEmailVerification();
          print("Email sent successfully to : $email");
        } catch (e) {
          print("Some error occured in sending email verification");
        }
      }

      return credential.user;
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message ?? "un error occured",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red);
      return null;
    }
  }

  Future<String> getPasswordFromFirestore(String email) async {
    Map<String, dynamic> userData = {};
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      userData = querySnapshot.docs.first.data();
    } else {
      print('No user found for email: $email');
      return '';
    }
    print("Password recupere de firestore : ${userData['motDePasse']} ");
    return userData['motDePasse'];
  }

  Future<void> setPasswordInFirestore(String email, String password) async {
    print("Dans set nouveau pwd dans firestore");

    try {
      final userQuery = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        await userDoc.reference.update({'motDePasse': password});
        print("New password entered: $password");
      } else {
        print("Aucun utilisateur trouvé avec l'email: $email");
      }
    } catch (e) {
      print("Erreur lors de la mise à jour du mot de passe : $e");
    }
  }

  Future<User?> signInwithEmailAndPassword(
      String email, String password) async {
    bool emailExists = await checkEmailExists(email);
    String mdp = await getPasswordFromFirestore(email);
    if (mdp != password) {
      setPasswordInFirestore(email, password);
    }
    if (!emailExists) {
      print("Cet email n'existe pas");
      Fluttertoast.showToast(
        msg: 'Cet email n\'existe pas. Veuillez essayer un autre.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
      return null; // Retournez null car l'authentification a échoué
    }

    bool mdpCorrect = await verifyPassword(email, password);
    if (!mdpCorrect) {
      print("le mot de passe est incorrect");
      Fluttertoast.showToast(
        msg: 'Mot de passe incorrect',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
      return null; // Retournez null car l'authentification a échoué
    }
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('credential');
      print('here id credential :${credential.user?.uid}');
      return credential.user;
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
        msg: error.message ?? "Une erreur s'est produite. Veuillez réessayer.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
      return null; // Retournez null car l'authentification a échoué
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

  static Future<void> saveUserToken(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'custom_user.dart';
import 'helper_functions.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print("Sum Ting Wong with a SingingIn");
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = result.user;

      return _userFromFirebaseUser(firebaseUser!);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return null;
        }
      }
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      //    HelperFunctions.saveUserLoggedInSharedPreference(false);
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static Future<Authprocess> register(String email, String pass) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return Authprocess(isValid: true);
    } on FirebaseAuthException catch (e) {
      String msg = "error";
      if (e.code == 'weak-password') {
        print("object1");
        msg = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print("object2");
        msg = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        print("object3");
        msg = "Invalid email address";
      }

      return Authprocess(isValid: false, errorMsg: msg);
    } catch (e) {
      print(e);
    }
    return Authprocess(isValid: false, errorMsg: "error default");
  }

//auth Stete(2)
  static User? userState() {
    return FirebaseAuth.instance.currentUser;
  }

//logout (3)
  static logout() {
    return FirebaseAuth.instance.signOut();
  }
}

class Authprocess {
  bool isValid;
  String errorMsg;

  Authprocess({required this.isValid, this.errorMsg = ""});
}

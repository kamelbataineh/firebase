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
        msg = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        msg = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
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
//verfiy (3)
  static verfiy() {
    return FirebaseAuth.instance.currentUser?.emailVerified;
  }
}

class Authprocess {
  bool isValid;
  String errorMsg;

  Authprocess({required this.isValid, this.errorMsg = ""});
}


// int binarySearch(List list, int valu) {
//   int left = 0;
//   int right = list.length - 1;
//
//   while (left <= right) {
//     int mid = (left + right) ~/ 2;
//
//     if (list[mid] == valu) {
//       return mid;
//     } else if (list[mid] < valu) {
//       left = mid + 1;
//     } else {
//       right = mid - 1;
//     }
//   }
//
//   return -1;
// }
//
// void main() {
//   List<int> list = [1, 2, 3, 4, 5, 6, 7];
//   int index = binarySearch(list, 5);
//
//   print(index);
// }

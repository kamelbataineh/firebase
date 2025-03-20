import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// UI
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//Future عشان منتعامل مع firebase دايمن منستخدم
Future<bool> register(String email, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e);
  }
  return false;
}
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
Future<bool> Login(String email, String pass) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  return true;
  }on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e);
  }
  return false;
}
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
class AuthService {
  /////////////////////////
  //Create Singup(1)
  static Future<Authprocess> register(
      String email, String pass, int age) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      FirebaseFirestore.instance
          .collection('userCollection')
          .doc(credential.user!.uid)
          .set({
        'Emai': credential.user!.email,
        'age': age,
      });
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

//verfiy (4)
  static verfiy() {
    return FirebaseAuth.instance.currentUser?.emailVerified;
  }

//Singin(5)
  static Future<Authprocess> Login(String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      return Authprocess(
        isValid: true,
      );
    } on FirebaseAuthException catch (e) {
      String msg = "error";
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password provided for that user.';
      }
      return Authprocess(isValid: false, errorMsg: msg);
    } catch (e) {
      print(e);
    }
    return Authprocess(isValid: false, errorMsg: "error default");
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

///////////////////////
///////////////////////
////////////فحص ////////////////
// ElevatedButton(
// onPressed: () {
// if (_formkey.currentState!.validate()) {
// _formkey.currentState!.save();
// signup();
// }
// },
/////////// تسجيل بالتحميل////////////
// signup() async {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       return Center(
//         child: CircularProgressIndicator(
//           color: Color(0xFF15b9b4),
//         ),
//       );
//     },
//   );
//
//   Authprocess authprocess = await AuthService.register(email!, password!);
//
//   Navigator.of(context).pop();
//
//   if (authprocess.isValid == true) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("good")),
//     );
//
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => Singin()),
//       );
//     });
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(authprocess.errorMsg)),
//     );
//   }
// }
//////////////////////////
/////////////////////////////////
/////////////////////////
//////////////main()///////////////////
// void initState() {
//   super.initState();
//   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
// }
//////////////////////////
/////////////////////////////////
/////////////////////////
//////////////main()/////////////

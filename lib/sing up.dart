import 'package:firebase/auth_sarvice.dart';
import 'package:firebase/singin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _LoginState();
}

class _LoginState extends State<Singup> {
  void go() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Singin(),
    ));
  }

  final _formkey = GlobalKey<FormState>();
  bool isVisible1 = true;
  bool isVisible2 = true;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.white54,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 50),
                buildTextField("Email", Icons.email, false),
                buildpasswordField(
                  "Password",
                  Icons.password,
                  isVisible1,
                  () {
                    setState(() {
                      isVisible1 = !isVisible1;
                    });
                  },
                ),
                // buildpasswordField(
                //   "Password Confirmation",
                //   Icons.password,
                //   isVisible2,
                //   () {
                //     setState(() {
                //       isVisible2 = !isVisible2;
                //     });
                //   },
                // ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      signup();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF15b9b4),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Sign up"),
                ),

                /////////////////////////
                /////////////////////////
                /////////////////////////
                /////////////////////////
                /////////////////////////
                /////////////////////////
                // google -----------------------------------------------

                //////
                /////
                ////
                ///
                //

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {

                    signInWithGoogle();
                   },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF15b9b4),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Sign up with Google"),
                ),

                ///
                ///
                ///
                ///
                ///

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: go,
                      child:
                          Text("Sign in", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    Authprocess authprocess = await AuthService.register(email!, password!);
    if (authprocess.isValid == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Good")),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Singin(),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authprocess.errorMsg)));
      print("Errorrrr");
    }
  }

/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////
/////////////////////////

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // Future register(String email, String pass) async {
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: pass,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     String msg = "error";
  //     if (e.code == 'weak-password') {
  //       print("object1");
  //       msg = "The password provided is too weak.";
  //     } else if (e.code == 'email-already-in-use') {
  //       print("object2");
  //       msg = "The account already exists for that email.";
  //     } else if (e.code == 'invalid-email') {
  //       print("object3");
  //       msg = "Invalid email address";
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         msg,
  //       ),
  //       backgroundColor: Colors.red,
  //     ));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         e.toString(),
  //       ),
  //       backgroundColor: Colors.red,
  //     ));
  //   }
  // }

  Widget buildTextField(String label, IconData icon, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        ///
        ///
        onSaved: (T) {
          setState(() {
            email = T;
          });
        },

        ///
        ///
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF15b9b4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget buildpasswordField(String label, IconData icon, bool obscureText,
      VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        ///
        ///

        onSaved: (p) {
          setState(() {
            password = p;
          });
        },

        ///
        ///
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          labelText: label,
          suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Color(0xFF15b9b4),
              ),
              onPressed: toggleVisibility),
          prefixIcon: Icon(icon, color: Color(0xFF15b9b4)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

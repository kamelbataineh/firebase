import 'package:firebase/auth_sarvice.dart';
import 'package:firebase/screen_information.dart';
import 'package:firebase/sing%20up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Singin extends StatefulWidget {
  const Singin({super.key});

  @override
  State<Singin> createState() => _LoginState();
}

class _LoginState extends State<Singin> {
  void go() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScreenInformation(),
    ));
  }

  final _formkey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isVisible = true;

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
                    isVisible,
                    () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF15b9b4),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Sign in")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Singup(),
                          ));
                        },
                        child: Text("Sign up",
                            style: TextStyle(color: Colors.blue)),
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

  login() async {
    Authprocess authprocess = await AuthService.Login(email!, password!);
    if (authprocess.isValid == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Good")),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ScreenInformation(),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(authprocess.errorMsg)));
      print("Errorrrr");
    }
  }

  Widget buildpasswordField(String label, IconData icon, bool obscureText,
      VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onSaved: (p){
          setState(() {
            password=p;
          });
        },
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

  Widget buildTextField(String label, IconData icon, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onSaved: (T){
          setState(() {
            email=T;
          });
        },
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
}

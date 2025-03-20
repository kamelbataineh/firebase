import 'package:firebase/Task/ToDoApp.dart';
import 'package:firebase/Ul_Login.dart';
import 'package:firebase/auth_sarvice.dart';
import 'package:firebase/screen_information.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UiRegister extends StatefulWidget {
  const UiRegister({super.key});

  @override
  State<UiRegister> createState() => _UiState();
}

class _UiState extends State<UiRegister> {
  ////////////////////////////////////////////////
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  ////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => ScreenInformation()),
                  );
                },
                icon: Icon(Icons.keyboard_return))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                bool check = await register(
                                    emailController.text,
                                    passwordController.text) as bool;

                                setState(() {
                                  isLoading = false;
                                });

                                if (check) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Todoapp()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error")),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.transparent)
                            : Text("Register"),
                      ),
                      Center(
                        child: RichText(
                            text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF15b9b4),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => UlLogin(),
                                  ));
                                },
                            ),
                          ],
                        )),
                      ),
                    ])))));
  }
}

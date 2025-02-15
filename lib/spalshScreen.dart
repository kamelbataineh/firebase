import 'package:firebase/auth_sarvice.dart';
import 'package:firebase/screen_information.dart';
import 'package:firebase/sing%20up.dart';
import 'package:firebase/singin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Spalshscreen extends StatefulWidget {
  const Spalshscreen({super.key});

  @override
  State<Spalshscreen> createState() => _SpalshscreenState();
}

class _SpalshscreenState extends State<Spalshscreen> {
  @override
  ///////////////////
  ///////////////////
  ///////////////////
  ///////////////////
  ///////////////////
  ///////////////////
  ///////////////////
  ///////////////////
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      User? user = AuthService.userState();
      if (user == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Singup(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Singin(),
        ));
      }
    });
    super.initState();
  }

  /////////////////
  /////////////////
  /////////////////
  /////////////////
  /////////////////
  /////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text(""),
            backgroundColor: Colors.white54,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                ElevatedButton(onPressed: () {}, child: Text("Yes")),
                CircularProgressIndicator()//تحميل
              ],
            ),
          )),
    );
  }
}

import 'package:firebase/Read_firebase.dart';
import 'package:firebase/auth_sarvice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScreenInformation extends StatefulWidget {
  const ScreenInformation({super.key});

  @override
  State<ScreenInformation> createState() => _ScreenInformationState();
}

class _ScreenInformationState extends State<ScreenInformation> {
///////////////////////
  final credential = FirebaseAuth.instance.currentUser;

///////////////////////

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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => AuthService.logout()),
                    );
                  },
                  child: Text("Yes"),
                ),
                SizedBox(height: 10),
                Text("email : ${credential!.email}"),
                Text(
                    "Creat :${DateFormat('MMM,d,y').format(credential!.metadata.creationTime!)}"),
                Text(
                    "Sign-in :${DateFormat('MMM,d,y').format(credential!.metadata.lastSignInTime!)}"),
                SizedBox(height: 10),


                GetReadName(
                  documentId: credential!.uid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase/Read_firebase.dart';
import 'package:firebase/Task/CardTask.dart';
import 'package:firebase/Task/ToDoApp.dart';
import 'package:firebase/UI_register.dart';
import 'package:firebase/auth_sarvice.dart';
import 'package:firebase/image_add.dart';
import 'package:firebase/singin.dart';
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
   return Scaffold(
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
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>ImageAdd()),
                    );
                  },
                  child: Text("profile"),
                ), ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>Todoapp()));
                  },
                  child: Text("Add Task"),
                ),ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>UiRegister()));
                  },
                  child: Text("Ui register"),
                ),
                ElevatedButton(
                onPressed: () async {
          await AuthService.logout();
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>Singin()),
          );
          },
                  child: Text("Log out"),
                ),
                SizedBox(height: 10),
                Text("email : ${credential!.email}"),
                Text(
                    "Creat :${DateFormat('MMM,d,y').format(credential!.metadata.creationTime!)}"),
                Text(
                    "Sign-in :${DateFormat('MMM,d,y').format(credential!.metadata.lastSignInTime!)}"),
                SizedBox(height: 20),



                // READ FIRE BASE
                GetReadName(
                  documentId: credential!.uid,
                ),
              ],
            ),
          ),
        ),
      );
  }
}

import 'package:firebase/auth_sarvice.dart';
import 'package:flutter/material.dart';

class ScreenInformation extends StatefulWidget {
  const ScreenInformation({super.key});

  @override
  State<ScreenInformation> createState() => _ScreenInformationState();
}

class _ScreenInformationState extends State<ScreenInformation> {
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => AuthService.logout(),
                      ));
                    },
                    child: Text("Yes"))
              ],
            ),
          )),
    );
  }
}

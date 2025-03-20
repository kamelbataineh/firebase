import 'dart:io';

import 'package:firebase/screen_information.dart';
import 'package:firebase/video_add.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAdd extends StatefulWidget {
  const ImageAdd({super.key});

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.black,
      actions: [IconButton(onPressed: (){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>ScreenInformation()),

        );
      }, icon: Icon(Icons.keyboard_return))],
    ),
        body: Center(
      child: Column(

        children: [
          SizedBox(height: 100,),
          ElevatedButton(
            onPressed:(){
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(builder: (context) =>VideoAdd()),
              //
              // );
            },
            child: Text("Go Add video"),
          ),
          Stack(children: [
            CircleAvatar(
              radius: 50,

              backgroundImage: ImageFile != null
                  ? FileImage(ImageFile!)
                  : NetworkImage("https://www.w3schools.com/w3images/avatar2.png"),
            ),
              Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  onPressed: () {
                    showImageOptions();
                  },
                ),
              ),
            ),
          ]),
        ],
      ),

    ));
  }

  void showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blue),
                title: Text("Take a Photo"),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.image, color: Colors.green),
                title: Text("Pick from Gallery"),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
  File? ImageFile;

  void pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickimage = await picker.pickImage(source: source);
    if (pickimage != null) {
      setState(() {
        ImageFile = File(pickimage.path);
      });
    }
  }
}

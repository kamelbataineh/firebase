import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetReadName extends StatefulWidget {
  final String documentId;

  GetReadName({required this.documentId});

  @override
  State<GetReadName> createState() => _GetReadNameState();
}

class _GetReadNameState extends State<GetReadName> {
  @override
  Widget build(BuildContext context) {
    /////////////
    /////////////
    TextEditingController textEditingController = TextEditingController();

    /////////////
    /////////////
    CollectionReference users =
        FirebaseFirestore.instance.collection('userCollection');

    /////////////
    /////////////
    final credential = FirebaseAuth.instance.currentUser;

    /////////////
    /////////////
    showMyDialog(data, mykey) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit"),
            content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: data[mykey],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    users
                        .doc(credential!.uid)
                        .update({mykey: textEditingController.text});
                    setState(() {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Save"),
              ),
            ],
          );
        },
      );
    }

    /////////////////
    /////////////////
    /////////////////
    showDeleteDialog(String mykey) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure you want to delete this item?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  users
                      .doc(credential!.uid)
                      .update({mykey: FieldValue.delete()});
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );
    }

    /////////////
    /////////////
    /////////////

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Row(
                children: [
                  Text("Full Name: ${data['Emai']}"),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        showMyDialog(data, 'Emai');
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                    onPressed: () {
                      showDeleteDialog('Emai');
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
              ///////
              ///////
              ///////
              Row(
                children: [
                  Text("\n Age : ${data['age']}"),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showMyDialog(data, 'age');
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      showDeleteDialog('age');
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              )
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}

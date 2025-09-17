import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Task/CardTask.dart';
import 'package:firebase/Task/ShowDialog.dart';
import 'package:firebase/Task/ToDoApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screen_information.dart';

class Subtask extends StatefulWidget {
  String docId;

  Subtask({required this.docId});

  @override
  State<Subtask> createState() => _SubtaskState();
}

class _SubtaskState extends State<Subtask> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('task');
  TextEditingController addTaskController = TextEditingController();
  List<Task> allTask = [];
  List<QueryDocumentSnapshot> data = [];
  bool isLoading = true;

  getTasks() async {
    // QuerySnapshot querySnapshot = await tasksCollection.get();
    // روح شيك اذا uid نفس اللي دخل عبليه المستخدم
    data.clear();

    QuerySnapshot querySnapshot =
        await tasksCollection.doc(widget.docId).collection('subtask').get();
    setState(() {
      data.addAll(querySnapshot.docs);
    });
    isLoading = false;
  }

  addTask(String name, bool status, String docId) {
    tasksCollection
        .doc(docId)
        .collection('subtask')
        .add({'name': name, 'status': status});
    setState(() {
      data.clear();
      getTasks();
    });
  }

  delete(String mainColl,String subColl) {
    tasksCollection
        .doc(mainColl)
        .collection('subtask').doc(subColl).delete();
    data.clear();
    getTasks();
  }

  // update(String id, bool newStatus) async {
  //   await tasksCollection.doc(id).update({'status': newStatus});
  //
  //   data.clear();
  //   getTasks();
  // }
  //
  // onChangeStuats(int index) {
  //   setState(() {
  //     allTask[index].isDo = !allTask[index].isDo;
  //   });
  // }

  @override
  void initState() {
    // getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int lenOFTasks = allTask.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Sub Task",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Text("${completedTasks()}/$lenOFTasks",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              )),
          Center(
            widthFactor: 3,
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Todoapp()),
                  );
                },
                icon: Icon(Icons.keyboard_return)),
          ),
        ],
      ),
      body:
      isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : data.isEmpty
          ? Center(child: Text('No tasks available.'))
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CardCalss(
            data[index]['name'],
            data[index]['status'],
            data[index].id,
                () {
              delete(widget.docId,data[index].id);
            },
                () {
              // update(data[index].id, !data[index]['status']);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add task"),
                content: TextFormField(
                  controller: addTaskController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (addTaskController.text.isNotEmpty) {
                        addTask(addTaskController.text, false, widget.docId);
                        addTaskController.clear();
                      }
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  int completedTasks() {
    return allTask.where((task) => task.isDo).length;
  }
}

class Task {
  String task;
  bool isDo;

  Task({required this.task, required this.isDo});
}

Widget CardCalss(String txt, bool status, String id, VoidCallback onDelete,
    VoidCallback onUpdate) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 100,
      child: Card(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(txt),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    bool newValue = !status;
                    print(newValue);
                    onUpdate();
                  },
                  icon: Icon(
                    status ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

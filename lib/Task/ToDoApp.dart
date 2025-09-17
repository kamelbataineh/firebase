import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Task/CardTask.dart';
import 'package:firebase/Task/ShowDialog.dart';
import 'package:firebase/Task/SubTask.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../screen_information.dart';

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});

  @override
  State<Todoapp> createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> {
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

    QuerySnapshot querySnapshot = await tasksCollection
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      data.addAll(querySnapshot.docs);
    });
    isLoading = false;
  }

  addTask(String name) {
    tasksCollection.add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'taskName': name,
      'status': false,
    });
    setState(() {
      data.clear();
      getTasks();
    });
  }

  delete(String id) {
    tasksCollection.doc(id).delete();
    data.clear();
    getTasks();
  }

  update(String id, bool newStatus) async {
    await tasksCollection.doc(id).update({'status': newStatus});

    data.clear();
    getTasks();
  }

  onChangeStuats(int index) {
    setState(() {
      allTask[index].isDo = !allTask[index].isDo;
    });
  }

  @override
  void initState() {
    getTasks();
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
          "To Do App",
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
                    MaterialPageRoute(
                        builder: (context) => ScreenInformation()),
                  );
                },
                icon: Icon(Icons.keyboard_return)),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? Center(child: Text('No tasks available.'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CardCalss(
                      data[index]['taskName'],
                      data[index]['status'],
                      data[index].id,
                      () {
                        delete(data[index].id);
                      },
                      () {
                        update(data[index].id, !data[index]['status']);
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
                        addTask(addTaskController.text);
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

  Widget CardCalss(String txt, bool status, String id, VoidCallback onDelete,
      VoidCallback onUpdate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 100,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Subtask(docId: id,)),
            );
          },
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
                        status
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
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
      ),
    );
  }
}

class Task {
  String task;
  bool isDo;

  Task({required this.task, required this.isDo});
}

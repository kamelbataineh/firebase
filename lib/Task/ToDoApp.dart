import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Task/CardTask.dart';
import 'package:firebase/Task/ShowDialog.dart';
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
  CollectionReference tasksCollection = FirebaseFirestore.instance.collection('task');
  TextEditingController addTaskController = TextEditingController();
  List<Task> allTask = [];

  addTask(String name) async {
    await tasksCollection.add({
      'taskName': name,
      'status': false,
    });
    getTasks();
  }

  onChangeStuats(int index) {
    setState(() {
      allTask[index].isDo = !allTask[index].isDo;
    });
  }

  deleteItem(int index) {
    setState(() {
      allTask.removeAt(index);
    });
  }

  List<QueryDocumentSnapshot> data = [];

  getTasks() async {
    QuerySnapshot querySnapshot = await tasksCollection.get();
    setState(() {
      data.clear();
      data.addAll(querySnapshot.docs);
      allTask = data.map((doc) => Task(task: doc['taskName'], isDo: doc['status'])).toList();
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
      body: SingleChildScrollView(
          child: allTask.isEmpty
              ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return CardCalss(
                  data[index]['taskName'], data[index]['status'].toString());
            },
          )
              : Column(
            children: [
              ...allTask
                  .map((item) => Cardtask(
                  taskTitle: item.task,
                  isCheck: item.isDo,
                  index: allTask.indexOf(item),
                  changeFun: onChangeStuats,
                  delete: deleteItem))
                  .toList()
            ],
          )),
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
}

class Task {
  String task;
  bool isDo;

  Task({required this.task, required this.isDo});
}

Widget CardCalss(String txt, String status) {
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
                  onPressed: () {},
                  icon: Icon(
                    status == 'true' ? Icons.check_box : Icons.check_box_outline_blank,
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
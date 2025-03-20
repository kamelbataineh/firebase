import 'package:firebase/Task/CardTask.dart';
import 'package:firebase/Task/ShowDialog.dart';
import 'package:flutter/material.dart';

import '../screen_information.dart';

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});

  @override
  State<Todoapp> createState() => _TodoappState();
}

class _TodoappState extends State<Todoapp> {
////////////////////////////////////////
  ///////
  TextEditingController addTaskController = TextEditingController();
  List<Task> allTask = [];

  onChangeStuats(int index) {
    setState(() {
      allTask[index].isDo = !allTask[index].isDo;
    });
  }

  deleteItem(int index) {
    setState(() {
      allTask.remove(allTask[index]);
    });
  }

  ///////
////////////////////////////////////////

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
                    MaterialPageRoute(builder: (context) => ScreenInformation()),
                  );
                },
                icon: Icon(Icons.keyboard_return)),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: allTask.length == 0
              ? Center(
                  child: Text("Start Add task",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40)),
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
              return ShowDialog(
                  addTaskController: addTaskController, function: fun);
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  ///////
////////////////////////////////////////

////////////////////////////////////////
  ///////
  fun() {
    setState(() {
      allTask.add(Task(task: addTaskController.text, isDo: false));
    });
  }

  int completedTasks() {
    int dnoe = 0;
    for (var i in allTask) {
      if (i.isDo) {
        dnoe++;
      }
    }
    return dnoe;
  }
}

class Task {
  String task;
  bool isDo;

  Task({required this.task, required this.isDo});
}

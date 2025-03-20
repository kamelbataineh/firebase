import 'package:flutter/material.dart';

class ShowDialog extends StatefulWidget {
  final TextEditingController addTaskController;
  final Function function;

  ShowDialog({required this.addTaskController, required this.function});

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: TextField(
        controller: widget.addTaskController,
        decoration: const InputDecoration(
          hintText: "Enter task name",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              widget.function();
            });
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}

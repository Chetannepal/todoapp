import 'package:flutter/material.dart';

class Addtodo extends StatelessWidget {
  const Addtodo({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String newTodoTitle = '';
            return AlertDialog(
              title: const Text('Add New Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter todo title ',
                    ),
                    onChanged: (value) {
                      newTodoTitle = value;
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    //if (newTodoTitle.isNotEmpty) {
                    // Provider.of<TodoData>(
                    //  context,
                    //  listen: false,
                    // ).addTodo(newTodoTitle);
                    // Navigator.of(context).pop();
                    //}
                  },
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

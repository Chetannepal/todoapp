import 'package:flutter/material.dart';
import 'package:my_todo/components/colors.dart';
import 'package:my_todo/model/ToDo.dart';

class Todoitem extends StatelessWidget {
  final Todo todo;
  final onToDoChanged;
  final VoidCallback onToDoDelete;
  const Todoitem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onToDoDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone == 1 ? Icons.check_box : Icons.check_box_outline_blank,
          color: ABlue,
        ),
        title: Text(
          todo.title!,
          selectionColor: Colors.red,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ABlack,
            decoration: todo.isDone == 1 ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: ARed),
          onPressed: onToDoDelete,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_project/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onChange;
  final onDelete;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onChange,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        tileColor: Colors.white,
        onTap: () {
          onChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          todo.todoText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        leading: todo.isDone
            ? Icon(Icons.check_box)
            : Icon(Icons.check_box_outline_blank),
        iconColor: Colors.green,
        trailing: IconButton(
          onPressed: () {
            onDelete(todo.id);
          },
          icon: Icon(Icons.delete),
          color: Colors.red,
        ),
      ),
    );
  }
}

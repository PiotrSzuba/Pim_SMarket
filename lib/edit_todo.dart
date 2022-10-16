import 'package:flutter/material.dart';

class EditTodo extends StatelessWidget {
  final String todoText;
  const EditTodo({Key? key, required this.todoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo $todoText"),
      ),
    );
  }
}

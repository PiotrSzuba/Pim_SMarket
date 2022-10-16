import 'package:flutter/material.dart';
import 'package:testapp/edit_todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _listOfTodos = <String>[];

  _TodoListState() {
    _listOfTodos.add('Kupić sznur');
    _listOfTodos.add("Kupić taboret");
    _listOfTodos.add("Wynając piwnice");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo list"),
      ),
      body: ListView(children: _getTodoList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newTodoPopUp(context),
        tooltip: "Add new Todo",
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  List<Widget> _getTodoList() {
    return _listOfTodos
        .map((e) => Card(
                child: ListTile(
              title: Text(e),
              leading: const Icon(
                Icons.task,
                color: Colors.blue,
              ),
              hoverColor: Colors.purple,
              onTap: () {
                Future<Object?> result = Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => EditTodo(todoText: e)));
                result
                    .then((value) => print(" $e zastąpi ${result as String}"));
              },
            )))
        .toList();
  }

  Future<void> _newTodoPopUp(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Enter new Todo"),
              content: TextField(
                controller: controller,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _listOfTodos.add(controller.text);
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Done !"))
              ],
            )));
  }
}

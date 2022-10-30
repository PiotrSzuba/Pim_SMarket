import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/data/data.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Widget> students = List<Widget>.generate(
      20,
      (index) => InfoCard(
            name: "student ${index + 1}",
            tags: "C C++ C# F# Java Python Lisp Javascript Typescript Dart",
            imageUrl: 'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
            onPressed: () => print("student ${index + 1} clicked"),
          ));

  List<Widget> companies = List<Widget>.generate(
      20,
      (index) => InfoCard(
            name: "company ${index + 1}",
            tags: "Greedy, low pay, fruity fridays, paid coffee",
            imageUrl: 'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
            onPressed: () => print("Company ${index + 1} clicked"),
          ));

  List<Widget> _getItems(UserContext userContext) {
    return userContext.isStudent() ? companies : students;
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: SingleChildScrollView(
            child: Consumer<UserContext>(
                builder: (context, userContext, child) =>
                    Column(children: _getItems(userContext)))));
  }
}

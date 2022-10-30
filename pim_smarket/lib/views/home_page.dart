import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Widget> items = List<Widget>.generate(
      20,
      (index) => InfoCard(
            name: "student ${index + 1}",
            tags: "C C++ C# F# Java Python Lisp Javascript Typescript Dart",
            imageUrl: 'https://media.tenor.com/m8oi5KsmOZ0AAAAS/loli.gif',
            onPressed: () => print("student ${index + 1} clicked"),
          ));

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: SingleChildScrollView(child: Column(children: items)));
  }
}

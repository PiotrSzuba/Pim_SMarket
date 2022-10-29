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
      30,
      (index) => InfoCard(
            studentName: "student $index",
            tags: "C C++ C# F# Java Python Lisp Javascript Typescript Dart",
          ));

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: SingleChildScrollView(child: Column(children: items)));
  }
}

import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _value = "";
  void onChange(String value) {
    setState(() {
      _value = value;
    });
  }

  void onClick() {
    print("essa");
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        child: Column(children: [
      const Text(
        "Most recent",
        style: CustomTheme.pinkTitle,
      ),
      TextInput(
        placeholder: "Enter your name",
        title: "Name",
        value: _value,
        onChange: onChange,
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Button(title: 'Home button', onClicked: onClick),
      ),
      SizedBox(
        width: 100,
        child: Button(
          title: "small",
          onClicked: () {},
        ),
      )
    ]));
  }
}

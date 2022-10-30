import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/theme.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
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
        placeholder: "Name",
        label: "Enter your name",
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

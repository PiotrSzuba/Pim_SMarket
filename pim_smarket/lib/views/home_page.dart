import 'package:flutter/material.dart';
import 'package:pim_smarket/theme.dart';
import 'package:pim_smarket/components/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate.build(Text(widget.title,
        textAlign: TextAlign.center, style: CustomTheme.pinkText));
  }
}

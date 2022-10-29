import 'package:flutter/material.dart';
import 'package:pim_smarket/components/components.dart';
import 'package:pim_smarket/theme.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, required this.title});

  final String title;

  @override
  State<AddPage> createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate.build(Text(widget.title,
        textAlign: TextAlign.center, style: CustomTheme.pinkText));
  }
}

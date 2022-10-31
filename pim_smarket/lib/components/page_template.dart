import 'package:flutter/material.dart';
import 'package:pim_smarket/theme.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate(
      {super.key, required this.child, this.floatingActionButton});

  final Widget child;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: width * CustomTheme.bodyMarginX),
          child: child),
      backgroundColor: CustomTheme.backgroundColor,
    );
  }
}

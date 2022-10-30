import 'package:flutter/material.dart';
import 'package:pim_smarket/theme.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          padding:
              EdgeInsets.symmetric(horizontal: width * CustomTheme.bodyMarginX),
          child: child),
      backgroundColor: CustomTheme.backgroundColor,
    );
  }
}

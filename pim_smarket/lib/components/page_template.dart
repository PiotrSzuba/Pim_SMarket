import 'package:flutter/material.dart';

import '../theme.dart';

class PageTemplate {
  static Scaffold build(Widget child) {
    return Scaffold(
      body: Center(child: child),
      backgroundColor: CustomTheme.backgroundColor,
    );
  }
}

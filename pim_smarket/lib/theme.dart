import 'package:flutter/material.dart';

class CustomTheme {
  static const Color pinkColor = Color(0xFFAB41F1);

  static const MaterialColor pinkMaterial = MaterialColor(
    0xFFAB41F1,
    <int, Color>{
      50: Color(0xFFFBF6FF),
      100: Color(0xFFF7ECFE),
      200: Color(0xFFEAD0FC),
      300: Color(0xFFDDB2FA),
      400: Color(0xFFC57AF6),
      500: Color(0xFFAB41F1),
      600: Color(0xFF993AD7),
      700: Color(0xFF672791),
      800: Color(0xFF4D1E6D),
      900: Color(0xFF321346),
    },
  );

  static const TextStyle blackText = TextStyle(color: Colors.black);
  static const TextStyle pinkText = TextStyle(color: pinkColor);
}

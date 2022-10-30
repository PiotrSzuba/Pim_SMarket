import 'package:flutter/material.dart';
import "./extensions/extensions.dart";

class CustomTheme {
  static const double _borderRadius = 10.0;
  static const int _red = 171;
  static const int _green = 65;
  static const int _blue = 241;
  static const Color pinkColor = Color.fromARGB(255, _red, _green, _blue);
  static const Color pinkColor50 = Color.fromARGB(125, _red, _green, _blue);
  static const double bodyMarginX = 0.05;
  static const double bodyMarginY = 0.05;
  static const String appName = "Slave market";

  static const TextStyle blackText = TextStyle(color: Colors.black);
  static const TextStyle pinkText = TextStyle(color: pinkColor);
  static const TextStyle pinkText50 = TextStyle(color: pinkColor50);
  static const TextStyle pinkTitle =
      TextStyle(color: pinkColor, fontWeight: FontWeight.bold, fontSize: 20);
  static const Color backgroundColor = Colors.black26;
  static const Color elementFillColor = Colors.black;

  static const BorderRadius circularBorder =
      BorderRadius.all(Radius.circular(_borderRadius));

  static final int _pinkColorValue =
      int.parse("0x${pinkColor.toHex(leadingHashSign: false)}");

  static MaterialColor pinkMaterial = MaterialColor(
    _pinkColorValue,
    _getSwat(_red, _green, _blue),
  );

  static Map<int, Color> _getSwat(int red, int green, int blue) {
    return <int, Color>{
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };
  }
}

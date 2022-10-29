import 'package:flutter/material.dart';
import "./extensions/extensions.dart";

class CustomTheme {
  static const int _red = 171;
  static const int _green = 65;
  static const int _blue = 241;

  static const Color _pinkColor = Color.fromARGB(255, _red, _green, _blue);
  static final int _pinkColorValue =
      int.parse("0x${_pinkColor.toHex(leadingHashSign: false)}");

  static MaterialColor pinkMaterial = MaterialColor(
    _pinkColorValue,
    _getSwat(_red, _green, _blue),
  );

  static const TextStyle blackText = TextStyle(color: Colors.black);
  static const TextStyle pinkText = TextStyle(color: _pinkColor);
  static const Color backgroundColor = Colors.black54;

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

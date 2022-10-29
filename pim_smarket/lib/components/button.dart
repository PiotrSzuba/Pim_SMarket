import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onClicked,
  });

  final String title;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onClicked(),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomTheme.pinkColor50;
              }
              return CustomTheme.pinkColor;
            }),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: CustomTheme.circularBorder)),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50))),
        child: Text(
          title,
          style: CustomTheme.blackText,
        ));
  }
}

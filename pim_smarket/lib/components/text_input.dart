import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onChange,
    this.asteriskText,
  });

  final String label;
  final String placeholder;
  final String value;
  final Function onChange;
  final bool? asteriskText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: CustomTheme.pinkColor),
              borderRadius: CustomTheme.circularBorder),
          labelText: label,
          labelStyle: CustomTheme.pinkText,
          hintText: placeholder,
          hintStyle: CustomTheme.pinkText50,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: CustomTheme.pinkColor),
              borderRadius: CustomTheme.circularBorder),
          contentPadding: const EdgeInsets.all(8),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: CustomTheme.pinkText,
          filled: true,
          fillColor: Colors.black),
      obscureText: asteriskText ?? false,
      obscuringCharacter: '*',
      style: const TextStyle(color: CustomTheme.pinkColor),
      onChanged: (value) => onChange(value),
    );
  }
}

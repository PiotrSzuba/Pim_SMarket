import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.title,
    required this.value,
    required this.onChange,
    required this.placeholder,
  });

  final String title;
  final String placeholder;
  final String value;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: CustomTheme.pinkColor),
              borderRadius: CustomTheme.circularBorder),
          labelText: placeholder,
          labelStyle: CustomTheme.pinkText,
          hintText: title,
          hintStyle: CustomTheme.pinkText50,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: CustomTheme.pinkColor),
              borderRadius: CustomTheme.circularBorder),
          contentPadding: const EdgeInsets.all(8),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: CustomTheme.pinkText,
          filled: true,
          fillColor: Colors.black),
      style: const TextStyle(color: CustomTheme.pinkColor),
      onChanged: (value) => onChange(value),
    );
  }
}

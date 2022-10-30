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
    this.isError,
  });

  final String label;
  final String placeholder;
  final String value;
  final Function onChange;
  final bool? asteriskText;
  final bool? isError;

  Color _getBorderColor() {
    if (isError == null) return CustomTheme.pinkColor;
    return isError! ? CustomTheme.errorColor : CustomTheme.pinkColor;
  }

  TextStyle _getTextStyle() {
    if (isError == null) return CustomTheme.pinkText;
    return isError! ? CustomTheme.errorText : CustomTheme.pinkText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: _getBorderColor()),
              borderRadius: CustomTheme.circularBorder),
          labelText: label,
          labelStyle: _getTextStyle(),
          hintText: placeholder,
          hintStyle: CustomTheme.pinkText50,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: _getBorderColor()),
              borderRadius: CustomTheme.circularBorder),
          contentPadding: const EdgeInsets.all(8),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: _getTextStyle(),
          filled: true,
          fillColor: Colors.black),
      obscureText: asteriskText ?? false,
      obscuringCharacter: '*',
      style: _getTextStyle(),
      onChanged: (value) => onChange(value),
    );
  }
}

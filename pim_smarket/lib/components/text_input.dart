import "package:flutter/material.dart";
import 'package:pim_smarket/theme.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.onChange,
    this.asteriskText,
    this.isError,
    this.errorMessage,
    this.multiLine,
    this.controller,
  });

  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool? asteriskText;
  final bool? isError;
  final String? errorMessage;
  final bool? multiLine;

  @override
  State<StatefulWidget> createState() => _TextInput();
}

class _TextInput extends State<TextInput> {
  Color _getBorderColor() {
    if (widget.isError == null) return CustomTheme.pinkColor;
    return widget.isError! ? CustomTheme.errorColor : CustomTheme.pinkColor;
  }

  TextStyle _getTextStyle() {
    if (widget.isError == null) return CustomTheme.pinkText;
    return widget.isError! ? CustomTheme.errorText : CustomTheme.pinkText;
  }

  bool _isInputMultiLine() {
    if (widget.multiLine != null && widget.multiLine == true) return true;
    return false;
  }

  TextInputType _getInputType() {
    if (_isInputMultiLine()) return TextInputType.multiline;
    return TextInputType.text;
  }

  String _getLabelText() {
    if (widget.errorMessage == null) return widget.label;
    if (widget.isError == null) return widget.label;
    if (widget.isError!) return widget.errorMessage!;
    return widget.label;
  }

  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: _isInputMultiLine() ? null : 1,
      minLines: _isInputMultiLine() ? 5 : 1,
      keyboardType: _getInputType(),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: _getBorderColor()),
              borderRadius: CustomTheme.circularBorder),
          labelText: _getLabelText(),
          labelStyle: _getTextStyle(),
          hintText: widget.placeholder,
          hintStyle: CustomTheme.pinkText50,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: _getBorderColor()),
              borderRadius: CustomTheme.circularBorder),
          contentPadding: EdgeInsets.symmetric(
              vertical: _isInputMultiLine() ? 12 : 8, horizontal: 8),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: _getTextStyle(),
          filled: true,
          fillColor: Colors.black),
      obscureText: widget.asteriskText ?? false,
      obscuringCharacter: '*',
      style: _getTextStyle(),
      onChanged: (value) =>
          widget.onChange == null ? null : widget.onChange!(value),
    );
  }
}

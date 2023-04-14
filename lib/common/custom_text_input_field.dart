import 'package:flutter/material.dart';
import 'package:todo/theme/theme.dart';

class CustomTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int numberOfLines;
  const CustomTextInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.numberOfLines = 1});

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.numberOfLines,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        // labelText: widget.hintText,
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Pallete.inputBorderColor),
        ),
        
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 3),
        ),
      ),
    );
  }
}

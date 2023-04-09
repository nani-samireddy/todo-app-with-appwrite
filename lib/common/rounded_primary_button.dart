import 'package:flutter/material.dart';

class RoundedPrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const RoundedPrimaryButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            backgroundColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ));
  }
}

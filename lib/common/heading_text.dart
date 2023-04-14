import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  final String content;
  final TextStyle? textStyle;
  const HeadingText({required this.content, this.textStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: textStyle ??
          const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }
}

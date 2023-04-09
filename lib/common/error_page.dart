import 'package:flutter/material.dart';
import 'package:todo/constants/UI_constants.dart';

class Errortext extends StatelessWidget {
  final String errorText;
  const Errortext({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorText),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String errorText;
  const ErrorPage({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIConstants.appBar(),
      body: Errortext(errorText: errorText),
    );
  }
}

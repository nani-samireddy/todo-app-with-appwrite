import 'package:flutter/material.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: const Text(
        "Todo",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
      ),
    ),
  );
}

Map<dynamic, dynamic> compareMaps(
    {required Map<dynamic, dynamic> map1,
    required Map<dynamic, dynamic> map2}) {
  Map<dynamic, dynamic> result = {};
  map1.forEach((key, value) {
    if (map2.containsKey(key)) {
      if (map2[key] != value) {
        result[key] = map2[key];
      }
    }
  });
  return result;
}

import 'package:flutter/material.dart';
import 'package:t89/core/widget_keys/widget_keys.dart';

showSnackBarMessage(String message) {
  ScaffoldMessenger.of(rootNavKey.currentContext!).removeCurrentSnackBar();
  ScaffoldMessenger.of(rootNavKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

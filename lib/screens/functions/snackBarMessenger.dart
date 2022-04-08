import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void SnackBarMessenger(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    padding: const EdgeInsets.all(16.0),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ));
}

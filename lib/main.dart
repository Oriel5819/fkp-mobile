import 'package:fkpmobile/login.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: primary),
    home: const Login(),
  ));
}

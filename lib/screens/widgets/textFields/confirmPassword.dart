// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ConfirmPasswordField extends StatelessWidget {
  late String password;
  late String toConfirmPassword;
  final String passwordHint;

  ConfirmPasswordField(
      {Key? key,
      required this.password,
      required this.toConfirmPassword,
      required this.passwordHint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: true,
          controller: TextEditingController(text: password),
          onChanged: (value) {
            password = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a password.';
            }
            if (value.length < 8) {
              return 'Password content longer must be at least 8 characters.';
            }
            if (value.length > 16) {
              return 'Password content longer must not be more than 16 characters.';
            }
            if (value != toConfirmPassword) {
              return "Password and confirm password must match.";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: passwordHint,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoutButton extends StatelessWidget {
  final Icon leftIcon;

  final String text;
  final Color bacgroundColor;
  final Color color;
  final VoidCallback press;

  const LogoutButton({
    Key? key,
    required this.leftIcon,
    required this.text,
    required this.bacgroundColor,
    required this.color,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
            elevation: 0,
            primary: color,
            backgroundColor: bacgroundColor,
            padding: const EdgeInsets.all(20.0)),
        child: Row(
          children: [
            leftIcon,
            const SizedBox(
              width: 20,
            ),
            Expanded(child: Text(text)),
          ],
        ));
  }
}

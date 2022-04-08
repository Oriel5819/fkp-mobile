// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmailField extends StatelessWidget {
  late String email;
  final String emailHint;

  EmailField({Key? key, required this.email, required this.emailHint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 20,
        ),
        // TextFormField(
        //   onChanged: (value) {
        //     email = value;
        //   },
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return "Please enter an email";
        //     } else if (value.length < 10) {
        //       return "A name contents must be at least 10 characters";
        //     } else if (RegExp(
        //             r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        //         .hasMatch(value)) {
        //       return null;
        //     } else {
        //       return 'Please a valid Email';
        //     }
        //   },
        //   decoration: InputDecoration(
        //     hintText: emailHint,
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NameField extends StatelessWidget {
  late String name;
  final String nameHint;

  NameField({Key? key, required this.name, required this.nameHint})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          obscureText: false,
          controller: TextEditingController(text: name),
          onChanged: (value) {
            name = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter a name";
            }
            if (value.length < 3) {
              return "A name contents must be at least 3 characters";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: nameHint,
          ),
        ),
      ],
    );
  }
}

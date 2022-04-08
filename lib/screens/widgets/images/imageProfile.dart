import 'package:flutter/cupertino.dart';

class ImageProfile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ImageProfile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
              height: 128,
              width: 128,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/128',
                  fit: BoxFit.cover,
                  height: 128,
                  width: 128,
                ),
              )),
        ),
        const SizedBox(height: 20),
        Text(
          firstName + " " + lastName.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        Text(
          email.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

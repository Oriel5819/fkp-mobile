import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Map user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        shadowColor: Colors.deepPurple,
        title: Text(user['email']),
      ),
    );
  }
}

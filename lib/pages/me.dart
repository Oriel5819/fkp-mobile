import 'package:fkpmobile/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToken();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: TextButton(
          child: const Text("Logout"),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.purpleAccent),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
            checkToken();
          },
        ),
      ),
    );
  }
}

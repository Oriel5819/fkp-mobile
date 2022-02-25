import 'dart:convert';

import 'package:fkpmobile/api/api.dart';
import 'package:fkpmobile/landing.dart';
import 'package:fkpmobile/login.dart';
import 'package:fkpmobile/newuser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  // final _registerURL = Uri.parse('http://10.0.2.2:3005/register');
  NewUser newUser = NewUser('', '', '', '');
  ApiURL api = ApiURL();

  Future<http.Response?> register() async {
    if (newUser.password == newUser.confirmPassword) {
      http.Response response =
          await http.post(Uri.parse(api.URI + "users/register"),
              headers: <String, String>{
                "Content-type": "application/json",
                "Accept": "application/json",
                "charset": "utf-8"
              },
              body: json.encode({
                'firstName': newUser.firstName,
                'email': newUser.email,
                'password': newUser.password,
              }));

      // print(response.body);
      if (response.statusCode == 201) {
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        var parsedBody = jsonDecode(response.body);
        await sharedPref.setString('id', parsedBody['_id']);
        await sharedPref.setString('token', parsedBody['token']);
        if (parsedBody['_id'] != null && parsedBody['token'] != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Landing()));
        }
      } else {
        throw Exception('error');
      }
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      child: Stack(children: [
        if (!isKeyboard)
          Positioned(
              top: 0,
              child: SvgPicture.asset(
                'images/top.svg',
                width: 400,
                height: 150,
              )),
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isKeyboard) const SizedBox(height: 100),
                const SizedBox(
                  height: 50,
                ),
                if (!isKeyboard)
                  Text(
                    "Fkpmobile",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        // color: Colors.white,
                        color: Colors.purpleAccent),
                  ),
                if (isKeyboard)
                  Text(
                    "Fkpmobile",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        // color: Colors.white,
                        color: Colors.purpleAccent),
                  ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    obscureText: false,
                    controller: TextEditingController(text: newUser.firstName),
                    onChanged: (value) {
                      newUser.firstName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Name.',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: newUser.email),
                    onChanged: (value) {
                      newUser.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Please a valid Email';
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter email.',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: TextEditingController(text: newUser.password),
                    onChanged: (value) {
                      newUser.password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter something';
                      }
                      if (value.length < 8) {
                        return 'Pasword contents must be at least 8 characters.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter password.',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    obscureText: true,
                    controller:
                        TextEditingController(text: newUser.confirmPassword),
                    onChanged: (value) {
                      newUser.confirmPassword = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter something';
                      }
                      if (value.length < 8) {
                        return 'Pasword contents must be at least 8 characters.';
                      }
                      if (newUser.password != value) {
                        return 'Not mached.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Confirm your password.',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 50,
                    width: 500,
                    child: TextButton(
                      child: const Text("Register"),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.purpleAccent,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          register();
                        } else {
                          throw Exception("Could not register");
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        child: const Text("Login",
                            style: TextStyle(
                                color: Colors.purpleAccent,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}

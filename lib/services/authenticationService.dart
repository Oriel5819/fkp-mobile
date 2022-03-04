import 'dart:async';
import 'dart:convert';

import 'package:fkpmobile/api/api.dart';
import 'package:fkpmobile/models/error.dart';
import 'package:fkpmobile/models/user.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  static final AuthenticationService _shared =
      AuthenticationService._sharedInstance();
  AuthenticationService._sharedInstance();

  factory AuthenticationService() => _shared;

  ApiURL api = ApiURL();

  Future<void> register(String name, String email, String password,
      String confirmPassword) async {
    // ignore: avoid_print
    await Future.delayed(
        const Duration(seconds: 2), showRegisteredUser(name, email, password));
  }

  Future<http.Response> logIn(String email, String password) async {
    http.Response response =
        await http.post(Uri.parse(api.HEROKU_URI + 'users/login'),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              "charset": "utf-8"
            },
            body: json.encode({"email": email, "password": password}));

    return response;
    // if (response.statusCode != 200) {
    //   print(JSONResponse);
    // }

    // final user = loginFromJson(response.body);
    // if
    // return user;
  }

  Future<void> logOut() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  showRegisteredUser(String name, String email, String password) {
    print(name);
    print(email);
    print(password);
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:fkpmobile/api/api.dart';
import 'package:fkpmobile/models/error.dart';
import 'package:fkpmobile/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  static final AuthenticationService _shared =
      AuthenticationService._sharedInstance();
  AuthenticationService._sharedInstance();

  factory AuthenticationService() => _shared;

  ApiURL api = ApiURL();

  Future<http.Response> register(String fname, String lname, String email,
      String password, String confirmPassword) async {
    http.Response registered = await http.post(
        Uri.parse(api.HEROKU_URI + "users/register"),
        headers: <String, String>{
          "Content-type": "application/json",
          "Accept": "application/json",
          "charset": "utf-8"
        },
        body: json.encode({
          "firstName": fname,
          "lastName": lname,
          "email": email,
          "password": password
        }));
    return registered;
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
  }

  Future<http.Response> exist(String email) async {
    http.Response exist =
        await http.post(Uri.parse(api.HEROKU_URI + 'users/exist'),
            headers: <String, String>{
              "Content-type": "application/json",
              "Accept": "application/json",
              "charset": "utf-8"
            },
            body: json.encode({"email": email}));
    return exist;
  }

  Future<http.Response> getUser(String id, String token) async {
    http.Response response = await http.get(
      Uri.parse(api.HEROKU_URI + 'users/' + id),
      headers: <String, String>{
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
    );
    return response;
  }

  Future<void> logOut(SharedPreferences localStorage) async {
    /* sending delete request to the api */
    print("Sending delete request to the API...");
    /* sending delete request to the api */

    // removing the localhost in the mobile app
    await localStorage.remove("userID");
    await localStorage.remove("userToken");
  }
}

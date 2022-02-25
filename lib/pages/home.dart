import 'dart:convert';
import 'dart:core';

import 'package:fkpmobile/api/api.dart';
import 'package:fkpmobile/login.dart';
import 'package:fkpmobile/pages/profile.dart';
import 'package:fkpmobile/theme/colors.dart';
import 'package:fkpmobile/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiURL api = ApiURL();
  late Future<List?> _users;

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _id = prefs.getString('id');
    String? token = prefs.getString('token');
    if (token == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      print(_id);
    }
  }

  Future<List?> fetchUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _id = prefs.getString('id');

    // get other users than the logged one

    http.Response response = await http.get(
      Uri.parse(api.URI + "users"),
      headers: <String, String>{
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
    );

    if (response.statusCode == 200) {
      var listedUser = json.decode(response.body) as List;
      return listedUser;
    }
    return null;
  }

  @override
  void initState() {
    _users = fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkToken();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          shadowColor: Colors.deepPurple,
          title: const Text('All users'),
        ),
        body: FutureBuilder<List?>(
          future: _users,
          builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Profile(user: snapshot.data?[index])));
                      },
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius:
                                            BorderRadius.circular(60 / 2),
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://i.pravatar.cc/300"))),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (snapshot.data?[index]['firstName'] !=
                                                    null
                                                ? snapshot.data![index]
                                                    ['firstName']
                                                : "") +
                                            " " +
                                            (snapshot.data?[index]
                                                        ['middleName'] !=
                                                    null
                                                ? snapshot.data![index]
                                                    ['middleName']
                                                : "") +
                                            " " +
                                            (snapshot.data?[index]
                                                        ['lastName'] !=
                                                    null
                                                ? snapshot.data![index]
                                                    ['lastName']
                                                : ""),
                                        // _users[index].firtstName.toString(),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data![index]['email'],
                                        // _users[index].contact.toString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data?[index]['contact'] != null
                                            ? snapshot.data![index]['contact']
                                            : "",
                                        // _users[index].email.toString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                ),
              );
            }
          },
        ));
  }
}

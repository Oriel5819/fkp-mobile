import 'dart:convert';

Employee loginFromJson(String str) => Employee.fromJson(json.decode(str));

String loginToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.isAdmin,
    required this.token,
  });

  String id;
  String firstName;
  String middleName;
  String lastName;
  String email;
  bool isAdmin;
  String token;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["_id"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "email": email,
        "isAdmin": isAdmin,
        "token": token,
      };
}

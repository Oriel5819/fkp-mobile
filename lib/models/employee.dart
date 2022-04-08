// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    required this.id,
    required this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.experiences,
    this.educations,
    this.contact,
  });

  String id;
  String firstName;
  String? middleName;
  String? lastName;
  String? email;
  List<String>? experiences;
  List<dynamic>? educations;
  String? contact;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["_id"],
        firstName: json["firstName"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"],
        experiences: List<String>.from(json["experiences"].map((x) => x)),
        educations: List<dynamic>.from(json["educations"].map((x) => x)),
        contact: json["contact"] == null ? null : json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "middleName": middleName == null ? null : middleName,
        "lastName": lastName == null ? null : lastName,
        "email": email,
        "experiences": List<dynamic>.from(experiences!.map((x) => x)),
        "educations": List<dynamic>.from(educations!.map((x) => x)),
        "contact": contact == null ? null : contact,
      };
}

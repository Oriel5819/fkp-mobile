// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    required this.message,
    this.stack,
  });

  String message;
  dynamic stack;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        stack: json["stack"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "stack": stack,
      };
}

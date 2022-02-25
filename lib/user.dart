class User {
  String? firtstName;
  String? middleName;
  String? lastName;
  String? contact;
  String? email;
  String? password;

  User(this.email, this.password);

  User.fromJSON(json) {
    firtstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    contact = json['contact'];
    email = json['email'];
  }
}

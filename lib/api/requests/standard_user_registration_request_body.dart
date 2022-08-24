import 'dart:io';


class StandardUserRegistrationRequestBody {
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? dob;
  File? avatar;
  String? userType;

  StandardUserRegistrationRequestBody(
    String firstName,
    String lastName,
    String username,
    String email,
    // String password,
    String dob,
    File avatar,
    String userType,
  ) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.email = email;
    // this.password = password;
    this.dob = dob;
    this.avatar = avatar;
    this.userType = userType;
  }
}

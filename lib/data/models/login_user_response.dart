class LoginUserResponse {
  LoginUserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.avatar,
     this.username,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? avatar;
  String? username;
  factory LoginUserResponse.fromJson(Map<String, dynamic> json) =>
      LoginUserResponse(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
           username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "avatar": avatar == null ? null : avatar,
        "username": username == null ? null : username,
      };
}

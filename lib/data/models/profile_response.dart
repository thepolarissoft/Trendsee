import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse extends Baseresponse {
  // ProfileResponse({
  //   int status,
  //   String msg,
  //   int statuscode,
  //   this.user,
  // }) : super(status: status, msg: msg, statuscode: statuscode);
  String tokenType;
  String token;
  VerifiedUserResponse user;

  ProfileResponse.fromJson(Map<String, dynamic> json) : super(json) {
    tokenType = json["token_type"] == null ? null : json["token_type"];
    token = json["token"] == null ? null : json["token"];
    user = json["user"] == null
        ? null
        : VerifiedUserResponse.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "user": user == null ? null : user.toJson(),
      };
}

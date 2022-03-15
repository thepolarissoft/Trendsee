// To parse this JSON data, do
//
//     final verifiedOtpResponse = verifiedOtpResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';

VerifiedOtpResponse verifiedOtpResponseFromJson(String str) =>
    VerifiedOtpResponse.fromJson(json.decode(str));

String verifiedOtpResponseToJson(VerifiedOtpResponse data) =>
    json.encode(data.toJson());

class VerifiedOtpResponse extends Baseresponse {
  // VerifiedOtpResponse({
  //   int status,
  //   String msg,
  //   int statuscode,
  //   this.tokenType,
  //   this.token,
  //   this.user,
  // }) : super(status: status, msg: msg, statuscode: statuscode);

  String tokenType;
  String token;
  VerifiedUserResponse user;

  VerifiedOtpResponse.fromJson(Map<String, dynamic> json) : super(json) {
    tokenType = json["token_type"] == null ? null : json["token_type"];
    token = json["token"] == null ? null : json["token"];
    user = json["user"] == null
        ? null
        : VerifiedUserResponse.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "statuscode": statuscode == null ? null : statuscode,
        "token_type": tokenType == null ? null : tokenType,
        "token": token == null ? null : token,
        "user": user == null ? null : user.toJson(),
      };
}

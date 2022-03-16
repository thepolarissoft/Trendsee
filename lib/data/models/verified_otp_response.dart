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
  // VerifiedUserResponse user;
  VerifiedUserResponse standardUser;
  List<VerifiedUserResponse> businessUsers;

  VerifiedOtpResponse.fromJson(Map<String, dynamic> json) : super(json) {
    tokenType = json["token_type"] == null ? null : json["token_type"];
    token = json["token"] == null ? null : json["token"];
    businessUsers = json["business_users"] == null
        ? null
        : List<VerifiedUserResponse>.from(json["business_users"]
            .map((x) => VerifiedUserResponse.fromJson(x)));
    standardUser = json["standard_user"] == null
        ? null
        : VerifiedUserResponse.fromJson(json["standard_user"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "statuscode": statuscode == null ? null : statuscode,
        "token_type": tokenType == null ? null : tokenType,
        "token": token == null ? null : token,
        "business_users": businessUsers == null
            ? null
            : List<dynamic>.from(businessUsers.map((x) => x.toJson())),
        "standard_user": standardUser == null ? null : standardUser.toJson(),
      };
}

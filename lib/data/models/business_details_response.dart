// // To parse this JSON data, do
// //
// //     final businessDetailsResponse = businessDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/verified_user_response.dart';

// BusinessDetailsResponse businessDetailsResponseFromJson(String str) =>
//     BusinessDetailsResponse.fromJson(json.decode(str));

// class BusinessDetailsResponse extends Baseresponse {
//   VerifiedUserResponse business;

//   BusinessDetailsResponse.fromJson(Map<String, dynamic> json) : super(json) {
//     business = json["business"] == null
//         ? null
//         : VerifiedUserResponse.fromJson(json["business"]);
//   }
// }

BusinessDetailsResponse businessDetailsResponseFromJson(String str) =>
    BusinessDetailsResponse.fromJson(json.decode(str));

String businessDetailsResponseToJson(BusinessDetailsResponse data) =>
    json.encode(data.toJson());

class BusinessDetailsResponse {
  BusinessDetailsResponse({
    this.status,
    this.statuscode,
    this.msg,
    this.business,
  });

  int status;
  int statuscode;
  String msg;
  VerifiedUserResponse business;

  factory BusinessDetailsResponse.fromJson(Map<String, dynamic> json) =>
      BusinessDetailsResponse(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
        business: json["business"] == null
            ? null
            : VerifiedUserResponse.fromJson(json["business"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "business": business == null ? null : business.toJson(),
      };
}

// To parse this JSON data, do
//
//     final updateListKeywordsResponse = updateListKeywordsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';

UpdateListKeywordsResponse updateListKeywordsResponseFromJson(String str) =>
    UpdateListKeywordsResponse.fromJson(json.decode(str));

String updateListKeywordsResponseToJson(UpdateListKeywordsResponse data) =>
    json.encode(data.toJson());

class UpdateListKeywordsResponse extends Baseresponse {
  String? businessKeywords;

  // factory UpdateListKeywordsResponse.fromJson(Map<String, dynamic> json) =>
  //     UpdateListKeywordsResponse(
  //       status: json["status"] == null ? null : json["status"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       businessKeywords: json["business_keywords"] == null
  //           ? null
  //           : json["business_keywords"],
  //     );

  UpdateListKeywordsResponse.fromJson(Map<String, dynamic> json) : super(json) {
    businessKeywords =
        json["business_keywords"] == null ? null : json["business_keywords"];
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "statuscode": statuscode == null ? null : statuscode,
        "business_keywords": businessKeywords == null ? null : businessKeywords,
      };
}

// To parse this JSON data, do
//
//     final searchBusinessKeywordsResponse = searchBusinessKeywordsResponseFromJson(jsonString);

import 'dart:convert';

SearchBusinessKeywordsResponse searchBusinessKeywordsResponseFromJson(
        String str) =>
    SearchBusinessKeywordsResponse.fromJson(json.decode(str));

String searchBusinessKeywordsResponseToJson(
        SearchBusinessKeywordsResponse data) =>
    json.encode(data.toJson());

class SearchBusinessKeywordsResponse {
  SearchBusinessKeywordsResponse({
    this.status,
    this.statuscode,
    this.msg,
    this.data,
  });

  int? status;
  int? statuscode;
  String? msg;
  List<String>? data;

  factory SearchBusinessKeywordsResponse.fromJson(Map<String, dynamic> json) =>
      SearchBusinessKeywordsResponse(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x)),
      };
}

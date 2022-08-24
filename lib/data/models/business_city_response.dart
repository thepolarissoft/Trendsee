// To parse this JSON data, do
//
//     final businessCityResponse = businessCityResponseFromJson(jsonString);

import 'dart:convert';

BusinessCityResponse businessCityResponseFromJson(String str) =>
    BusinessCityResponse.fromJson(json.decode(str));

String businessCityResponseToJson(BusinessCityResponse data) =>
    json.encode(data.toJson());

class BusinessCityResponse {
  BusinessCityResponse({
    this.status,
    this.statuscode,
    this.msg,
    this.data,
  });

  int? status;
  int? statuscode;
  String? msg;
  List<String>? data;

  factory BusinessCityResponse.fromJson(Map<String, dynamic> json) =>
      BusinessCityResponse(
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

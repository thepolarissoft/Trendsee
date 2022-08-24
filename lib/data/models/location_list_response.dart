// To parse this JSON data, do
//
//     final locationListResponse = locationListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';

LocationListResponse locationListResponseFromJson(String str) =>
    LocationListResponse.fromJson(json.decode(str));

String locationListResponseToJson(LocationListResponse data) =>
    json.encode(data.toJson());

class LocationListResponse extends Baseresponse {
  // LocationListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.location,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  List<Location>? location;

  LocationListResponse.fromJson(Map<String, dynamic> json) : super(json) {
    location = json["location"] == null
        ? null
        : List<Location>.from(
            json["location"].map((x) => Location.fromJson(x)));
  }
  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    this.city,
  });

  String? city;
  bool isChecked = false;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"] == null ? null : json["city"],
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
      };
}

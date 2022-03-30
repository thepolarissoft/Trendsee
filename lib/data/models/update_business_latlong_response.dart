// To parse this JSON data, do
//
//     final updateBusinessLatlongResponse = updateBusinessLatlongResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';

BusinessLatlongResponse updateBusinessLatlongResponseFromJson(String str) =>
    BusinessLatlongResponse.fromJson(json.decode(str));

class BusinessLatlongResponse extends Baseresponse {
  int status;
  String msg;
  int statuscode;
  List<LatLongInfo> latLong;

  BusinessLatlongResponse.fromJson(Map<String, dynamic> json) : super(json) {
    status = json["status"] == null ? null : json["status"];
    msg = json["msg"] == null ? null : json["msg"];
    statuscode = json["statuscode"] == null ? null : json["statuscode"];
    latLong = json["lat_long"] == null
        ? null
        : List<LatLongInfo>.from(
            json["lat_long"].map((x) => LatLongInfo.fromJson(x)));
  }
}

class LatLongInfo {
  LatLongInfo({
    this.id,
    this.latitude,
    this.longitude,
    this.locationName,
    this.isDefault,
  });
  int id;
  String latitude;
  String longitude;
  String locationName;
  int isDefault;

  factory LatLongInfo.fromJson(Map<String, dynamic> json) => LatLongInfo(
        id: json["id"] == null ? null : json["id"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"]).toStringAsFixed(5),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"]).toStringAsFixed(5),
        locationName:
            json["location_name"] == null ? null : json["location_name"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
      );
}

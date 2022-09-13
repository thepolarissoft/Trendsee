// To parse this JSON data, do
//
//     final businessUserProfileResponse = businessUserProfileResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/data/models/update_business_latlong_response.dart';

BusinessUserProfileResponse businessUserProfileResponseFromJson(String str) =>
    BusinessUserProfileResponse.fromJson(json.decode(str));

class BusinessUserProfileResponse extends Baseresponse {
  // BusinessUserProfileResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.user,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  BusinessUserResponse? user;
  List<LatLongInfo>? latLong;

  BusinessUserProfileResponse.fromJson(Map<String, dynamic> json)
      : super(json) {
    user = json["user"] == null
        ? null
        : BusinessUserResponse.fromJson(json["user"]);
    latLong = json["lat_long"] == null
        ? null
        : List<LatLongInfo>.from(
            json["lat_long"].map((x) => LatLongInfo.fromJson(x)),
          );
  }
}

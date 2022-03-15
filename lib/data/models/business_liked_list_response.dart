// To parse this JSON data, do
//
//     final businessListResponse = businessListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/pagination_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';

BusinessLikedListResponse businessListResponseFromJson(String str) =>
    BusinessLikedListResponse.fromJson(json.decode(str));

class BusinessLikedListResponse extends Baseresponse {
  // BusinessLikedListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.place,
  // });

  Business place;
  BusinessLikedListResponse.fromJson(Map<String, dynamic> json) : super(json) {
    place = json["place"] == null ? null : Business.fromJson(json["place"]);
  }
  // factory BusinessLikedListResponse.fromJson(Map<String, dynamic> json) =>
  //     BusinessLikedListResponse(
  //       status: json["status"] == null ? null : json["status"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //       place: json["place"] == null ? null : Business.fromJson(json["place"]),
  //     );

  // Map<String, dynamic> toJson() => {
  //       "status": status == null ? null : status,
  //       "statuscode": statuscode == null ? null : statuscode,
  //       "msg": msg == null ? null : msg,
  //       "business": place == null ? null : place.toJson(),
  //     };
}

class Business extends PaginationResponse {
  Business({
    this.data,
    int currentPage,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    List<Link> links,
    dynamic nextPageUrl,
    String path,
    int perPage,
    dynamic prevPageUrl,
    int to,
    int total,
  }) : super(
            currentPage: currentPage,
            firstPageUrl: firstPageUrl,
            from: from,
            lastPage: lastPage,
            lastPageUrl: lastPageUrl,
            links: links,
            nextPageUrl: nextPageUrl,
            path: path,
            perPage: perPage,
            prevPageUrl: prevPageUrl,
            to: to,
            total: total);

  List<VerifiedUserResponse> data;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        data: json["data"] == null
            ? null
            : List<VerifiedUserResponse>.from(
                json["data"].map((x) => VerifiedUserResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

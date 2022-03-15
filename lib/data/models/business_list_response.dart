// To parse this JSON data, do
//
//     final businessListResponse = businessListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/pagination_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';

BusinessListResponse businessListResponseFromJson(String str) =>
    BusinessListResponse.fromJson(json.decode(str));

// String businessListResponseToJson(BusinessListResponse data) =>
//     json.encode(data.toJson());

class BusinessListResponse extends Baseresponse {
  // BusinessListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.business,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  Business business;

  // factory BusinessListResponse.fromJson(Map<String, dynamic> json) =>
  //     BusinessListResponse(
  //       status: json["status"] == null ? null : json["status"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //       business: json["business"] == null
  //           ? null
  //           : Business.fromJson(json["business"]),
  //     );

  BusinessListResponse.fromJson(Map<String, dynamic> json) : super(json) {
    status = json["status"] == null ? null : json["status"];
    statuscode = json["statuscode"] == null ? null : json["statuscode"];
    msg = json["msg"] == null ? null : json["msg"];
    business =
        json["business"] == null ? null : Business.fromJson(json["business"]);
  }
  // Map<String, dynamic> toJson() => {
  //       "status": status == null ? null : status,
  //       "statuscode": statuscode == null ? null : statuscode,
  //       "msg": msg == null ? null : msg,
  //       "business": business == null ? null : business.toJson(),
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
        currentPage: json["current_page"] == null ? null : json["current_page"],
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "current_page": currentPage == null ? null : currentPage,
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "links": links == null
            ? null
            : List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}

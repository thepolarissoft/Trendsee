// To parse this JSON data, do
//
//     final dislikedCommentsResponse = dislikedCommentsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/comment_response.dart';
import 'package:trendoapp/data/models/pagination_response.dart';

DislikedCommentsResponse dislikedCommentsResponseFromJson(String str) =>
    DislikedCommentsResponse.fromJson(json.decode(str));

String dislikedCommentsResponseToJson(DislikedCommentsResponse data) =>
    json.encode(data.toJson());

class DislikedCommentsResponse {
  DislikedCommentsResponse({
    this.status,
    this.statuscode,
    this.msg,
    this.dislike,
  });

  int status;
  int statuscode;
  String msg;
  DislikedInfo dislike;

  factory DislikedCommentsResponse.fromJson(Map<String, dynamic> json) =>
      DislikedCommentsResponse(
        status: json["status"] == null ? null : json["status"],
        statuscode: json["statuscode"] == null ? null : json["statuscode"],
        msg: json["msg"] == null ? null : json["msg"],
        dislike: json["dislike"] == null
            ? null
            : DislikedInfo.fromJson(json["dislike"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "dislike": dislike == null ? null : dislike.toJson(),
      };
}

class DislikedInfo {
  DislikedInfo({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<CommentResponse> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory DislikedInfo.fromJson(Map<String, dynamic> json) => DislikedInfo(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<CommentResponse>.from(
                json["data"].map((x) => CommentResponse.fromJson(x))),
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
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
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

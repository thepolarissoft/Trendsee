// To parse this JSON data, do
//
//     final getCommentListResponse = getCommentListResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';

CommentListResponse commentListResponseFromJson(String str) =>
    CommentListResponse.fromJson(json.decode(str));

String commentListResponseToJson(CommentListResponse data) =>
    json.encode(data.toJson());

class CommentListResponse extends Baseresponse {
  // CommentListResponse({
  //   int status,
  //   int statuscode,
  //   String msg,
  //   this.feed,
  // }) : super(status: status, statuscode: statuscode, msg: msg);

  FeedResponse? feed;

  // factory CommentListResponse.fromJson(Map<String, dynamic> json) =>
  //     CommentListResponse(
  //       status: json["status"] == null ? null : json["status"],
  //       statuscode: json["statuscode"] == null ? null : json["statuscode"],
  //       msg: json["msg"] == null ? null : json["msg"],
  //       feed: json["feed"] == null ? null : FeedResponse.fromJson(json["feed"]),
  //     );

  CommentListResponse.fromJson(Map<String, dynamic> json) : super(json) {
    feed = json["feed"] == null ? null : FeedResponse.fromJson(json["feed"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "statuscode": statuscode == null ? null : statuscode,
        "msg": msg == null ? null : msg,
        "feed": feed == null ? null : feed!.toJson(),
      };
}

// To parse this JSON data, do
//
//     final likeDislikeResponse = likeDislikeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/feed_response.dart';

LikeDislikeResponse likeDislikeResponseFromJson(String str) =>
    LikeDislikeResponse.fromJson(json.decode(str));

String likeDislikeResponseToJson(LikeDislikeResponse data) =>
    json.encode(data.toJson());

class LikeDislikeResponse extends Baseresponse {
  // LikeDislikeResponse({
  //   int status,
  //   String msg,
  //   int statuscode,
  //   this.feed,
  // }) : super(status: status, msg: msg, statuscode: statuscode);

  FeedResponse feed;

  LikeDislikeResponse.fromJson(Map<String, dynamic> json) : super(json) {
    feed = json["feed"] == null ? null : FeedResponse.fromJson(json["feed"]);
  }

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "msg": msg == null ? null : msg,
        "statuscode": statuscode == null ? null : statuscode,
        "feed": feed == null ? null : feed.toJson(),
      };
}

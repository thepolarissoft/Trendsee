import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/home_feed_like_dislike_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class HomeFeedLikeDislikeRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.like_dislike_home_feed_url;

  @override
  Object body;

  @override
  HttpMethod httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  HomeFeedLikeDislikeRequest(
      HomeFeedLikeDislikeRequestBody homeFeedLikeDislikeRequestBody) {
    var map = new Map<String, String>();
    map["feed_id"] = homeFeedLikeDislikeRequestBody.feedId;
    map["is_like"] = homeFeedLikeDislikeRequestBody.isLike;
    map["is_dislike"] = homeFeedLikeDislikeRequestBody.isDislike;
    var msg = jsonEncode(map);
    this.body = msg;
  }
}

import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/home_feed_like_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class HomeFeedLikeRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.like_home_feed_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  HomeFeedLikeRequest(HomeFeedLikeRequestBody homeFeedLikeRequestBody) {
    var map = new Map<String, String>();
    map["feed_id"] = homeFeedLikeRequestBody.feedId.toString();
    map["is_like"] = homeFeedLikeRequestBody.isLike.toString();
    this.body = jsonEncode(map);
    print("HomeFeedLikeRequestBody-->> $body");

    
  }
}

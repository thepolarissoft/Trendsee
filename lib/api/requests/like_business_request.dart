import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/like_business_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class LikeBusinessRequest implements IHttpRequest {
  String businessId;
  @override
  String absolutePath = ApiUrls.like_business_url;

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

  LikeBusinessRequest(LikeBusinessRequestBody likeBusinessRequestBody) {
    var map = Map<String, String>();
    map["business_id"] = likeBusinessRequestBody.businessId;
    this.body = jsonEncode(map);
  }
}

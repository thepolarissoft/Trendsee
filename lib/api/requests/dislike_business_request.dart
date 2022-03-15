import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/dislike_business_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class DislikeBusinessRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.dislike_business_url;

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

  DislikeBusinessRequest(
      DislikeBusinessRequestBody dislikeBusinessRequestBody) {
    var map = Map<String, String>();
    map["business_id"] = dislikeBusinessRequestBody.businessId.toString();
    map["reason"] = dislikeBusinessRequestBody.reason;
    map["action"] = dislikeBusinessRequestBody.action.toString();
    this.body = jsonEncode(map);
    print("DislikeBusinessRequestBody-> $body");
  }
}

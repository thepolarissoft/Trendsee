import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/create_feed_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class CreateFeedRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.create_feed_url;

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

  CreateFeedRequest(CreateFeedRequestBody createFeedRequestBody) {
    var map = Map<String, String?>();
    map["description"] = createFeedRequestBody.description;
    map["business_user_id"] = createFeedRequestBody.businessUserId;
    map["category_id"] = createFeedRequestBody.categoryId != null
        ? createFeedRequestBody.categoryId
        : "0";
    map["latitude"] = createFeedRequestBody.latitude;
    map["longitude"] = createFeedRequestBody.longitude;
    map["location_name"] = createFeedRequestBody.locationName;
    var msg = jsonEncode(map);
    this.body = msg;
    print("CreateFeedRequestBody-->> $body");
  }
}

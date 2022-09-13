import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/delete_business_latlong_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class DeleteBusinessLatlongRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.delete_business_latlong_url;

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

  DeleteBusinessLatlongRequest(
      DeleteBusinessLatlongRequestBody deleteBusinessLatlongRequestBody) {
    var map = new Map<String, String>();
    map["business_location_id"] =
        deleteBusinessLatlongRequestBody.businessLocationId.toString();
    this.body = jsonEncode(map);
    print("deleteBusinessLatlongRequestBody-> $body");
  }
}

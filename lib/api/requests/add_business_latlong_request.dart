import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/add_business_latlong_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class AddBusinessLatlongRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.add_business_latlong_url;

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

  AddBusinessLatlongRequest(
      AddBusinessLatlongRequestBody addBusinessLatlongRequestBody) {
    var map = new Map<String, String>();
    map["latitude"] = addBusinessLatlongRequestBody.latitude;
    map["longitude"] = addBusinessLatlongRequestBody.longitude;
    map["is_default"] = addBusinessLatlongRequestBody.isDefault.toString();
    map["business_location_id"] =
        addBusinessLatlongRequestBody.businessLocationId.toString();
    this.body = jsonEncode(map);
    print("addBusinessLatlongRequestBody-> $body");
  }
}

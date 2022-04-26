import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/add_unregistered_business_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class AddUnregisteredBusinessRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.add_unregistered_business_url;

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

  AddUnregisteredBusinessRequest(
      AddUnregisteredBusinessRequestBody addUnregisteredBusinessRequestBody) {
    var map = Map<String, String>();
    map['business_name'] = addUnregisteredBusinessRequestBody.businessName;
    map['latitude'] = addUnregisteredBusinessRequestBody.latitude;
    map['longitude'] = addUnregisteredBusinessRequestBody.longitude;
    map['category_ids'] = addUnregisteredBusinessRequestBody.categoryId;
    map['business_username'] =
        addUnregisteredBusinessRequestBody.businessUsername;
    this.body = jsonEncode(map);
    print('AddUnregisteredBusinessRequestBody-> $body');
  }
}

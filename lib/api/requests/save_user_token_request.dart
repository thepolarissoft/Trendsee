import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/save_user_token_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SaveUserTokenRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.save_user_token_url;

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

  SaveUserTokenRequest(SaveUserTokenRequestBody saveUserTokenRequestBody) {
    var map = Map<String, String>();
    map['platform'] = saveUserTokenRequestBody.platform.toString();
    map['token'] = saveUserTokenRequestBody.token;
    this.body = jsonEncode(map);
    print("SaveUserTokenRequestBody-> $body");
  }
}

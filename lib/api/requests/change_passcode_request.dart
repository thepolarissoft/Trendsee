import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/change_passcode_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class ChangePasscodeRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.change_passcode_url;

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

  ChangePasscodeRequest(ChangePasscodeRequestBody changePasscodeRequestBody) {
    var map = Map<String, String>();
    map['old_passcode'] = changePasscodeRequestBody.oldPasscode;
    map['new_passcode'] = changePasscodeRequestBody.newPasscode;
    body = jsonEncode(map);
    print("ChangePasscodeRequestBody $body");
  }
}

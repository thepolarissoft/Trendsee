import 'dart:convert';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/verify_passcode_by_business_id_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class VerifyPasscodeByBusinessIdRequest implements IHttpRequest {
  int businessId;
  int passcode;
  @override
  String absolutePath = ApiUrls.verify_passcode_by_id_url;

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

  VerifyPasscodeByBusinessIdRequest(
      VerifyPasscodeByBusinessIdRequestBody
          verifyPasscodeByBusinessIdRequestBody) {
    var map = Map<String, String>();
    map['business_id'] =
        verifyPasscodeByBusinessIdRequestBody.businessId.toString();
    map['passcode'] = verifyPasscodeByBusinessIdRequestBody.passcode.toString();
    this.body = jsonEncode(map);
    print("VerifyPasscodeByBusinessIdRequestBody $body");
  }
}

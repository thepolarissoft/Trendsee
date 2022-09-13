import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/verify_otp_by_business_id_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class VerifyOtpByBusinessIdRequest implements IHttpRequest {
  int? businessId;
  @override
  String? absolutePath = ApiUrls.verify_otp_by_id_url;

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
    Map<String, String> map = {"business_id": businessId.toString()};
    print("SendOtpByIdRequest $map");
    return map;
  }

  VerifyOtpByBusinessIdRequest(
      VerifyOtpByBusinessIdRequestBody verifyOtpByBusinessIdRequestBody) {
    var map = Map<String, String>();
    map['business_id'] = verifyOtpByBusinessIdRequestBody.businessId.toString();
    map['otp'] = verifyOtpByBusinessIdRequestBody.otp.toString();
    this.body = jsonEncode(map);
    print("VerifyOtpByBusinessIdRequest $body");
  }
}

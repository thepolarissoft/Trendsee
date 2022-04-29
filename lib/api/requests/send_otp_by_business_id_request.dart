import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SendOtpByBusinessIdRequest implements IHttpRequest {
  int businessId;
  @override
  String absolutePath = ApiUrls.send_otp_by_id_url;

  @override
  Object body;

  @override
  HttpMethod httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    log("businessId FROM Request $businessId");
    Map<String, String> map = {"business_id": businessId.toString()};
    print("SendOtpByIdRequest $map");
    return map;
  }

  SendOtpByBusinessIdRequest({@required this.businessId});
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/verify_otp_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class VerifyOtpRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.verify_otp_url;

  @override
  Object body;

  @override
  HttpMethod httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return Map<String, String>();
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  VerifyOtpRequest(VerifyOtpRequestBody verifyOtpRequestBody) {
    var map = new Map<String, String>();
    map["email"] = verifyOtpRequestBody.email;
    map["otp"] = verifyOtpRequestBody.otp;

    this.body = map;
    print("VerifyOtpRequestBody-> $body");
  }
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/send_otp_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SendOtpRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.send_otp_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return Map<String, String>();
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  SendOtpRequest(SendOtpRequestBody sendOtpRequestBody) {
    var map = Map<String, String?>();
    map["email"] = sendOtpRequestBody.email;
    this.body = map;
    print("SendOtpRequestBody $body");
  }
}

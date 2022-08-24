import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/verify_passcode_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class VerifyPasscodeRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.verify_passcode_new_url;

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

  VerifyPasscodeRequest(VerifyPasscodeRequestBody verifyPasscodeRequestBody) {
    var map = new Map<String, String?>();
    map["email"] = verifyPasscodeRequestBody.email;
    map["passcode"] = verifyPasscodeRequestBody.passcode;
    this.body = map;
    print("VerifyPasscodeRequestBody-> $body");
  }
}

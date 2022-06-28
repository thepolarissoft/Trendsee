import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/set_passcode_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SetPasscodeRequest implements IHttpRequest {
  @override
  String absolutePath = ApiUrls.set_passcode_url;

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

  SetPasscodeRequest(SetPasscodeRequestBody setPasscodeRequestBody) {
    var map = new Map<String, String>();
    map["email"] = setPasscodeRequestBody.email;
    map["passcode"] = setPasscodeRequestBody.passcode;
    this.body = map;
    print("SetPasscodeRequestBody-> $body");
  }
}

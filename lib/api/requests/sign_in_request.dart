import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/sign_in_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SignInRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.signin_url;

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

  SignInRequest(SignInRequestBody signInRequestBody) {
    var map = Map<String, String?>();
    map['userInput'] = signInRequestBody.userInput;
    this.body = map;
  }
}

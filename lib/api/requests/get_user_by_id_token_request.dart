import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetUserByIdTokenRequest implements IHttpRequest {
  int userId;
  @override
  String absolutePath = ApiUrls.user_by_id_with_token_url;

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
    var map = Map<String, String>();
    map = {"user_id": userId.toString()};
    print("UserByIdWithTokenRequest parameters $map");
    return map;
  }

  GetUserByIdTokenRequest(int userId) {
    this.userId = userId;
  }
}

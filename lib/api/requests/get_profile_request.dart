import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetProfileRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.profile_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }
}

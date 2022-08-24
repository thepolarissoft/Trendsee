import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetBusinessLikedListRequest implements IHttpRequest {
  String page = "";
  @override
  String? absolutePath = ApiUrls.list_liked_business_url;

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
    Map<String, String> map = Map<String, String>();
    map = {"page": page};
    return map;
  }

  GetBusinessLikedListRequest(String page) {
    this.page = page;
  }
}

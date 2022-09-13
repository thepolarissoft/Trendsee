import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class UpdateListKeywordsRequest implements IHttpRequest {
  String businessKeywords = "";
  @override
  String? absolutePath = ApiUrls.update_list_keywords_url;

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
    var map = new Map<String, String>();
    map = {"business_keywords": businessKeywords};
    return map;
  }

  UpdateListKeywordsRequest(String businessKeywords) {
    this.businessKeywords = businessKeywords;
  }
}

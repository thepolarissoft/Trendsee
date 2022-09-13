import 'package:flutter/cupertino.dart';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SearchBusinessKeywordsRequest implements IHttpRequest {
  String searchValue = "";
  @override
  String? absolutePath = ApiUrls.search_business_keywords_url;

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
    var map = Map<String, String>();
    map['search_value'] = searchValue;
    print("SearchBusinessKeywordsRequest--> $map");
    return map;
  }

  SearchBusinessKeywordsRequest({required this.searchValue});
}

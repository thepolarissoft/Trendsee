import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetBusinessListByNameRequest implements IHttpRequest {
  int page = 1;
  String searchValue = "";
  @override
  String? absolutePath = ApiUrls.list_business_by_name_url;

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
    map = {
      "page": page.toString(),
      "search_value": searchValue,
    };
    return map;
  }

  GetBusinessListByNameRequest(int page, String searchValue) {
    this.page = page;
    this.searchValue = searchValue;
  }
}

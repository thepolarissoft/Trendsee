import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetCategoriesListRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.categories_list_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic> get headers {
    return Map<String, String>();
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetNotificationsListRequest implements IHttpRequest {
  int? page;
  @override
  String? absolutePath = ApiUrls.list_notifications_url;

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
    Map<String, String> map = new Map<String, String>();
    map = {"page": page.toString()};
    return map;
  }

  GetNotificationsListRequest(int page) {
    this.page = page;
  }
}

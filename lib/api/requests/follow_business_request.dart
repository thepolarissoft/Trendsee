import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class FollowBusinessRequest implements IHttpRequest {
  String? businessId;
  @override
  String? absolutePath = ApiUrls.follow_business_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String?> get parameters {
    Map<String, String?> map = Map<String, String>();
    map = {"business_id": businessId};
    return map;
  }

  FollowBusinessRequest(String businessId) {
    this.businessId = businessId;
  }
}

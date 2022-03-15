import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class UnfollowBusinessRequest implements IHttpRequest {
  String businessId;
  @override
  String absolutePath = ApiUrls.unfollow_business_url;

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
    map = {"business_id": businessId};
    return map;
  }

  UnfollowBusinessRequest(String businessId) {
    this.businessId = businessId;
  }
}

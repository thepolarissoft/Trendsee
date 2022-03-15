import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class DislikedCommentsRequest implements IHttpRequest {
  int page;
  int businessId;
  @override
  String absolutePath = ApiUrls.list_disliked_business_url;

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
    var map = new Map<String, String>();
    map = {
      "page": page.toString(),
      "business_id": businessId.toString(),
    };
    return map;
  }

  DislikedCommentsRequest(int page, int businessId) {
    this.page = page;
    this.businessId = businessId;
  }
}

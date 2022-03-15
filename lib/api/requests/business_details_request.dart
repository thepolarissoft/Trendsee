import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class BusinessDetailsRequest implements IHttpRequest {
  int businessId;
  @override
  String absolutePath = ApiUrls.business_details_url;

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
    Map<String, String> map = new Map<String, String>();
    map = {"business_id": businessId.toString()};
    return map;
  }

  BusinessDetailsRequest(int businessId) {
    this.businessId = businessId;
  }
}

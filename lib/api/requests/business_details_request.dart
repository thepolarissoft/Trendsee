import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class BusinessDetailsRequest implements IHttpRequest {
  int? businessId;
  String? latitude, longitude;
  @override
  String? absolutePath = ApiUrls.business_details_url;

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
    Map<String, String?> map = new Map<String, String>();
    map = {
      "business_id": businessId.toString(),
      "latitude": latitude,
      "longitude": longitude,
    };
    return map;
  }

  BusinessDetailsRequest(int? businessId, String latitude, String longitude) {
    this.businessId = businessId;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetBusinessListRequest implements IHttpRequest {
  int page = 1;
  String latitude = "";
  String longitude = "";
  String distance = "";
  @override
  String absolutePath = ApiUrls.business_list_url;

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
      "latitude": latitude,
      "longitude": longitude,
      "distance":
          //  distance != null && distance.length > 1
          //     ? FeetToMilesUtils()
          //         .convertToMiles(double.parse(distance))
          //         .toStringAsFixed(5)
          //     : "",
          distance,
    };
    return map;
  }

  GetBusinessListRequest(
      int page, String latitude, String longitude, String distance) {
    this.page = page;
    this.latitude = latitude;
    this.longitude = longitude;
    this.distance = distance;
  }
}

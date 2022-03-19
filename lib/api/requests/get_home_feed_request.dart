import 'dart:developer';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/utils/feet_to_miles_utils.dart';

class GetHomeFeedRequest implements IHttpRequest {
  String page = "";
  String categoryId = "";
  String latitude = "";
  String longitude = "";
  String distance = "";
  String cityName = "";
  @override
  String absolutePath = ApiUrls.home_feed_list_url;

  @override
  Object body;

  @override
  HttpMethod httpMethod = HttpMethod.GET;

  @override
  Map<String, dynamic> get headers {
    log("IHttpRequest.defaultHeader-->> ${IHttpRequest.defaultHeader}");
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    Map<String, String> map = new Map<String, String>();
    print("DISTANCE IN FEET-> $distance");
    map = {
      "page": page,
      "category_id": categoryId,
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
      "city_name": cityName
      // != null && distance.length > 1
      //     ? FeetToMilesUtils()
      //         .convertToMiles(double.parse(distance))
      //         .toStringAsFixed(5)
      //     : "",
    };
    // if (distance != null && distance.length > 1) {
    //   print(
    //       "DISTANCE IN MILES-> ${FeetToMilesUtils().convertToMiles(double.parse(distance)).toStringAsFixed(5)}");
    // }
    print("Home MAP-> $map");
    return map;
  }

  GetHomeFeedRequest(String page, String categoryId, String latitude,
      String longitude, String distance, String cityName) {
    this.page = page;
    this.categoryId = categoryId;
    this.latitude = latitude;
    this.longitude = longitude;
    this.distance = distance;
    this.cityName = cityName;
  }
}

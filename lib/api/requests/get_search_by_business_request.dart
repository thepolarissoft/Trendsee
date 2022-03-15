import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/utils/feet_to_miles_utils.dart';

class GetSearchByBusinessRequest implements IHttpRequest {
  String page;
  String searchValue;
  String categoryId;
  String latitude;
  String longitude;
  String distance;
  String cityName;
  @override
  String absolutePath = ApiUrls.search_by_business_url;

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
    print("DISTANCE IN FEET-> $distance");
    map = {
      "page": page,

      "category_id": categoryId,
      "latitude": latitude,
      "longitude": longitude,
      "distance": distance,
      "search_value":
          // //  searchValue.trim(),
          // searchValue.indexOf(' ').bitLength >= 2
          //     ? searchValue.replaceAll('  ', ' ')
          //     : searchValue,
          searchValue,
      "city_name": cityName,
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
    print("Search Map Data-> $map");
    return map;
  }

  GetSearchByBusinessRequest(String page, String searchValue, String categoryId,
      String latitude, String longitude, String distance, String cityName) {
    this.page = page;
    this.searchValue = searchValue;
    this.categoryId = categoryId;
    this.latitude = latitude;
    this.longitude = longitude;
    this.distance = distance;
    this.cityName = cityName;
  }
}

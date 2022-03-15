import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/add_business_hours_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class AddBusinessHoursRequest implements IHttpRequest {
  String userId;
  String dayNumbers;
  String startTimes;
  String endTimes;
  String businessTimeZone;
  @override
  String absolutePath = ApiUrls.add_business_time_url;

  @override
  Object body;

  @override
  HttpMethod httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  AddBusinessHoursRequest(
      AddBusinessHoursRequestBody addBusinessHoursRequestBody) {
    var map = Map<String, String>();
    map['day_numbers'] = addBusinessHoursRequestBody.dayNumbers;
    map['start_times'] = addBusinessHoursRequestBody.startTimes;
    map['end_times'] = addBusinessHoursRequestBody.endTimes;
    map['business_time_zone'] = addBusinessHoursRequestBody.businessTimeZone;
    this.body = jsonEncode(map);
    print("AddBusinessHoursRequestBody-> $body");
  }
}

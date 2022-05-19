import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetFeedsByIdRequest implements IHttpRequest {
  String businessUserId;
  int page;
  @override
  String absolutePath = ApiUrls.feeds_by_id_url;

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
    map = {"business_user_id": businessUserId, "page": page.toString()};
    log("GetFeedsByIdRequest Map-> $map");
    return map;
  }

  GetFeedsByIdRequest({@required this.businessUserId, @required this.page});
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetListBusinessHomeFeedRequest implements IHttpRequest {
  String page = "";
  @override
  String absolutePath = ApiUrls.list_business_home_feed_url;

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
    map = {"page": page};
    print("MAP->> $map");
    return map;
  }

  GetListBusinessHomeFeedRequest(String page) {
    this.page = page;
  }
}

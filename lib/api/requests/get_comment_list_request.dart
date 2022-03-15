import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetCommentListRequest implements IHttpRequest {
  String feedId = "";
  @override
  String absolutePath = ApiUrls.get_one_feed_url;

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
    map = {"feed_id": feedId};
    return map;
  }

  GetCommentListRequest(String feedId) {
    this.feedId = feedId;
  }
}

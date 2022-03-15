import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class DeleteFeedRequest implements IHttpRequest {
  String feedId;
  @override
  String absolutePath = ApiUrls.delete_feed_url;

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
    map = {"feed_id": feedId};
    return map;
  }

  DeleteFeedRequest(String feedId) {
    this.feedId = feedId;
  }
}

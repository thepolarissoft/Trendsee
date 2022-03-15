import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GraphLikeRequest implements IHttpRequest {
  int businessUserId;
  String graphRange;
  @override
  String absolutePath = ApiUrls.graph_likes_url;

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
      "business_user_id": this.businessUserId.toString(),
      "graph_range": this.graphRange,
    };
    return map;
  }

  GraphLikeRequest(int businessUserId, String graphRange) {
    this.businessUserId = businessUserId;
    this.graphRange = graphRange;
  }
}

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/api_urls.dart';

class GetMyCheckInsRequest implements IHttpRequest {
  String page = "";
  @override
  String absolutePath = ApiUrls.mycheck_ins_list_url;

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
    map = {"page": page};
    return map;
  }

  GetMyCheckInsRequest(String page) {
    this.page = page;
  }
}

import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/create_comment_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class CreateCommentRequest implements IHttpRequest {
  @override
  String? absolutePath = ApiUrls.create_comment_url;

  @override
  Object? body;

  @override
  HttpMethod? httpMethod = HttpMethod.POST;

  @override
  Map<String, dynamic> get headers {
    return IHttpRequest.defaultHeader;
  }

  @override
  Map<String, String> get parameters {
    return Map<String, String>();
  }

  CreateCommentRequest(CreateCommentRequestBody createCommentRequestBody) {
    var map = new Map<String, String?>();
    map["feed_id"] = createCommentRequestBody.feedId;
    map["comment"] = createCommentRequestBody.comment;
    this.body = jsonEncode(map);
  }
}

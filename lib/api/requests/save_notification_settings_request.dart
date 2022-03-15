import 'dart:convert';

import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/api/requests/save_notification_settings_request_body.dart';
import 'package:trendoapp/constants/api_urls.dart';

class SaveNotificationSettingsRequest implements IHttpRequest {
  int allowNotification;
  @override
  String absolutePath = ApiUrls.save_notification_settings_url;

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

  SaveNotificationSettingsRequest(
      SaveNotificationSettingsRequestBody saveNotificationSettingsRequestBody) {
    var map = new Map<String, String>();
    map['allow_notification'] =
        saveNotificationSettingsRequestBody.allowNotification.toString();
    this.body = jsonEncode(map);
  }
}

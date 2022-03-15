import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/constants/app_messages.dart';

class AccessToken {
  void setTokenValue(String token) {
    IHttpRequest.defaultHeader = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
  }

  bool checkTokenExpiry({
    @required BuildContext context,
    @required Response response,
  }) {
    // if (response.statusCode == 401)
    if (response.statusCode == 401 
    // &&
    //     response.body
    //             .toLowerCase()
    //             .compareTo(AppMessages.unauthenticated_text.toLowerCase()) ==
    //         1
            ) {
      return true;
    }
    return false;
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/api/common/exception/exception_helper.dart';
import 'package:trendoapp/api/common/i_http_request.dart';
import 'package:trendoapp/providers/connection/connection_provider.dart';

import 'exception/exception_type.dart';

class Api {
  BuildContext context;

  Api({required this.context});

  // ignore: missing_return
  Future<http.Response> request(IHttpRequest request) {
    List<String> listKeys = [];
    List<String?> listValues = [];
    request.parameters!.forEach((k, v) {
      listKeys.add(k);
      listValues.add(v);
    });
    String paramsString = "";
    for (var i = 0; i < listKeys.length; i++) {
      if (i == 0) {
        paramsString = paramsString + "?";
      }
      paramsString = paramsString + listKeys[i] + "=" + listValues[i]!;
      if (i != listKeys.length - 1) {
        paramsString = paramsString + "&";
        // print("paramsString $paramsString");
      }
    }

    Completer<Response> completer = new Completer();
    if (Provider.of<ConnectionProvider>(context, listen: false)
        .isInternetConnection) {
      if (request.httpMethod == HttpMethod.GET) {
        print('URL--> ${request.absolutePath! + paramsString}');
        var url = Uri.parse(request.absolutePath! + paramsString);
        http.get(url, headers: request.headers as Map<String, String>?).then((response) {
          print("response-->>>>-==- ${response.body}");
          completer.complete(response);
        }).catchError((error) {
          print("ERROR-> $error");
          completer.completeError({
            Exception(error),
          });
        });
      } else if (request.httpMethod == HttpMethod.POST) {
        print('URL--> ${request.absolutePath}');
        var url = Uri.parse(request.absolutePath! + paramsString);
        http
            .post(
          url,
          headers: request.headers as Map<String, String>?,
          body: request.body,
        )
            .then((response) {
          completer.complete(response);
        }).catchError((error) {
          print("ERROR-> $error");
          completer.completeError(
            Exception(error),
          );
        });
      }
      return completer.future;
    } else {
      completer.completeError(
          // Exception(AppMessages.no_internet_msg),
          ExceptionHelper().handleExceptions(ExceptionType.NetworkException));
      return completer.future;
    }
  }
}


// if (Provider.of<ConnectionProvider>(context, listen: false)
    //     .isInternetConnection) {
    //  if (PreferenceUtils.getBoolValue(PreferenceUtils.isInternet)) {
    // if (request.httpMethod == HttpMethod.GET) {
    //   print('URL--> ${request.absolutePath + paramsString}');
    //   var url = Uri.parse(request.absolutePath + paramsString);
    //   final response = await http.get(url, headers: request.headers);
    //   // print('RESPONSE--> $response');
    //   return response;
    // } else if (request.httpMethod == HttpMethod.POST) {
    //   print('URL--> ${request.absolutePath}');
    //   var url = Uri.parse(request.absolutePath + paramsString);
    //   final response = await http.post(
    //     url,
    //     headers: request.headers,
    //     body: request.body,
    //   );
    //   return response;
    // }
    // } else {
    //   await DialogUtils.displayDialogCallBack(
    //           context,
    //           AppImages.icon_finder_no_internet,
    //           AppMessages.no_internet_title,
    //           AppMessages.no_internet_msg,
    //           AppMessages.no_internet_sub_msg,
    //           AppMessages.cancel_msg,
    //           AppMessages.ok_msg)
    //       .then((value) {
    //     print("Clicked Value-> $value");
    //     if (value == AppMessages.ok_msg) {
    //       print("Retry btn clicked");
    //       onCallBack();
    //       // likeBusiness(businessId);
    //     } else {
    //       print("Cancel btn clicked");
    //       return null;
    //     }
    //   });
    // }
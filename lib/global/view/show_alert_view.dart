import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/api/common/exception/custom_exceptions.dart';
import 'package:trendoapp/api/common/exception/exception_type.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class ShowAlertView {
  BuildContext? context;
  VoidCallback onCallBack;
  Exception exception;

  ShowAlertView(
      {required this.context,
      required this.onCallBack,
      required this.exception});

  void showAlertDialog() {
    print("exception-> $exception");

    print(
        "NETWORK TYPE CONTAINS-> ${exception.toString().contains(EnumToString.convertToString(ExceptionType.NetworkException))}");
    if (exception.toString().contains(
        EnumToString.convertToString(ExceptionType.NetworkException))) {
      showNetworkAlertDialog();
    } else if (exception.toString() ==
        TokenExpiredException(AppMessages.token_expired_text).toString()) {
      showTokenExpiredAlertDialog();
    } else {
      showRequestFailedAlertDialog();
    }
  }

  void showNetworkAlertDialog() {
    DialogUtils.displayDialogCallBack(
            context!,
            AppImages.icon_finder_no_internet,
            AppMessages.no_internet_title,
            AppMessages.no_internet_msg,
            "",
            AppMessages.cancel_text,
            AppMessages.retry_text)
        .then((value) {
      print("Clicked Value-> $value");
      if (value == AppMessages.retry_text) {
        print("Retry btn clicked");
        onCallBack();
      } else {
        print("Cancel btn clicked");
        return null;
      }
    });
  }

  void showRequestFailedAlertDialog() {
    DialogUtils.displayDialogCallBack(context!, "", AppMessages.oops_text,
            AppMessages.something_went_wrong_msg, "", AppMessages.ok_text, "")
        .then((value) {
      print("Clicked Value-> $value");
      if (value == AppMessages.retry_text) {
        print("Retry btn clicked");
        onCallBack();
      } else {
        print("Cancel btn clicked");
        return null;
      }
    });
  }

  void showTokenExpiredAlertDialog() {
    DialogUtils.displayDialogCallBack(context!, "", AppMessages.oops_text,
            AppMessages.token_expired_text, "", AppMessages.ok_text, "")
        .then((value) {
      print(value);
      AccessToken().setTokenValue("");
      StorageUtils.removeKey(StorageUtils.keyToken);
      Navigator.pushNamed(context!, AppRoutes.signin_route_name);
    });
  }
}

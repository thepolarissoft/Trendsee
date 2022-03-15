import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/verified_otp_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool isLoading = false;
  VerifiedOtpResponse verifiedOtpResponse;
  Baseresponse baseresponse;

  void verifyOtp(BuildContext context, String email, String otp) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).verifyOTP(email, otp).then((response) {
      verifiedOtpResponse = response;
      print("verifiedOtpResponse CODE-> ${verifiedOtpResponse.statuscode}");
      print("verifiedOtpResponse msg-> ${verifiedOtpResponse.msg}");
      if (verifiedOtpResponse.statuscode == 200) {
        if (verifiedOtpResponse != null && verifiedOtpResponse.user != null) {
          log("verifiedOtpResponse Token-=-=-=-=> ${verifiedOtpResponse.token}");
          print(verifiedOtpResponse.user.toString());
          isLoading = false;
          StorageUtils.writeIntValue(
              StorageUtils.keyUserType, verifiedOtpResponse.user.userType);
          if (verifiedOtpResponse.user.userType == 2) {
            if (verifiedOtpResponse.user.isMobile == 1) {
              StorageUtils.writeStringValue(
                  StorageUtils.keyBusinessType, AppMessages.mobile_text);
            } else {
              if (verifiedOtpResponse.user.isOnline == 1) {
                StorageUtils.writeStringValue(
                    StorageUtils.keyBusinessType, AppMessages.online_text);
              } else {
                StorageUtils.writeStringValue(
                    StorageUtils.keyBusinessType, AppMessages.physical_text);
              }
            }
          }

          log("StorageUtils TOKEN=-==>> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
          print(verifiedOtpResponse.user.toString());
          if (StorageUtils.readIntValue(StorageUtils.keyUserType) != null) {
            if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
              StorageUtils.writeStringValue(
                  StorageUtils.keyToken, verifiedOtpResponse.token);
              AccessToken().setTokenValue(
                  StorageUtils.readStringValue(StorageUtils.keyToken));
              Navigator.pushNamed(context, AppRoutes.timeline_route_name);
            } else if (StorageUtils.readIntValue(StorageUtils.keyUserType) ==
                2) {
              if (verifiedOtpResponse.user.isApproved == 0) {
                Navigator.pushNamed(context, AppRoutes.signin_route_name);
              } else if (verifiedOtpResponse.user.isApproved == 1) {
                StorageUtils.writeStringValue(
                    StorageUtils.keyToken, verifiedOtpResponse.token);
                AccessToken().setTokenValue(
                    StorageUtils.readStringValue(StorageUtils.keyToken));
                PreferenceUtils.setStringValue(
                    PreferenceUtils.keyBusinessUserProfileObject,
                    json.encode(verifiedOtpResponse.user));
                PreferenceUtils.setIntValue(
                    PreferenceUtils.keyUserId, verifiedOtpResponse.user.id);
                Navigator.pushNamed(
                    context, AppRoutes.business_timeline_route_name);
              }
            }
          }
          log("StorageUtils TOKEN=-==-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
        }
      } else if (verifiedOtpResponse.statuscode == 402
          //  &&
          //     verifiedOtpResponse.msg == "Business needs approval by admin"
          ) {
        DialogUtils().showSupportAlertDialog(context, "approval");
        Navigator.pushNamed(
            context, AppRoutes.successful_email_verification_route_name);
      } else {
        GlobalView().showToast(verifiedOtpResponse.msg);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                verifyOtp(context, email, otp);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void sendOtp(BuildContext context, String email) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).sendOTP(email).then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          GlobalView().showToast(AppToastMessages.send_otp_verified_message);
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                sendOtp(context, email);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/business_user_profile_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class AccountSettingsProvider extends ChangeNotifier {
  bool allowNotification = true;
  Baseresponse baseresponse;

  void setNotificationSwitchValue(bool value) {
    allowNotification = value;
    notifyListeners();
  }

  void saveNotificationSettings(
      BuildContext context,
      ProfileResponse profileResponse,
      BusinessUserProfileResponse businessUserProfileResponse) async {
    ApiManager(context)
        .saveNotificationSettings(allowNotification ? 1 : 0)
        .then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        print(baseresponse.statuscode);
        if (profileResponse != null) {
          if (allowNotification) {
            profileResponse.user.allowNotification = 1;
          } else {
            profileResponse.user.allowNotification = 0;
            OneSignal.shared.setSubscriptionObserver((changes) {
              // changes.from.isSubscribed = false;
              changes.to.isSubscribed = false;
            });
          }
        } else if (businessUserProfileResponse != null) {
          if (allowNotification) {
            businessUserProfileResponse.user.allowNotification = 1;
          } else {
            businessUserProfileResponse.user.allowNotification = 0;
            OneSignal.shared.setSubscriptionObserver((changes) {
              // changes.from.isSubscribed = false;
              changes.to.isSubscribed = false;
            });
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          saveNotificationSettings(
              context, profileResponse, businessUserProfileResponse);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void deactivateAccount(BuildContext context) async {
    ApiManager(context).deactivateAccount().then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        print(baseresponse.statuscode);
        AccessToken().setTokenValue("");
        StorageUtils.removeKey(StorageUtils.keyToken);
        PreferenceUtils.prefs.clear();
        Navigator.pushNamed(context, AppRoutes.signin_route_name);
      }
      notifyListeners();
    }).catchError((onError) {
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          deactivateAccount(context);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void deleteAccount(BuildContext context) async {
    ApiManager(context).deleteAccount().then((response) {
      baseresponse = response;
      print(baseresponse.statuscode);
      if (baseresponse.statuscode == 200) {
        print(baseresponse.statuscode);
        AccessToken().setTokenValue("");
        StorageUtils.removeKey(StorageUtils.keyToken);
        PreferenceUtils.prefs.clear();
        Navigator.pushNamed(context, AppRoutes.signin_route_name);
      }
      notifyListeners();
    }).catchError((onError) {
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          deleteAccount(context);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/api/common/access_token.dart';
import 'package:trendoapp/api/file_request_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/timeline_screen.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class BaseResponseProvider extends ChangeNotifier {
  Baseresponse? baseresponse;
  bool isLoading = false;
  bool isFeedLiked = false;
  bool isFeedDisliked = false;

  void signOut(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).logout().then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          OneSignal.shared.setSubscriptionObserver((changes) {
            // changes.from.isSubscribed = false;
            changes.to.isSubscribed = false;
          });
          AccessToken().setTokenValue("");
          StorageUtils.removeKey(StorageUtils.keyToken);
          PreferenceUtils.prefs!.clear();
          Navigator.pushNamed(context, AppRoutes.signin_route_name);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                signOut(context);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void updateProfile(
    BuildContext context,
    String firstName,
    String lastName,
    String username,
    String email,
    String avatar,
  ) async {
    print("firstName-> $firstName");
    print("lastName-> $lastName");
    isLoading = true;
    notifyListeners();
    FileRequestManager().updateProfile(context, firstName, lastName, username, email, avatar).then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          print("baseresponse--->>== ${baseresponse!.msg}");
          PreferenceUtils.setStringValue(PreferenceUtils.keyEmail, email);
          print("EMAIL-->> ${PreferenceUtils.getStringValue(PreferenceUtils.keyEmail)}");
          Navigator.pop(context);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                updateProfile(context, firstName, lastName, username, email, avatar);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void createFeed(BuildContext context, String description, String businessUserId, String categoryId, String? latitude, String? longitude, String? locationName) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).createFeed(description, businessUserId, categoryId, latitude, longitude, locationName).then((response) {
      baseresponse = response;
      print("STATUS CODE-> ${baseresponse!.statuscode}");
      print("Msg-> ${baseresponse!.msg}");
      // if (baseresponse!.statuscode == 200) {
      //   if (baseresponse != null) {
      //     isLoading = false;
      //     print("baseresponse--->>== ${baseresponse!.msg}");
      //     print(
      //         "EMAIL-->> ${PreferenceUtils.getStringValue(PreferenceUtils.keyEmail)}");
      //     Navigator.pushNamed(context, AppRoutes.timeline_route_name);
      //   }
      // } else if (baseresponse!.statuscode == 400) {
      DialogUtils.displayDialogCallBack(context, "", AppMessages.sorry_text, baseresponse!.msg, "", "", AppMessages.support_text, onTap: () {
        // ADD HERE,
        print('SUPPORT----------------------------------------------------------------');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessDetailsScreen(
              businessId: int.parse(businessUserId),
            ),
          ),
        );
      });
      // }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                createFeed(context, description, businessUserId, categoryId, latitude, longitude, locationName);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void viewFeed(String feedId, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).viewFeed(feedId).then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          print("baseresponse--->>== ${baseresponse!.msg}");
        } else {
          isLoading = true;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                viewFeed(feedId, context);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void clickFeed(String feedId, BuildContext context) async {
    ApiManager(context).clickFeed(feedId).then((response) {
      baseresponse = response;
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          // isLoading = false;
          print("baseresponse--->>== ${baseresponse!.msg}");
        }
      }
      notifyListeners();
    }).catchError((onError) {
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                clickFeed(feedId, context);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void addUnregisteredBusiness(String businessName, String latitude, String longitude, String categoryId, BuildContext context, String businessUsername) async {
    ApiManager(context).addUnregisteredBusiness(businessName, latitude, longitude, categoryId, businessUsername).then((response) {
      baseresponse = response;
      print("RESPONSE-> ${baseresponse!.toJsonData()}");
      if (baseresponse!.statuscode == 200) {
        if (baseresponse != null) {
          // isLoading = false;
          print("baseresponse--->>== ${baseresponse!.msg}");
          GlobalView().showToast(baseresponse!.msg!);
          DialogUtils.displayDialogCallBack(
                  context,
                  "",
                  AppMessages.unregistered_business_title,
                  AppMessages.unregistered_business_msg
                  // +"\n" +AppMessages
                  // .unregistered_business_sub_msg
                  ,
                  "",
                  "",
                  AppMessages.ok_text)
              .then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => TimelineScreen()));
          });
        }
      }
      notifyListeners();
    }).catchError((onError) {
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                addUnregisteredBusiness(businessName, latitude, longitude, categoryId, context, businessUsername);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  // void saveUserTokenForNotification(String token, BuildContext context) async {
  //   ApiManager(context).saveUserTokenForNotification(token).then((response) {
  //     baseresponse = response;
  //     if (baseresponse.statuscode == 200) {
  //       if (baseresponse != null) {
  //         // isLoading = false;
  //         print("baseresponse--->>== ${baseresponse.msg}");
  //       }
  //     }
  //     notifyListeners();
  //   }).catchError((onError) {
  //     print("ONERROR->> $onError");
  //     ShowAlertView(
  //             context: context,
  //             onCallBack: () {
  //               saveUserTokenForNotification(token, context);
  //             },
  //             exception: onError)
  //         .showAlertDialog();
  //     notifyListeners();
  //   });
  // }

}

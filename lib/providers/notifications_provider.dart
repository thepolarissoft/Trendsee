import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/data/models/notification_list_response.dart';
import 'package:trendoapp/data/models/notified_user_info.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';

class NotificationsProvider extends ChangeNotifier {
  NotificationListResponse notificationListResponse;
  bool isLoading = false;
  List<NotifiedUserInfo> listNotifiedUserInfo = [];
  bool isAvailableNotificationData = false;

  void getNotificationsList(BuildContext context) async {
    isLoading = true;
    isAvailableNotificationData = false;
    notifyListeners();
    int page = notificationListResponse == null
        ? 1
        : notificationListResponse.notifications.currentPage + 1;
    print("page-> $page");
    ApiManager(context).getNotificationsList(page).then(
      (response) {
        notificationListResponse = response;
        if (notificationListResponse.statuscode == 200) {
          if (notificationListResponse != null &&
              notificationListResponse.notifications != null) {
            if (notificationListResponse.notifications.data.isNotEmpty) {
              if (page == 1) {
                listNotifiedUserInfo.clear();
              }
              listNotifiedUserInfo
                  .addAll(notificationListResponse.notifications.data);
              isAvailableNotificationData = true;
            } else {
              isAvailableNotificationData = false;
            }
          }
        }
        isLoading = false;
        notifyListeners();
      },
    ).catchError(
      (onError) {
        isLoading = false;
        print("ONERROR->> ${onError.toString()}");
        ShowAlertView(
          context: context,
          onCallBack: () {
            getNotificationsList(context);
          },
          exception: onError,
        ).showAlertDialog();
        notifyListeners();
      },
    );
  }
}

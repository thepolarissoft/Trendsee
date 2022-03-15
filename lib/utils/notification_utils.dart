import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:trendoapp/api/api_manager.dart';

class NotificationUtils {
  void saveUserTokenForNotification(BuildContext context) {
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) async {
      print("Accepted permission: $accepted");
      OSDeviceState osDeviceState = await OneSignal.shared.getDeviceState();
      ApiManager(context).saveUserTokenForNotification(osDeviceState.userId);
    });
  }
}

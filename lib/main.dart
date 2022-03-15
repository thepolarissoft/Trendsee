import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/presentation/screens/common/app_launcher_screen.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/router/app_router.dart';
import 'package:trendoapp/utils/network_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/provider_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.requiresUserPrivacyConsent().then((value) {
    print("VALUE-> $value");
    value = false;
  });
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("fd5e4d34-1c01-4342-b66d-aa1b64e212e6");
  tz.initializeTimeZones();
  var locations = tz.timeZoneDatabase.locations;
  print(locations.length); // => 429
  print(locations.keys.first); // => "Africa/Abidjan"
  print(locations.keys.last);
  // OneSignal.shared.setSubscriptionObserver((changes) {
  //   changes.from.isSubscribed = false;
  //   changes.to.isSubscribed = false;
  // });
  runApp(
    ProviderUtils().initProviders(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    initOneSignal();
    Provider.of<BusinessUserProvider>(context, listen: false).getTimeZoneData();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    NetworkUtils(context: context).init();
    PreferenceUtils.init();
    StorageUtils.init();
    return MaterialApp(
      title: 'Trendo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter().onGenerateRoute,
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context)
              .copyWith(textScaleFactor: 1.0), //for restrict system settings
        );
      },
      home: Scaffold(
        body: AppLauncherScreen(),
      ),
    );
  }

  void initOneSignal() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => BusinessDetailsScreen()));
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.

      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result.toString()}');
      print("Notification click called");
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => NotificationScreen()));
    });
  }
}
// Date: 12th Oct, 2021 --> Removed unlike and added dislike to all businesses in standard user panel.


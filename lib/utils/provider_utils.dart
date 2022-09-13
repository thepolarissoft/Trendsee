import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/settings/account_settings_provider.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/comment_response_provider.dart';
import 'package:trendoapp/providers/connection/connection_provider.dart';
import 'package:trendoapp/providers/current_location_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/providers/location_list_provider.dart';
import 'package:trendoapp/providers/notifications_provider.dart';
import 'package:trendoapp/providers/profile_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/providers/standard_user_provider.dart';
import 'package:trendoapp/providers/verify_otp_provider.dart';

class ProviderUtils {
  Widget initProviders(Widget myApp) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (_) => BaseResponseProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LocationListProvider()),
        ChangeNotifierProvider(create: (_) => BusinessUserProvider()),
        ChangeNotifierProvider(create: (_) => StandardUserProvider()),
        ChangeNotifierProvider(create: (_) => BusinessListProvider()),
        ChangeNotifierProvider(create: (_) => HomeFeedResponseProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesListProvider()),
        ChangeNotifierProvider(create: (_) => CommentResponseProvider()),
        ChangeNotifierProvider(create: (_) => SearchByBusinessProvider()),
        ChangeNotifierProvider(create: (_) => CurrentLocationProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
        ChangeNotifierProvider(create: (_) => AccountSettingsProvider()),
      ],
      child: myApp,
    );
  }
}

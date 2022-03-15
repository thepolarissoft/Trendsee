import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/data/models/update_business_latlong_response.dart';
import 'package:trendoapp/presentation/screens/businessUser/add_edit_business_hours_screen.dart';
import 'package:trendoapp/presentation/screens/businessUser/homeTabs/business_profile_screen.dart';
import 'package:trendoapp/presentation/screens/businessUser/homeTabs/business_timeline_screen.dart';
import 'package:trendoapp/presentation/screens/common/app_launcher_screen.dart';
import 'package:trendoapp/presentation/screens/common/forgot_password_screen.dart';
import 'package:trendoapp/presentation/screens/common/map_screen.dart';
import 'package:trendoapp/presentation/screens/common/my_all_check_ins_screen.dart';
import 'package:trendoapp/presentation/screens/common/sign_in_screen.dart';
import 'package:trendoapp/presentation/screens/common/successful_email_verification_screen.dart';
import 'package:trendoapp/presentation/screens/common/user_type_selection_screen.dart';
import 'package:trendoapp/presentation/screens/media_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/add_new_check_in_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/edit_profile_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/followers_details_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/followers_tab_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/business_liked_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/home_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/search_by_business_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/standard_user_profile_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/homeTabs/timeline_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/notifications_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/searchTabs/people_search_tab_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/searchTabs/places_search_tab_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/searchTabs/search_people_details_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/searchTabs/search_place_details_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/select_business_address_from_map_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/select_location_for_add_new_check_in_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments as TempLocationsArgs;

    switch (routeSettings.name) {
      case AppRoutes.init_route_name:
        return MaterialPageRoute(builder: (_) => AppLauncherScreen());
        break;
      case AppRoutes.signin_route_name:
        return MaterialPageRoute(builder: (_) => SignInScreen());
        break;
      // case AppRoutes.emailVerificationRouteName:
      //   return MaterialPageRoute(builder: (_) => EmailVerificationScreen(key: key));
      //   break;
      case AppRoutes.successful_email_verification_route_name:
        return MaterialPageRoute(
            builder: (_) => SuccessfulEmailVerificationScreen());
        break;
      case AppRoutes.forgot_password_route_name:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
        break;
      // case AppRoutes.simple_user_registration_route_name:
      //   return MaterialPageRoute(
      //       builder: (_) => SimpleUserRegistrationScreen());
      //   break;
      // case AppRoutes.business_user_registration_route_name:
      //   return MaterialPageRoute(
      //       builder: (_) => BusinessUserRegistrationScreen());
      //   break;
      case AppRoutes.user_type_selection_route_name:
        return MaterialPageRoute(builder: (_) => UserTypeSelectionScreen());
        break;
      case AppRoutes.timeline_route_name:
        return MaterialPageRoute(builder: (_) => TimelineScreen());
        break;
      case AppRoutes.home_route_name:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case AppRoutes.search_people_route_name:
        return MaterialPageRoute(builder: (_) => SearchByBusinessScreen());
        break;
      case AppRoutes.business_liked_list_route_name:
        return MaterialPageRoute(builder: (_) => BusinessLikedScreen());
        break;
      case AppRoutes.more_actions_route_name:
        return MaterialPageRoute(builder: (_) => StandardUserProfileScreen());
        break;
      case AppRoutes.add_new_checkin_route_name:
        return MaterialPageRoute(builder: (_) => AddNewCheckInScreen());
        break;
      case AppRoutes.select_location_for_add_new_checkin_route_name:
        return MaterialPageRoute(
            builder: (_) => SelectBusinessForAddNewCheckInScreen());
        break;
      case AppRoutes.select_business_address_from_map_route_name:
        return MaterialPageRoute(
            builder: (_) => SelectBusinessAddressFromMapScreen());
        break;
      // case AppRoutes.checkInDetailsRouteName:
      //   return MaterialPageRoute(builder: (_) => CheckInDetailsScreen());
      //   break;
      case AppRoutes.places_search_tab_route_name:
        return MaterialPageRoute(builder: (_) => PlacesSearchTabScreen());
        break;
      case AppRoutes.people_search_tab_route_name:
        return MaterialPageRoute(builder: (_) => PeopleSearchTabScreen());
        break;
      case AppRoutes.followers_rab_route_name:
        return MaterialPageRoute(builder: (_) => FollowersTabScreen());
        break;
      // case AppRoutes.business_i_liked_route_name:
      //   return MaterialPageRoute(builder: (_) => BusinessILikedScreen());
      //   break;
      case AppRoutes.edit_profile_route_name:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
        break;
      case AppRoutes.media_route_name:
        return MaterialPageRoute(builder: (_) => MediaScreen());
        break;
      case AppRoutes.map_route_name:
        return MaterialPageRoute(
          builder: (_) => MapScreen(
            isTemp: args.isTemp,
          ),
        );
        break;
      case AppRoutes.my_all_check_ins_route_name:
        return MaterialPageRoute(builder: (_) => MyAllCheckInsScreen());
        break;
      case AppRoutes.business_timeline_route_name:
        return MaterialPageRoute(builder: (_) => BusinessTimelineScreen());
        break;
      case AppRoutes.business_profile_route_name:
        return MaterialPageRoute(builder: (_) => BusinessProfileScreen());
        break;
      // case AppRoutes.account_settings_route_name:
      //   return MaterialPageRoute(builder: (_) => AccountSettingsScreen());
      //   break;
      // case AppRoutes.edit_business_profile_route_name:
      //   return MaterialPageRoute(builder: (_) => EditBusinessProfileScreen());
      //   break;
      case AppRoutes.search_place_details_route_name:
        return MaterialPageRoute(builder: (_) => SearchPlaceDetailsScreen());
        break;
      case AppRoutes.search_people_details_route_name:
        return MaterialPageRoute(builder: (_) => SearchPeopleDetailsScreen());
        break;
      // case AppRoutes.business_liked_details_route_name:
      //   return MaterialPageRoute(
      //       builder: (_) => BusinessDetailsScreen());
      //   break;
      case AppRoutes.followers_details_route_name:
        return MaterialPageRoute(builder: (_) => FollowersDetailsScreen());
        break;
      case AppRoutes.notifications_route_name:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
        break;
      case AppRoutes.add_edit_business_hours_route_name:
        return MaterialPageRoute(builder: (_) => AddEditBusinessHoursScreen());
        break;
      // case AppRoutes.add_more_locations_route_name:
      //   return MaterialPageRoute(
      //     builder: (_) => AddMoreLocationsScreen(
      //       listLatLong: listLatLongargs.listLatLong,
      //     ),
      //   );
      // break;
      default:
        return null;
    }
  }
}

class TempLocationsArgs {
  bool isTemp;
  TempLocationsArgs(this.isTemp);
}

class AddMoreLocationArgs {
  List<LatLongInfo> listLatLong;
  AddMoreLocationArgs(this.listLatLong);
}

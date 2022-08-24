import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/data/models/categories_list_response.dart';
import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class AppLauncherScreen extends StatefulWidget {
  @override
  _AppLauncherScreenState createState() => _AppLauncherScreenState();
}

class _AppLauncherScreenState extends State<AppLauncherScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      initApiCalls();
    });
  }

  void initApiCalls() async {
    // ConnectionUtils(context: context).init();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)) {
      MetropolitanAreasListResponse? metropolitanAreasListResponse =
          await (Provider.of<BusinessUserProvider>(context, listen: false).getMetropolitanAreasList(context));
      if (metropolitanAreasListResponse!.statuscode == 200) {
        CategoriesListResponse? categoriesListResponse =
            await (Provider.of<CategoriesListProvider>(context, listen: false).getCategoriesList(context));
        print("CATEGORY STATUS CODE-> ${Provider.of<CategoriesListProvider>(context, listen: false).categoriesListResponse!.statuscode}");
        if (categoriesListResponse!.statuscode == 200) {
          setNavigation();
        }
      } else {
        print("else called");
      }

      // .catchError((onError) {
      //   print("ONERROR--> $onError");
      //   ShowAlertView(
      //     context: context,
      //     onCallBack: () {
      //       initApiCalls();
      //     },
      //     exception: onError,
      //   ).showAlertDialog();
      // });
      // print(
      //     "METROPOLITANAREA STATUS CODE-> ${Provider.of<BusinessUserProvider>(context, listen: false).metropolitanAreasListResponse.statuscode}");

    } else {
      GlobalView().showToast(AppMessages.no_internet_msg);
    }
  }

  void setNavigation() {
    print("KEY USER TYPE-> ${StorageUtils.readIntValue(StorageUtils.keyUserType)}");
    print("KEY TOKEN-> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
    print("TOKEN LENGTH-> ${StorageUtils.readStringValue(StorageUtils.keyToken).length}");
    if (StorageUtils.readStringValue(StorageUtils.keyToken) != null && StorageUtils.readStringValue(StorageUtils.keyToken).length > 0) {
      if (StorageUtils.readIntValue(StorageUtils.keyUserType) == 1) {
        Navigator.pushNamed(context, AppRoutes.timeline_route_name);
      } else {
        Navigator.pushNamed(context, AppRoutes.business_timeline_route_name);
      }
    } else {
      Navigator.pushNamed(context, AppRoutes.signin_route_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<CategoriesListProvider>(
    //     builder: (_, categoriesProvider, child) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: AssetImage(AppImages.background_image),
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
              child: Container(
            padding: EdgeInsets.all(120),
            // alignment: Alignment(0, 100),
            child: Image.asset(AppImages.trendsee_logo_transparent),
          ))
          // GlobalView().assetImageView(AppImages.backgroundImage),
          // GlobalView().assetImageView(AppImages.appLogo),
          // // Positioned.fill(
          // //   left: 120,
          // //   right: 120,
          // //   child: GlobalView().assetImageView(AppImages.appLogo),
          // // )
        ],
      ),
    );
    // });
  }
}

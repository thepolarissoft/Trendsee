import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/data/global/current_location_data.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class HomeListData {
  void initHome(BuildContext context) {
    CurrentLocationData().getCurrentLocation(context);
    if (StorageUtils.readStringValue(StorageUtils.keyLatitude) == null &&
        StorageUtils.readStringValue(StorageUtils.keyLongitude) == null) {
      CurrentLocationData().getCurrentLocation(context);
    } else {
      initHomeData(context);
    }
  }

  void initHomeData(BuildContext context) async {
    Future.delayed(Duration.zero, () {
      CategoriesListProvider catProvider =
          Provider.of<CategoriesListProvider>(context, listen: false);
      catProvider.selectedCategoryItem(catProvider.listCategoriesForHome[0]);
      print(
          "RADIUS->${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
      // Provider.of<FilterProvider>(context, listen: false).setDistanceRadius("5");

      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .listFeedInfo
          .clear();
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .homeFeedResponse = null;
      Provider.of<FilterProvider>(context, listen: false).selectedCity("");
      Provider.of<FilterProvider>(context, listen: false)
          .setDistanceRadius("5");

      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .getHomeFeedList(
              context,
              catProvider.selectedCategoryResponse.id.toString(),
              StorageUtils.readStringValue(StorageUtils.keyLatitude),
              StorageUtils.readStringValue(StorageUtils.keyLongitude),
              "5",
              "");
    });
  }

  void applyHomeData(BuildContext context) async {
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .listFeedInfo
        .clear();
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .getHomeFeedList(
      context,
      Provider.of<CategoriesListProvider>(context, listen: false)
          .selectedCategoryResponse
          .id
          .toString(),
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      Provider.of<FilterProvider>(context, listen: false)
          .selectedMetropolitanCityInfo,
    );
  }

  void resetHomeData(BuildContext context) async {
    CategoriesListProvider catProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    catProvider.selectedCategoryItem(catProvider.listCategoriesForHome[0]);
    Provider.of<FilterProvider>(context, listen: false).setCityValue("");
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .listFeedInfo
        .clear();
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .getHomeFeedList(
      context,
      catProvider
          // .listFilteredCategoryId[0]
          .selectedCategoryResponse
          .id
          .toString(),
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      Provider.of<FilterProvider>(context, listen: false)
          .selectedMetropolitanCityInfo,
    );
  }
}

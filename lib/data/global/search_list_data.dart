import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class SearchListData {
  void initSearchData(
      BuildContext context, String searchValue, int page) async {
    CategoriesListProvider catProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    catProvider.selectedCategoryItem(catProvider.listCategoriesForHome[0]);
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .listBusiness
        .clear();
    Provider.of<FilterProvider>(context, listen: false).setSearchValue("");
    Provider.of<FilterProvider>(context, listen: false).setCityValue("");
    Provider.of<FilterProvider>(context, listen: false).selectedCity("");
    Provider.of<FilterProvider>(context, listen: false).setDistanceRadius("5");

    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .getSearchByBusinessList(
            context,
            page,
            searchValue,
            catProvider.selectedCategoryResponse.id.toString(),
            StorageUtils.readStringValue(StorageUtils.keyLatitude),
            StorageUtils.readStringValue(StorageUtils.keyLongitude),
            "5",
            "");
    // Provider.of<CategoriesListProvider>(context, listen: false)
    //     .listCategoriesForHome[0]
    //     .name = "All";
    // Provider.of<CategoriesListProvider>(context, listen: false)
    //     .getCategoriesList(context);

    // print(s
    // "SELECTED CATEGORY DATA-> ${Provider.of<CategoriesListProvider>(context, listen: false).selectedCategoryData.name}");
    print("INIT CATEGORY-> ${catProvider.listCategories[0].name}");
  }

  void searchDataForCategories(BuildContext context, int page) async {
    print(
        "searchValue From Search INIT--->> ${Provider.of<FilterProvider>(context, listen: false).searchValue}");
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .listBusiness
        .clear();
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .getSearchByBusinessList(
      context,
      page,
      Provider.of<FilterProvider>(context, listen: false).searchValue,
      Provider.of<CategoriesListProvider>(context, listen: false)
          // .listFilteredCategoryId
          // .join(",")
          .selectedCategoryResponse
          .id
          .toString(),
      // filterModel.categoryId,
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      Provider.of<FilterProvider>(context, listen: false)
          .selectedMetropolitanCityInfo,
    );
  }

  void applySearchDataForDistance(
      BuildContext context, String distanceRadius) async {
    print(
        "Distance Radius-->> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    print(
        "Selected Metropolitan City-->> ${Provider.of<FilterProvider>(context, listen: false).selectedMetropolitanCityInfo}");

    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .listBusiness
        .clear();
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .getSearchByBusinessList(
      context,
      1,
      Provider.of<FilterProvider>(context, listen: false).searchValue,
      Provider.of<CategoriesListProvider>(context, listen: false)
          // .listFilteredCategoryId
          // .join(",")
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

  void resetSearchDataForDistance(BuildContext context) async {
    CategoriesListProvider catProvider =
        Provider.of<CategoriesListProvider>(context, listen: false);
    catProvider.selectedCategoryItem(catProvider.listCategoriesForHome[0]);
    Provider.of<FilterProvider>(context, listen: false).setCityValue("");
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .listBusiness
        .clear();
    Provider.of<FilterProvider>(context, listen: false).selectedCity("");
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .getSearchByBusinessList(
      context,
      1,
      Provider.of<FilterProvider>(context, listen: false).searchValue,
      catProvider.selectedCategoryResponse.id.toString(),
      StorageUtils.readStringValue(StorageUtils.keyLatitude),
      StorageUtils.readStringValue(StorageUtils.keyLongitude),
      Provider.of<FilterProvider>(context, listen: false).distanceRadius,
      Provider.of<FilterProvider>(context, listen: false)
          .selectedMetropolitanCityInfo,
    );
  }
}

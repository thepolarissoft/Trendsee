import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/categories_list_response.dart';
import 'package:trendoapp/data/models/category_response.dart';

class CategoriesListProvider extends ChangeNotifier {
  CategoriesListResponse? categoriesListResponse;
  List<CategoryResponse> listCategories = [];
  List<CategoryResponse> listCategoriesForHome = [];
  bool isLoading = false;
  CategoryResponse categoryResponse = new CategoryResponse();
  CategoryResponse selectedBusinessCategoryResponse = new CategoryResponse();
  List<CategoryResponse> listSelectedCategories = [];
  // List<CategoryResponse> tempListSelectedCategories = [];

  List<int?> listSelectedCategoryId = [];
  // List<int> listFilteredCategoryId = [];
  CategoryResponse? selectedCategoryResponse;

  // ignore: missing_return
  Future<CategoriesListResponse?> getCategoriesList(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    categoriesListResponse = await ApiManager(context).getCategoriesList();
    if (categoriesListResponse!.statuscode == 200) {
      if (categoriesListResponse != null) {
        isLoading = false;
        print("baseresponse--->>== ${categoriesListResponse!.msg}");
        if (categoriesListResponse != null &&
            categoriesListResponse!.category != null) {
          listCategories.clear();
          listCategories.addAll(categoriesListResponse!.category!);
          // listCategories[0].isChecked = true;
          listCategoriesForHome.clear();
          CategoryResponse category =
              CategoryResponse(id: 0, name: AppMessages.home_first_cat_name);
          listCategoriesForHome.add(category);
          listCategoriesForHome.addAll(categoriesListResponse!.category!);
          listCategoriesForHome[0].isChecked = true;
          selectedBusinessCategoryResponse = listCategoriesForHome[0];

          // listSelectedCategories.add(listCategories[0]);
          // listSelectedCategoryId.add(listSelectedCategories[0].id);

          selectedCategoryResponse = listCategoriesForHome[0];
          print(
              "selectedCategoryResponse--->> ${selectedCategoryResponse!.toJson()}");
          // listFilteredCategoryId.clear();
          // listFilteredCategoryId.add(listCategoriesForHome[0].id);
          print(
              "IS checked from provider-> ${categoriesListResponse!.category![0].isChecked}");
          return categoriesListResponse;
        }
      }
    }
    notifyListeners();
  }

  void selectedBusinessCategoryItem(CategoryResponse value) {
    print("value Provider->> ${value.toJson()}");
    // selectedBusinessCategoryResponse = null;
    // selectedBusinessCategoryResponse = value;
    print(
        "selectedBusinessCategoryResponse Provider-> ${selectedBusinessCategoryResponse.toJson()}");
    print("listCategories Length-> ${listCategories.length}");
    for (var i = 0; i < listCategories.length; i++) {
      if (listCategories[i].id == value.id) {
        selectedBusinessCategoryResponse = listCategories[i];
        break;
      }
    }
    notifyListeners();
  }

  void addDataToList(List<CategoryResponse> list) {
    listSelectedCategories.clear();
    for (var i = 0; i < listCategories.length; i++) {
      listCategories[i].isChecked = false;
    }
    listSelectedCategories.addAll(list);
    for (var i = 0; i < listCategories.length; i++) {
      for (var j = 0; j < listSelectedCategories.length; j++) {
        if (listCategories[i].id == listSelectedCategories[j].id) {
          listCategories[i].isChecked = true;
          listSelectedCategories[j].isChecked = true;
        }
      }
    }
    listSelectedCategoryId.clear();
    for (var i = 0; i < listSelectedCategories.length; i++) {
      if (!listSelectedCategoryId.contains(listSelectedCategories[i].id)) {
        listSelectedCategoryId.add(listSelectedCategories[i].id);
      }
    }
    print("listSelectedCategories Length-> ${listSelectedCategories.length}");
    notifyListeners();
  }

  // void selectedBusinessCategoryItem(CategoryResponse value) {
  //   print("value Provider->> ${value.toJson()}");
  //   // selectedBusinessCategoryResponse = null;
  //   // selectedBusinessCategoryResponse = value;
  //   print(
  //       "selectedBusinessCategoryResponse Provider-> ${selectedBusinessCategoryResponse.toJson()}");
  //   print("listCategories Length-> ${listCategoriesForHome.length}");
  //   for (var i = 0; i < listCategoriesForHome.length; i++) {
  //     if (listCategoriesForHome[i].id == value.id) {
  //       selectedBusinessCategoryResponse = listCategoriesForHome[i];
  //       break;
  //     }
  //   }
  //   notifyListeners();
  // }

  void changeCheckBoxValue(CategoryResponse categoryResponse, bool? value) {
    print(
        "tempListSelectedCategories Length-> ${listSelectedCategories.length}");
    if (value == true && listSelectedCategories.length < 2) {
      listSelectedCategories.add(categoryResponse);
      for (var i = 0; i < listCategories.length; i++) {
        if (listCategories[i].id == categoryResponse.id) {
          categoryResponse.isChecked = true;
          break;
        }
      }
    } else {
      categoryResponse.isChecked = false;
      print(
          "listSelectedCategories before remove Length-> ${listSelectedCategories.length}");
      listSelectedCategories
          .removeWhere((element) => element.id == categoryResponse.id);
    }
    print("Categories->${listSelectedCategories.toList()}");
    print("listSelectedCategories Length-> ${listSelectedCategories.length}");
    listSelectedCategoryId.clear();
    for (var i = 0; i < listSelectedCategories.length; i++) {
      if (!listSelectedCategoryId.contains(listSelectedCategories[i].id)) {
        listSelectedCategoryId.add(listSelectedCategories[i].id);
      }
    }
    print("Category Id-> ${listSelectedCategoryId.join(',')}");
    notifyListeners();
  }

  void onClickSaveCategory() {
    print("listSelectedCategories length-> ${listSelectedCategories.length}");
    listSelectedCategories.addAll(listSelectedCategories);
    listSelectedCategoryId.clear();
    for (var i = 0; i < listSelectedCategories.length; i++) {
      if (!listSelectedCategoryId.contains(listSelectedCategories[i].id)) {
        listSelectedCategoryId.add(listSelectedCategories[i].id);
      }
    }
    notifyListeners();
  }

  // void onClickCategory(
  //     CategoryResponse categoryResponse, BuildContext context) {
  //   print("listFilteredCategoryId Length-> ${listFilteredCategoryId.length}");
  //   // if (!categoryResponse.isChecked && listFilteredCategoryId.length < 2) {
  //   if (!categoryResponse.isChecked && listFilteredCategoryId.length == 1) {
  //     categoryResponse.isChecked = true;
  //     listFilteredCategoryId.add(categoryResponse.id);
  //   } else {
  //     if (listFilteredCategoryId.length == 1) {
  //       DialogUtils.displayDialogCallBack(
  //           context,
  //           "",
  //           AppMessages.categories_text,
  //           AppMessages.select_atleast_one_cate_text,
  //           "",
  //           AppMessages.ok_text,
  //           "");
  //     } else {
  //       categoryResponse.isChecked = false;
  //       listFilteredCategoryId.remove(categoryResponse.id);
  //     }
  //   }
  //   print("listFilteredCategoryId Length-> ${listFilteredCategoryId.length}");
  //   notifyListeners();
  // }

  // void getHomeCategories() {
  //   // listCategoriesForHome.clear();
  //   // listCategoriesForHome.addAll(listCategories);
  //   categoryResponse.id = 0;
  //   categoryResponse.name = "All";
  //   categoryResponse.createdAt = DateTime.now();
  //   categoryResponse.updatedAt = DateTime.now();
  //   // if (listCategoriesForHome.isNotEmpty) {
  //   //   if (!listCategoriesForHome[0].name.contains("All")) {
  //   //     listCategoriesForHome.insert(0, categoryResponse);
  //   //     selectedCategoryData = listCategoriesForHome[0];
  //   //   }
  //   // }
  //   // for (var i = 0; i < listCategoriesForHome.length; i++) {
  //   //   print(listCategoriesForHome[i].name);
  //   // }
  //   notifyListeners();
  // }

  void selectedCategoryItem(CategoryResponse? categoryResponse) {
    // selectedCategoryResponse = categoryResponse;
    // print("value Provider->> ${categoryResponse.toJson()}");

    // print(
    //     "selectedBusinessCategoryResponse Provider-> ${selectedBusinessCategoryResponse.toJson()}");
    print("listCategoriesForHome Length-> ${listCategoriesForHome.length}");
    for (var i = 0; i < listCategoriesForHome.length; i++) {
      if (listCategoriesForHome[i].id == categoryResponse!.id) {
        // selectedBusinessCategoryResponse = listCategories[i];
        selectedCategoryResponse = categoryResponse;
        break;
      }
    }
    notifyListeners();
  }
}

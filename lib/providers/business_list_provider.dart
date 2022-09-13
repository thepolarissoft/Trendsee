import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/data/models/business_list_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';

class BusinessListProvider extends ChangeNotifier {
  BusinessListResponse? businessListResponse;
  bool isLoading = false;
  bool? isChecked = false;
  VerifiedUserResponse verifiedUserResponse = new VerifiedUserResponse();
  // BusinessLikedListResponse businessLikedListResponse =
  //     new BusinessLikedListResponse();
  List<VerifiedUserResponse> listBusinessLiked = [];
  List<VerifiedUserResponse> listBusinessLikedByName = [];

  bool isAvailableData = true;
  bool isAvailableOnlineData = true;

  bool isOnlineCheckIn = false;

  void setOnlineCheckIn() {
    isOnlineCheckIn = !isOnlineCheckIn;
    notifyListeners();
  }

  void getBusinessList(BuildContext context, String latitude, String longitude,
      String? distance) async {
    int page = businessListResponse == null
        ? 1
        : businessListResponse!.business!.currentPage! + 1;
    // int page;
    // if (businessListResponse == null) {
    //   page = 1;
    // } else {
    //   if (page > 1 &&
    //       businessListResponse.business.currentPage <
    //           businessListResponse.business.lastPage) {
    //     page = 1;
    //   } else if (businessListResponse.business.currentPage <
    //       businessListResponse.business.lastPage) {
    //     page = businessListResponse.business.currentPage + 1;
    //   }
    // }
    isLoading = true;
    isAvailableData = true;
    // notifyListeners();
    ApiManager(context)
        .getBusinessList(page, latitude, longitude, distance)
        .then((response) {
      businessListResponse = response;
      if (businessListResponse!.statuscode == 200) {
        if (businessListResponse != null &&
            businessListResponse!.business != null &&
            businessListResponse!.business!.data!.isNotEmpty) {
          if (page == 1) {
            listBusinessLiked.clear();
          }
          listBusinessLiked.addAll(businessListResponse!.business!.data!);
          isAvailableData = true;
        } else {
          isAvailableData = false;
        }
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getBusinessList(context, latitude, longitude, distance);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void changeCheckBoxValue(int index, bool? value) {
    isChecked = value;
    if (businessListResponse != null &&
        businessListResponse!.business != null &&
        businessListResponse!.business!.data != null) {
      for (var i = 0; i < businessListResponse!.business!.data!.length; i++) {
        // ignore: unrelated_type_equality_checks
        if (businessListResponse!.business!.data![i] == index) {
          businessListResponse!.business!.data![index].isChecked = true;
          // verifiedUserResponse = businessListResponse.business.data[index];
        } else {
          businessListResponse!.business!.data![i].isChecked = false;
        }
      }
    }
    // businessListResponse.business.data[index].isChecked = value;
    verifiedUserResponse = businessListResponse!.business!.data![index];
    // if (businessListResponse != null &&
    //     businessListResponse.business != null &&
    //     businessListResponse.business.data != null) {
    //   for (var i = 0; i < businessListResponse.business.data.length; i++) {
    //     // ignore: unrelated_type_equality_checks
    //     if (businessListResponse.business.data[i].id == response.id) {
    //       response.isChecked = true;
    //       // verifiedUserResponse = businessListResponse.business.data[i];
    //       verifiedUserResponse = response;
    //       // break;
    //     } else {
    //       response.isChecked = false;
    //       verifiedUserResponse = response;
    //     }
    //   }
    // }
    notifyListeners();
  }

  void getBusinessListByName(BuildContext context, String searchValue) async {
    int page = businessListResponse == null
        ? 1
        : businessListResponse!.business!.currentPage! + 1;
    isLoading = true;
    isAvailableOnlineData = true;
    // notifyListeners();
    ApiManager(context)
        .getBusinessByNameList(page, searchValue)
        .then((response) {
      businessListResponse = response;
      if (businessListResponse!.statuscode == 200) {
        if (businessListResponse != null &&
            businessListResponse!.business != null &&
            businessListResponse!.business!.data != null) {
          if (page == 1) {
            listBusinessLikedByName.clear();
          }
          if (businessListResponse!.business!.data!.isNotEmpty) {
            listBusinessLikedByName.addAll(businessListResponse!.business!.data!);
            isAvailableOnlineData = true;
          } else {
            isAvailableOnlineData = false;
          }
        }
      }
      print(
          "listBusinessLikedByName length-> ${listBusinessLikedByName.length}");
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getBusinessListByName(context, searchValue);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  // void getBusinessLikedList(BuildContext context, int page) async {
  //   isLoading = true;
  //   // notifyListeners();
  //   businessLikedListResponse =
  //       await ApiManager(context).getBusinessLikedList(page.toString());
  //   print("businessLikedListResponse-> ${businessLikedListResponse.place}");
  //   if (businessLikedListResponse != null &&
  //       businessLikedListResponse.place != null &&
  //       businessLikedListResponse.place.data != null) {
  //     listBusinessLiked.clear();
  //     listBusinessLiked.addAll(businessLikedListResponse.place.data);
  //     if (listBusinessLiked.isNotEmpty) {
  //       isAvailableData = true;
  //     } else {
  //       isAvailableData = false;
  //     }
  //     isLoading = false;
  //     // notifyListeners();
  //     // GlobalView().showToast(AppToastMessages.sucessfullyDataFetchMessage);
  //   } else {
  //     isLoading = true;
  //   }
  //   notifyListeners();
  // }
}

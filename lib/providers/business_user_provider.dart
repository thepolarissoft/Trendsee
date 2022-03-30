import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/api/file_request_manager.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/business_user_images_model.dart';
import 'package:trendoapp/data/models/business_user_profile_response.dart';
import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/data/models/graph_like_response.dart';
import 'package:trendoapp/data/models/metropolitan_areas_list_response.dart';
import 'package:trendoapp/data/models/time_zone_response.dart';
import 'package:trendoapp/data/models/update_business_latlong_response.dart';
import 'package:trendoapp/data/models/update_list_keywords_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/common/email_verification_screen.dart';
import 'package:trendoapp/utils/day_time_utils.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class BusinessUserProvider extends ChangeNotifier {
  // List<BusinessUserImagesModel> listBusinessUserImages = new List();
  List<String> listBusinessUserImages = [];
  Baseresponse baseresponse;
  bool isLoading = false;
  bool isPrivacyCheckBoxValue = false;
  bool isAgeCheckBoxValue = false;
  // bool isOnlineBusinessValue = false;
  bool isMobileBusinessValue = false;
  String selectedBusiness = AppMessages.physical_text;
  List<String> listBusiness = [
    AppMessages.physical_text,
    AppMessages.online_text,
    AppMessages.mobile_text
  ];
  double centerLatitude;
  double centerLongitude;
  MetropolitanAreasListResponse metropolitanAreasListResponse;
  List<MetropolitanAreaInfo> listMetropolitanAreaInfo = [];
  MetropolitanAreaInfo selectedMetropolitanAreaInfo =
      new MetropolitanAreaInfo();
  MetropolitanCityInfo selectedMetroCityInfo = new MetropolitanCityInfo();
  String imageUrl = "";
  List<String> listImageUrl = [];
  BusinessUserProfileResponse businessUserProfileResponse;
  List<String> listMediaImages = [];
  int current = 0;
  BusinessUserResponse editProfileResponse = new BusinessUserResponse();
  UpdateListKeywordsResponse updateListKeywordsResponse;
  List<String> listBusinessKeywords = [];
  bool isVisibleMetropolitanCity = false;
  String selectedMetropolitanAreaName = "";
  List<MetropolitanCityInfo> listCities = [];
  bool isEditableArea = false;
  bool isEditableCity = false;
  GraphResponse graphResponse = new GraphResponse();
  List<GraphData> listGraphLikeData = [];
  List<Map<String, int>> map = [];
  bool isViews = true;
  bool isLikes = false;
  bool isClicks = false;
  File userImage;
  BusinessLatlongResponse businessLatlongResponse;
  List<LatLongInfo> listLatLong = [];
  bool isCitySelected = true;
  bool isDistanceRadiusSelected = false;
  List<String> dropDownItems = ["By Day", "By Month", "By Year"];
  String selectedDropDownValue = "By Day";
  TimezoneInfo selectedTimeZone = TimezoneInfo();
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  List<BusinessHoursResponse> listBusinessHours = [];
  List listOpenTime = [];
  List listCloseTime = [];

  // List listTimeZone = [];
  TimeZoneResponse timeZoneResponse = TimeZoneResponse();

  void addToBusinessUserImagesList(String images) {
    BusinessUserImagesModel businessUserImagesModel =
        BusinessUserImagesModel(images);
    listBusinessUserImages.add(businessUserImagesModel.businessUserImage);
    notifyListeners();
  }

  void addArrayToBusinessUserImagesList(List<String> images) {
    isLoading = true;
    listImageUrl.clear();
    listImageUrl.addAll(images);
    print(listImageUrl);
    isLoading = false;
    notifyListeners();
  }

  void deleteFromBusinessUserImagesList(int index) {
    listBusinessUserImages.removeAt(index);
    print(
        "listBusinessUserImages length-=-=> ${listBusinessUserImages.length}");
    notifyListeners();
  }

  // void setOnlineBusinessValue(bool value) {
  //   // if (isOnlineBusinessValue) {
  //   //   isOnlineBusinessValue = false;
  //   // } else {
  //   //   isOnlineBusinessValue = true;
  //   // }
  //   // isOnlineBusinessValue = value;
  //   notifyListeners();
  // }

  void setBusinessTypeValue(String value) {
    selectedBusiness = value;
    // isMobileBusinessValue = value2;
    notifyListeners();
  }

  void setPrivacyCheckBoxValue() {
    if (isPrivacyCheckBoxValue) {
      isPrivacyCheckBoxValue = false;
    } else {
      isPrivacyCheckBoxValue = true;
    }
    notifyListeners();
  }

  void setAgeCheckBoxValue() {
    if (isAgeCheckBoxValue) {
      isAgeCheckBoxValue = false;
    } else {
      isAgeCheckBoxValue = true;
    }
    notifyListeners();
  }

  void setCenterLocation(double latitude, double longitude) {
    // centerLatitude = 0.0;
    // centerLongitude = 0.0;
    BusinessGPSCoordinatesModel businessGPSCoordinatesModel =
        BusinessGPSCoordinatesModel(latitude, longitude);
    centerLatitude = businessGPSCoordinatesModel.latitude;
    centerLongitude = businessGPSCoordinatesModel.longitude;
    print("centerLatitude__>> $centerLatitude");
    print("centerLongitude__>> $centerLongitude");
    notifyListeners();
  }

  void getImageUrl(
      BuildContext context, File file, String fileName, String ext) async {
    isLoading = true;
    // imageUrl = await FileRequestManager()
    //     .uploadImageToS3(context, file, fileName, ext);
    FileRequestManager()
        .uploadImageToS3(context, file, fileName, ext)
        .then((value) {
      imageUrl = value;
      if (imageUrl != null) {
        isLoading = false;
        listImageUrl.add(imageUrl);
      } else {
        isLoading = true;
      }
      print("image_url=-=-> $imageUrl");
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getImageUrl(context, file, fileName, ext);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void removeImageFromList(int index) async {
    // final response = FileRequests().deleteImageFromS3(list_image_url[index]);
    listImageUrl.removeAt(index);
    print("listImageUrl LENGTH-=-=> ${listImageUrl.length}");
    notifyListeners();
  }

  void setStandardUserImage(File image) {
    // standardUserImageModel.standardUserImage = images;
    userImage = image;
    print("USER IMAGE====----->> $userImage");
    // userImage = images;
    notifyListeners();
  }

  void businessUserRegister(
    BuildContext context,
    String firstName,
    String lastName,
    String username,
    String email,
    String businessName,
    String businessAddress,
    String businessPhone,
    String latitude,
    String longitude,
    String city,
    String metropolitanArea,
    String contact,
    int userType,
    int isEighteen,
    int isAcceptedTac,
    String categoryId,
    String advertiseMedia,
    int metropolitanAreaId,
    int cityId,
    String businessWebsite,
    int isOnline,
    int isMobile,
  ) async {
    isLoading = true;
    notifyListeners();
    FileRequestManager()
        .businessUserRegister(
      firstName,
      lastName,
      username,
      email,
      businessName,
      businessAddress,
      businessPhone,
      latitude,
      longitude,
      city,
      metropolitanArea,
      contact,
      userType,
      isEighteen,
      isAcceptedTac,
      categoryId,
      advertiseMedia,
      metropolitanAreaId,
      cityId,
      businessWebsite,
      isOnline,
      isMobile,
    )
        .then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          print("baseresponse--->>== ${baseresponse.msg}");
          GlobalView().showToast(AppToastMessages.create_account_message);
          PreferenceUtils.setStringValue(PreferenceUtils.keyEmail, email);
          print(
              "EMAIL-->> ${PreferenceUtils.getStringValue(PreferenceUtils.keyEmail)}");
          // Navigator.pushNamed(context, AppRoutes.emailVerificationRouteName,
          //     arguments: email);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmailVerificationScreen(email)));
        }
      } else if (baseresponse.statuscode == 400) {
        DialogUtils.displayDialogCallBack(
            context,
            "",
            AppMessages.already_registered_title,
            baseresponse.msg,
            "",
            AppMessages.cancel_text,
            AppMessages.ok_text);
      }
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          businessUserRegister(
            context,
            firstName,
            lastName,
            username,
            email,
            businessName,
            businessAddress,
            businessPhone,
            latitude,
            longitude,
            city,
            metropolitanArea,
            contact,
            userType,
            isEighteen,
            isAcceptedTac,
            categoryId,
            advertiseMedia,
            metropolitanAreaId,
            cityId,
            businessWebsite,
            isOnline,
            isMobile,
          );
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void businessUserUpdateProfile(
    BuildContext context,
    String firstName,
    String lastName,
    String username,
    String email,
    String businessName,
    String businessAddress,
    String businessPhone,
    String latitude,
    String longitude,
    String contact,
    String categoryIds,
    String advertiseMedia,
    int metropolitanAreaId,
    int cityId,
    String cityName,
    String businessWebsite,
    int isOnline,
    int isMobile,
    File avatar,
  ) async {
    isLoading = true;
    notifyListeners();
    FileRequestManager()
        .businessUserUpdateProfile(
      context,
      firstName,
      lastName,
      username,
      email,
      businessName,
      businessAddress,
      businessPhone,
      latitude,
      longitude,
      contact,
      categoryIds,
      advertiseMedia,
      metropolitanAreaId,
      cityId,
      cityName,
      businessWebsite,
      isOnline,
      isMobile,
      avatar,
    )
        .then((response) {
      baseresponse = response;
      if (baseresponse.statuscode == 200) {
        if (baseresponse != null) {
          isLoading = false;
          print("baseresponse--->>== ${baseresponse.msg}");
          GlobalView().showToast(baseresponse.msg);
          userImage = null;
          Navigator.pop(context);
        } else {
          isLoading = true;
          GlobalView().showToast(baseresponse.msg);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          businessUserUpdateProfile(
            context,
            firstName,
            lastName,
            username,
            email,
            businessName,
            businessAddress,
            businessPhone,
            latitude,
            longitude,
            contact,
            categoryIds,
            advertiseMedia,
            metropolitanAreaId,
            cityId,
            cityName,
            businessWebsite,
            isOnline,
            isMobile,
            avatar,
          );
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  // ignore: missing_return
  Future<MetropolitanAreasListResponse> getMetropolitanAreasList(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();
    metropolitanAreasListResponse =
        await ApiManager(context).getMetropolitanAreasList();

    print("STATUS CODE-> ${metropolitanAreasListResponse.statuscode}");
    if (metropolitanAreasListResponse.statuscode == 200) {
      // if (metropolitanAreasListResponse != null &&
      //     metropolitanAreasListResponse.metropolitanAreas != null) {
      isLoading = false;
      print(
          "metropolitanAreasList Length--->>== ${metropolitanAreasListResponse.metropolitanAreas.length}");
      listMetropolitanAreaInfo.clear();
      for (var i = 0;
          i < metropolitanAreasListResponse.metropolitanAreas.length;
          i++) {
        if (metropolitanAreasListResponse
            .metropolitanAreas[i].cities.isNotEmpty) {
          listMetropolitanAreaInfo
              .add(metropolitanAreasListResponse.metropolitanAreas[i]);
          print(
              "listMetropolitanAreaInfo LENGTH-> ${listMetropolitanAreaInfo.length}");
          selectedMetropolitanAreaInfo = listMetropolitanAreaInfo[0];
          selectedMetroCityInfo = selectedMetropolitanAreaInfo.cities[0];
          listCities.addAll(selectedMetropolitanAreaInfo.cities);
        }
      }
      // MetropolitanAreaInfo metropolitanAreaInfo = new MetropolitanAreaInfo();
      // // metropolitanAreaInfo=selectedMetropolitanAreaInfo;
      // metropolitanAreaInfo.name = AppMessages.other_text;
      // print("NAME -> ${metropolitanAreaInfo.name}");
      // listMetropolitanAreaInfo.add(metropolitanAreaInfo);
      // print(
      //     "listMetropolitanAreaInfo length-> ${listMetropolitanAreaInfo.length}");
      // if (selectedMetropolitanAreaInfo.name == AppMessages.other_text) {
      //   selectedMetroCityInfo.name = AppMessages.other_text;
      // }
      return metropolitanAreasListResponse;
      // } else {
      //   isLoading = true;
      //   GlobalView().showToast(metropolitanAreasListResponse.msg);
      // }
    }
    notifyListeners();
  }

  void setAreaCityResponseNull() {
    selectedMetropolitanAreaInfo = null;
    selectedMetroCityInfo = null;
    notifyListeners();
  }

  void selectedMetropolitanAreaNameFun(String value) {
    listCities.clear();
    selectedMetropolitanAreaName = value;
    if (listMetropolitanAreaInfo.isNotEmpty) {
      for (var i = 0; i < listMetropolitanAreaInfo.length; i++) {
        if (listMetropolitanAreaInfo[i].name == selectedMetropolitanAreaName) {
          listCities.addAll(listMetropolitanAreaInfo[i].cities);
        }
      }
    }
    notifyListeners();
  }

  void changeEditableAreaValue() {
    isEditableArea = !isEditableArea;
    print("isEditableArea-> $isEditableArea");
    notifyListeners();
  }

  void changeEditableCityValue() {
    isEditableCity = !isEditableCity;
    print("isEditableCity-> $isEditableCity");
    notifyListeners();
  }

  void selectedMetropolitanArea(MetropolitanAreaInfo value) {
    selectedMetropolitanAreaInfo = null;
    selectedMetroCityInfo = null;

    // if (value.name == AppMessages.other_text) {
    //   isVisibleMetropolitanCity = true;
    // } else {
    listCities.clear();
    selectedMetropolitanAreaName = value.name;
    selectedMetropolitanAreaInfo = value;
    if (listMetropolitanAreaInfo.isNotEmpty) {
      for (var i = 0; i < listMetropolitanAreaInfo.length; i++) {
        if (listMetropolitanAreaInfo[i].name == selectedMetropolitanAreaName) {
          listCities.addAll(listMetropolitanAreaInfo[i].cities);
        }
      }
      selectedMetroCityInfo = selectedMetropolitanAreaInfo.cities[0];
      isVisibleMetropolitanCity = false;
    } else {
      selectedMetroCityInfo = null;
    }

    // }
    for (var i = 0; i < listMetropolitanAreaInfo.length; i++) {
      print("METRO AREA-> ${listMetropolitanAreaInfo[i].name}");
    }
    notifyListeners();
  }

  void selectedCity(MetropolitanCityInfo value) {
    print("MetropolitanCityInfo-> $value");
    selectedMetroCityInfo = null;
    // if (value.name == AppMessages.other_text) {
    //   selectedMetroCityInfo.name = AppMessages.other_text;
    // } else {
    // below commented code for filterview with city.
    // if (listMetropolitanAreaInfo.isNotEmpty) {
    //   for (var i = 0; i < listMetropolitanAreaInfo.length; i++) {
    //     if (listMetropolitanAreaInfo[i].name == selectedMetropolitanAreaName) {
    //       selectedMetroCityInfo = value;
    //     }
    //   }
    // }
    selectedMetroCityInfo = value;
    // }
    notifyListeners();
  }

  void getBusinessUserProfile(BuildContext context) async {
    isLoading = true;
    ApiManager(context).getBusinessUserProfile().then((response) {
      businessUserProfileResponse = response;
      if (businessUserProfileResponse.statuscode == 200) {
        if (businessUserProfileResponse != null &&
            businessUserProfileResponse.user != null) {
          print("B NAME-> ${businessUserProfileResponse.user.businessName}");
          isLoading = false;
          PreferenceUtils.setObject(
              PreferenceUtils.keyBusinessUserProfileObject,
              json.encode(businessUserProfileResponse.user));
          if (businessUserProfileResponse.user.businessKeywords != "" &&
              businessUserProfileResponse.user.businessKeywords != null) {
            listBusinessKeywords.addAll(
                businessUserProfileResponse.user.businessKeywords.split(","));
            print(
                "KEYWORD FROM API=> ${businessUserProfileResponse.user.businessKeywords}");
          }
          if (businessUserProfileResponse.latLong != null &&
              businessUserProfileResponse.latLong.length > 0) {
            // listLatLong.addAll(businessUserProfileResponse.latLong);
            listLatLong = businessUserProfileResponse.latLong;
          }
          // if (businessUserProfileResponse.user.categories.isNotEmpty && businessUserProfileResponse.user.categories != null ) {
          //   Provide
          // }
          if (businessUserProfileResponse.user.businessMedia.isNotEmpty) {
            listMediaImages.clear();
            for (var i = 0;
                i < businessUserProfileResponse.user.businessMedia.length;
                i++) {
              listMediaImages
                  .add(businessUserProfileResponse.user.businessMedia[i].media);
            }
          }
          if (businessUserProfileResponse.user.businessHours.isNotEmpty) {
            getTimezoneObject(
                businessUserProfileResponse.user.businessTimeZone);
            listBusinessHours.clear();
            listBusinessHours
                .addAll(businessUserProfileResponse.user.businessHours);
            // listOpenTime.clear();
            // listCloseTime.clear();
            for (var i = 0; i < listBusinessHours.length; i++) {
              // listOpenTime.add(listBusinessHours[i].openTime);
              // listCloseTime.add(listBusinessHours[i].closeTime);
              if (listBusinessHours[i].openTime == "-1" &&
                  listBusinessHours[i].closeTime == "-1") {
                listBusinessHours[i].isOpen = false;
              } else {
                listBusinessHours[i].isOpen = true;
              }
            }
            DayTimeUtils().convertUtcToLocal(
                list: listBusinessHours, context: context, isOpenTime: true);
            DayTimeUtils().convertUtcToLocal(
                list: listBusinessHours, context: context, isOpenTime: false);
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getBusinessUserProfile(context);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void getTimezoneObject(String timezone) {
    if (timezone != "") {
      for (var i = 0; i < timeZoneResponse.timeZone.length; i++) {
        if (timeZoneResponse.timeZone[i].value == timezone) {
          selectedTimeZone = timeZoneResponse.timeZone[i];
          break;
        }
      }
    } else {
      selectedTimeZone = timeZoneResponse.timeZone[0];
    }
    print("selectedTimeZone-> ${selectedTimeZone.toJson()}");
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    current = index;
    notifyListeners();
  }

  void profileCheckInsLike(
      BuildContext context, int feedId, int isLike, int index) async {
    print("feed_id->> $feedId");
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (isLike == 1) {
            businessUserProfileResponse.user.feed[index].isLiked = 1;
            businessUserProfileResponse.user.feed[index].totalLikes =
                businessUserProfileResponse.user.feed[index].totalLikes + 1;
          } else {
            businessUserProfileResponse.user.feed[index].isLiked = 0;
            businessUserProfileResponse.user.feed[index].totalLikes =
                businessUserProfileResponse.user.feed[index].totalLikes - 1;
          }
          GlobalView().showToast(AppMessages.like_business_text);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          profileCheckInsLike(context, feedId, isLike, index);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void updateListKeywords(BuildContext context, String businessKeywords) {
    ApiManager(context).updateListKeywords(businessKeywords).then((response) {
      updateListKeywordsResponse = response;
      if (updateListKeywordsResponse != null) {
        print(
            "updateListKeywordsResponse--->>== ${updateListKeywordsResponse.msg}");
        if (updateListKeywordsResponse.statuscode == 200 ||
            updateListKeywordsResponse.statuscode == 201) {
          if (updateListKeywordsResponse.businessKeywords != "" &&
              updateListKeywordsResponse.businessKeywords != null) {
            listBusinessKeywords.clear();
            listBusinessKeywords
                .addAll(updateListKeywordsResponse.businessKeywords.split(","));
            print(
                " KEYWORD FROM API=> ${updateListKeywordsResponse.businessKeywords}");
          }
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          updateListKeywords(context, businessKeywords);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void addToListBusinessKeywords(String value) {
    if (!listBusinessKeywords.contains(value) &&
        !listBusinessKeywords.contains(" ")) {
      listBusinessKeywords.add(value);
    } else {
      if (listBusinessKeywords.contains(value)) {
        GlobalView().showToast(AppToastMessages.available_keywords_message);
      } else {
        GlobalView().showToast(AppToastMessages.remove_whitespace_message);
      }
    }
    print("listBusinessKeywords length-> ${listBusinessKeywords.length}");
    notifyListeners();
  }

  void removeFromListBusinessKeywords(int index, BuildContext context) {
    listBusinessKeywords.removeAt(index);
    updateListKeywords(context, listBusinessKeywords.join(","));
    notifyListeners();
  }

  void graphLike(BuildContext context, int businessUserId, String graphRange) {
    isLoading = true;
    ApiManager(context).graphLike(businessUserId, graphRange).then((response) {
      print("response-> $response");
      graphResponse = response;
      print("graphLikeResponse-> $graphResponse");
      if (graphResponse != null) {
        print("graphLikeResponse--->>== ${graphResponse.msg}");
        if (graphResponse.statuscode == 200 ||
            graphResponse.statuscode == 201) {
          if (graphResponse.data != null) {
            listGraphLikeData.clear();
            for (var i = 0; i < graphResponse.data.month.length; i++) {
              listGraphLikeData.add(
                GraphData(
                  graphResponse.data.month[i],
                  graphResponse.data.value[i],
                ),
              );
              // map.add(
              //   // ${graphLikeResponse.data.month[i]}:
              //     "data":
              //     graphLikeResponse.data.value[i]);
            }
          }
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
          graphLike(context, businessUserId, graphRange);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void graphView(BuildContext context, int businessUserId, String graphRange) {
    isLoading = true;
    ApiManager(context).graphView(businessUserId, graphRange).then((response) {
      print("response-> $response");
      graphResponse = response;
      print("graphLikeResponse-> $graphResponse");
      if (graphResponse != null) {
        print("graphLikeResponse--->>== ${graphResponse.msg}");
        if (graphResponse.statuscode == 200 ||
            graphResponse.statuscode == 201) {
          if (graphResponse.data != null) {
            listGraphLikeData.clear();
            for (var i = 0; i < graphResponse.data.month.length; i++) {
              listGraphLikeData.add(
                GraphData(
                  graphResponse.data.month[i],
                  graphResponse.data.value[i],
                ),
              );
              // map.add(
              //   // ${graphLikeResponse.data.month[i]}:
              //     "data":
              //     graphLikeResponse.data.value[i]);
            }
          }
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
          graphView(context, businessUserId, graphRange);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void graphClick(BuildContext context, int businessUserId, String graphRange) {
    isLoading = true;
    ApiManager(context).graphClick(businessUserId, graphRange).then((response) {
      print("response-> $response");
      graphResponse = response;
      print("graphLikeResponse-> $graphResponse");
      if (graphResponse != null) {
        print("graphLikeResponse--->>== ${graphResponse.msg}");
        if (graphResponse.statuscode == 200 ||
            graphResponse.statuscode == 201) {
          if (graphResponse.data != null) {
            listGraphLikeData.clear();
            for (var i = 0; i < graphResponse.data.month.length; i++) {
              listGraphLikeData.add(
                GraphData(
                  graphResponse.data.month[i],
                  graphResponse.data.value[i],
                ),
              );
              // map.add(
              //   // ${graphLikeResponse.data.month[i]}:
              //     "data":
              //     graphLikeResponse.data.value[i]);
            }
          }
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
          graphClick(context, businessUserId, graphRange);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void addBusinessLatlong(
      BuildContext context,
      String latitude,
      String longitude,
      int isDefault,
      int businessLocationId,
      String locationName) {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .addBusinessLatlong(
            latitude, longitude, isDefault, businessLocationId, locationName)
        .then((response) {
      print("response-> $response");
      businessLatlongResponse = response;
      print("updateBusinessLatlongResponse-> $businessLatlongResponse");
      if (businessLatlongResponse != null) {
        print("graphLikeResponse--->>== ${businessLatlongResponse.msg}");
        if (businessLatlongResponse.statuscode == 200 ||
            businessLatlongResponse.statuscode == 201) {
          if (businessLatlongResponse.latLong != null &&
              businessLatlongResponse.latLong.length > 0) {
            listLatLong.clear();
            listLatLong.addAll(businessLatlongResponse.latLong);
          }
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
          addBusinessLatlong(context, latitude, longitude, isDefault,
              businessLocationId, locationName);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void deleteBusinessLatlong(
    BuildContext context,
    LatLongInfo latLongInfo,
  ) {
    isLoading = true;
    notifyListeners();
    ApiManager(context).deleteBusinessLatlong(latLongInfo.id).then((response) {
      print("response-> $response");
      baseresponse = response;
      print("updateBusinessLatlongResponse-> $baseresponse");
      if (baseresponse != null) {
        print("graphLikeResponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (latLongInfo != null) {
            if (listLatLong.length > 0) {
              listLatLong.remove(latLongInfo);
            }
          }
        } else {
          GlobalView().showToast(baseresponse.msg);
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
          deleteBusinessLatlong(context, latLongInfo);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void changeCheckBoxValue(int id, bool value, BuildContext context) {
    if (listLatLong.isNotEmpty) {
      for (var i = 0; i < listLatLong.length; i++) {
        if (listLatLong[i].id == id) {
          listLatLong[i].isDefault = 1;
          addBusinessLatlong(context, listLatLong[i].latitude,
              listLatLong[i].longitude, 1, listLatLong[i].id, "");
        } else {
          listLatLong[i].isDefault = 0;
          // addBusinessLatlong(context, listLatLong[i].latitude,
          //     listLatLong[i].longitude, 0, listLatLong[i].id);
        }
      }
    }
    notifyListeners();
  }

  void setViewsLikesClicksValue(String route) {
    if (route.toLowerCase() == AppMessages.view_text.toLowerCase()) {
      isViews = true;
      isLikes = false;
      isClicks = false;
    } else if (route.toLowerCase() == AppMessages.like_text.toLowerCase()) {
      isLikes = true;
      isViews = false;
      isClicks = false;
    } else {
      isClicks = true;
      isViews = false;
      isLikes = false;
    }
    notifyListeners();
  }

  void changeFilterCheckBoxValue(
      {@required bool value, @required String route}) {
    if (route.toLowerCase() == AppMessages.city_text.toLowerCase()) {
      isCitySelected = value;
      isDistanceRadiusSelected = !value;
    } else {
      isDistanceRadiusSelected = value;
      isCitySelected = !value;
    }
    print("value-> $value");
    print("isDistanceRadiusSelected-> $isDistanceRadiusSelected");
    print("isCitySelected-> $isCitySelected");
    notifyListeners();
  }

  void changeSegmentValue({@required String route}) {
    if (route.toLowerCase() == AppMessages.city_text.toLowerCase()) {
      isCitySelected = true;
      isDistanceRadiusSelected = false;
    } else {
      isDistanceRadiusSelected = true;
      isCitySelected = false;
    }
    // print("value-> $value");
    print("isDistanceRadiusSelected-> $isDistanceRadiusSelected");
    print("isCitySelected-> $isCitySelected");
    notifyListeners();
  }

  void setSelectedDropDownValue(String value) {
    selectedDropDownValue = value;
    notifyListeners();
  }

  void setTimezoneValue(TimezoneInfo value) {
    selectedTimeZone = value;
    notifyListeners();
  }

  void setOpenCloseTimeValue(TimeOfDay _time, bool isOpenTime) {
    DateTime date = new DateTime.now();
    if (isOpenTime) {
      openTime = _time;
      date = new DateTime(
          date.year, date.month, date.day, openTime.hour, openTime.minute);
      final timeZone = tz.getLocation(selectedTimeZone.utc[0]);
      DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
      print("Time-> ${dateTimeConverted.hour}");
      print("Time-> ${dateTimeConverted.minute}");
      listOpenTime.clear();
      for (var i = 0; i < 7; i++) {
        listOpenTime.add(dateTimeConverted.hour.toString() +
            ":" +
            dateTimeConverted.hour.toString());
      }
      print("listOpenTime-> ${listOpenTime.join(",")}");
    } else {
      closeTime = _time;
      date = new DateTime(
          date.year, date.month, date.day, closeTime.hour, closeTime.minute);
      final timeZone = tz.getLocation(selectedTimeZone.utc[0]);
      DateTime dateTimeConverted = tz.TZDateTime.from(date, timeZone);
      print("Time-> ${dateTimeConverted.hour}");
      print("Time-> ${dateTimeConverted.minute}");
      listCloseTime.clear();
      for (var i = 0; i < 7; i++) {
        listCloseTime.add(dateTimeConverted.hour.toString() +
            ":" +
            dateTimeConverted.hour.toString());
      }
      print("listOpenTime-> ${listCloseTime.join(",")}");
    }

    notifyListeners();
  }

  Future<void> getTimeZoneData() async {
    final String response =
        await rootBundle.loadString(AppImages.timezone_json);
    timeZoneResponse = TimeZoneResponse.fromJson(json.decode(response));
    selectedTimeZone = timeZoneResponse.timeZone[0];
    print("Data-> ${timeZoneResponse.timeZone[0].utc[0]}");
    // listTimeZone = data["items"];
    // print("listTimeZone-> ${listTimeZone[0]["utc"][0]}");
    // for (var i = 0; i < listTimeZone.length; i++)
    //   print(listTimeZone[i]["value"]);
  }

  void addBusinessHours(BuildContext context) {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .addBusinessHours(
            businessUserProfileResponse.user.id.toString(),
            listOpenTime.join(","),
            listCloseTime.join(","),
            selectedTimeZone.value)
        .then((response) {
      print("response-> $response");
      baseresponse = response;
      print("updateBusinessLatlongResponse-> $baseresponse");
      if (baseresponse != null) {
        print("graphLikeResponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          GlobalView().showToast(baseresponse.msg);
          Navigator.pop(context);
        } else {
          GlobalView().showToast(baseresponse.msg);
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
          addBusinessHours(context);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void setBusineddHoursOpenCloseValue(
    bool isOpenTime,
    BusinessHoursResponse response,
    TimeOfDay _time,
    BuildContext context,
  ) {
    DateTime date = new DateTime.now();
    if (isOpenTime) {
      openTime = _time;
      date = new DateTime(
          date.year, date.month, date.day, openTime.hour, openTime.minute);
      response.openTime = date.hour.toString() + ":" + date.minute.toString();
      // DayTimeUtils().convertLocalToUtc(
      //   list: listBusinessHours,
      //   context: context,
      //   isOpenTime: true,
      // );
    } else {
      closeTime = _time;
      date = new DateTime(
          date.year, date.month, date.day, closeTime.hour, closeTime.minute);
      response.closeTime = date.hour.toString() + ":" + date.minute.toString();
      // DayTimeUtils().convertLocalToUtc(
      //   list: listBusinessHours,
      //   context: context,
      //   isOpenTime: false,
      // );
    }
    notifyListeners();
  }

  void setBusinessHourSwitchValue(
      int index, BusinessHoursResponse response, bool value) {
    if (value == false) {
      response.openTime = "-1";
      response.closeTime = "-1";
      listOpenTime[index] = "-1";
      listCloseTime[index] = "-1";
    }
    response.isOpen = value;

    notifyListeners();
  }
}

class GraphData {
  GraphData(this.month, this.value);
  String month;
  int value;
}
//  GraphLikeData(
//     this.month,
//     this.value,
//   )

//   List<String> month;
//   List<int> value;
import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/business_city_response.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';

class FilterProvider extends ChangeNotifier {
  String searchValue = "";
  String cityValue = "";
  List<String> listDistances = ["1", "5", "25"];
  String distanceRadius = "5";
  BusinessCityResponse businessCityResponse;
  List<String> listCities = [];
  String selectedMetropolitanCityInfo = "";
  bool isCitySelected = true;
  bool isDistanceRadiusSelected = false;
  TextEditingController citySearchController = TextEditingController();

  void setDistanceRadius(String radius) {
    distanceRadius = radius;
    // selectedMetropolitanCityInfo = "";
    notifyListeners();
  }

  String getHomeFilterText({@required String category}) {
    return "Searching $category within $distanceRadius miles near me";
  }

  void setSearchValue(String value) {
    print("FilterProvider value--> $value");
    searchValue = value;
    print("FilterProvider searchValue--> $searchValue");
    notifyListeners();
  }

  void setCityValue(String value) {
    cityValue = value;
    // distanceRadius = "0";
    notifyListeners();
  }

  void selectedCity(String value) {
    print("MetropolitanCityInfo-> $value");
    selectedMetropolitanCityInfo = null;
    selectedMetropolitanCityInfo = value;
    print("metropolitanCityInfo-> $selectedMetropolitanCityInfo");
    // distanceRadius = "0";
    // }
    notifyListeners();
  }

  List<String> searchByCity(BuildContext context, String searchValue) {
    // List<String> list = <String>[];
    ApiManager(context).searchByCity(searchValue).then((response) {
      businessCityResponse = response;
      if (businessCityResponse.statuscode == 200 ||
          businessCityResponse.statuscode == 201) {
        if (businessCityResponse.data.isNotEmpty) {
          listCities.clear();
          listCities.addAll(businessCityResponse.data);

          // list.addAll(listCities);
          // print("List-> ${list.toList()}");
          listCities.retainWhere(
              (s) => s.toLowerCase().contains(searchValue.toLowerCase()));
        }
      }
      notifyListeners();
    }).catchError((onError) {
      ShowAlertView(
              context: context,
              onCallBack: () {
                searchByCity(context, searchValue);
              },
              exception: onError)
          .showAlertDialog();
    });
    return listCities;
  }

  void changeSegmentValue({@required String route}) {
    if (route.toLowerCase() == AppMessages.city_text.toLowerCase()) {
      isCitySelected = true;
      isDistanceRadiusSelected = false;
    } else {
      isDistanceRadiusSelected = true;
      isCitySelected = false;
      distanceRadius = "5";
      listCities.clear();
      selectedMetropolitanCityInfo = "";
      cityValue = "";
      citySearchController.text = "";
    }
    // print("value-> $value");
    print("isDistanceRadiusSelected-> $isDistanceRadiusSelected");
    print("isCitySelected-> $isCitySelected");
    notifyListeners();
  }

  // List<String> getCitySuggestions(BuildContext context, String query) {
  //   searchByCity(context, query);
  // List<String> list = <String>[];
  // list.addAll(listCities);
  // print("List-> ${list.toList()}");
  // list.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  //   return list;
  // }
}

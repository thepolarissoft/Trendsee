import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/data/models/business_city_response.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';

class FilterProvider extends ChangeNotifier {
  String searchValue = "";
  String cityValue = "";
  List<String> listDistances = ["1 Mile", "5 Miles"];
  String distanceRadius = "5";
  BusinessCityResponse businessCityResponse;
  List<String> listCities = [];
  String selectedMetropolitanCityInfo = "";
  void setDistanceRadius(String radius) {
    distanceRadius = radius;
    notifyListeners();
  }

  void setSearchValue(String value) {
    searchValue = value;
    notifyListeners();
  }

  void setCityValue(String value) {
    cityValue = value;
    notifyListeners();
  }

  void selectedCity(String value) {
    print("MetropolitanCityInfo-> $value");
    selectedMetropolitanCityInfo = null;
    selectedMetropolitanCityInfo = value;
    print("metropolitanCityInfo-> $selectedMetropolitanCityInfo");
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

  // List<String> getCitySuggestions(BuildContext context, String query) {
  //   searchByCity(context, query);
  // List<String> list = <String>[];
  // list.addAll(listCities);
  // print("List-> ${list.toList()}");
  // list.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  //   return list;
  // }
}

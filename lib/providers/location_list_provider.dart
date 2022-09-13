import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/data/models/location_list_response.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';

class LocationListProvider extends ChangeNotifier {
  LocationListResponse? locationListResponse;
  bool isLoading = false;
  bool isChecked = false;

  void getLocationList(BuildContext context) async {
    isLoading = true;
    // notifyListeners();
    ApiManager(context).getLocationList().then((response) {
      locationListResponse = response;
      if (locationListResponse!.statuscode == 200) {
        if (locationListResponse != null) {
          isLoading = false;
        } else {
          isLoading = false;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getLocationList(context);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void changeCheckBoxValue(int index, bool value) {
    isChecked = value;
    locationListResponse!.location![index].isChecked = value;
    notifyListeners();
  }
}

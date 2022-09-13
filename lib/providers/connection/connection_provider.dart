import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  bool isInternetConnection = true;

  void setConnectionValue(bool isInternet) {
    this.isInternetConnection = isInternet;
    print("provider isInternetConnection-> $isInternetConnection");
    notifyListeners();
  }
}

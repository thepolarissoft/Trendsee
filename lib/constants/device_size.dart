import 'package:flutter/material.dart';

class DeviceSize {
  double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

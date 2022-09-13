import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/standardUser/select_business_address_from_map_page.dart';

class SelectBusinessAddressFromMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(SelectBusinessAddressFromMapPage());
  }
}

import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/standardUser/select_business_for_add_new_check_in_page.dart';

class SelectBusinessForAddNewCheckInScreen extends StatelessWidget {
  String? route;
  SelectBusinessForAddNewCheckInScreen({this.route});
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(SelectBusinessForAddNewCheckInPage(route: route ?? '',));
  }
}

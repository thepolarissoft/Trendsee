import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/standardUser/add_new_check_in_page.dart';

class AddNewCheckInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(AddNewCheckInPage());
  }
}

import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/businessUser/business_user_registration_page.dart';

// ignore: must_be_immutable
class BusinessUserRegistrationScreen extends StatelessWidget {
  bool isEditable;
  BusinessUserRegistrationScreen(this.isEditable);
  @override
  Widget build(BuildContext context) {
    return GlobalView()
        .safeAreaView(BusinessUserRegistrationPage(this.isEditable));
  }
}

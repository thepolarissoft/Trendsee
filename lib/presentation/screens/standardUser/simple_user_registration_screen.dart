import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/standardUser/simple_user_registration_page.dart';

// ignore: must_be_immutable
class SimpleUserRegistrationScreen extends StatelessWidget {
  bool isEditable;
  SimpleUserRegistrationScreen(this.isEditable);
  @override
  Widget build(BuildContext context) {
    return GlobalView()
        .safeAreaView(SimpleUserRegistrationPage(this.isEditable));
  }
}

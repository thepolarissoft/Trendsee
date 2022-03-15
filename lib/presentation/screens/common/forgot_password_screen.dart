import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/forgot_password_page.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(ForgotPasswordPage());
  }
}

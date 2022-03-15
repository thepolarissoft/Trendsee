import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/email_verification_page.dart';

// ignore: must_be_immutable
class EmailVerificationScreen extends StatelessWidget {
  String email;
  EmailVerificationScreen(this.email);
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(EmailVerificationPage(email));
  }
}

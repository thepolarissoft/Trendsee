import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/email_verification_page.dart';

// ignore: must_be_immutable
class EmailVerificationScreen extends StatelessWidget {
  String email;
  bool isVerifyByBusinessID;
  int businessID = 0;
  EmailVerificationScreen({
    this.businessID = 0,
    this.email,
    this.isVerifyByBusinessID = false,
  });
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(EmailVerificationPage(
      email,
      isVerifyByBusinessID,
      businessID: businessID,
    ));
  }
}

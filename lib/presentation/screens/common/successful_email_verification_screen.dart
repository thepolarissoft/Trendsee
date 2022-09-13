import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/successful_email_verification_page.dart';

class SuccessfulEmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(SuccessfulEmailVerificationPage());
  }
}

import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_i_liked_page.dart';

class BusinessLikedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.red,
        image: DecorationImage(
            image: AssetImage(AppImages.background_image1), fit: BoxFit.cover),
      ),
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: BaseColor.home_bg_color,
          body: BusinessLikedPage(),
        ),
      ),
    );
  }
}

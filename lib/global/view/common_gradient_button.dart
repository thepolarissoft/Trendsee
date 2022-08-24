import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';

import 'global_view.dart';

// ignore: must_be_immutable
class CommonGradientButton extends StatelessWidget {
  CommonGradientButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.fontWeight,
      this.textColor,
      this.padding,
      this.gradientColors})
      : super(key: key);

  VoidCallback onPressed;
  String title;
  FontWeight? fontWeight;
  Color? textColor;
  EdgeInsetsGeometry? padding;
  List<Color>? gradientColors;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => OnlineBusinessCheckInScreen()));
        // // location.setOnlineCheckIn();
        onPressed();
      },
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradientColors ??
                  [
                    BaseColor.btn_gradient_start_color1,
                    BaseColor.btn_gradient_end_color1
                  ]),
          boxShadow: [
            BoxShadow(
                color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
          ],
          // borderRadius: BorderRadius.circular(25),
        ),
        width: DeviceSize().deviceWidth(context),
        child: GlobalView().textViewWithCenterAlign(
            title,
            AppTextStyle.inter_font_family,
            fontWeight ?? AppTextStyle.bold_font_weight,
            textColor ?? BaseColor.pure_white_color,
            18),
      ),
    );
  }
}

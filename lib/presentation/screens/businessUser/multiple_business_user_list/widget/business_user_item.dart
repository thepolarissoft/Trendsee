// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/verify_otp_provider.dart';

class BusinessUserItem extends StatelessWidget {
  BusinessUserItem({Key key, @required this.businessUser}) : super(key: key);
  VerifiedUserResponse businessUser = VerifiedUserResponse();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (businessUser.isApproved == 1) {
          Provider.of<VerifyOtpProvider>(context, listen: false)
              .getUserByIdToken(context, businessUser.id);
        } else {
          GlobalView().showToast(AppMessages.approval_user_message);
        }
      },
      child: Card(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                          image: businessUser.avatar != ""
                              ? NetworkImage(businessUser.avatar)
                              : AssetImage(AppImages.default_profile_Pic),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalView().textViewWithStartAlign(
                            businessUser.businessName,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.btn_gradient_end_color1,
                            16),
                        GlobalView().textViewWithStartAlign(
                            businessUser.username,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.semi_bold_font_weight,
                            BaseColor.black_color,
                            18),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GlobalView().textViewWithStartAlign(
                      businessUser.isApproved == 1
                          ? AppMessages.approved_text
                          : "",
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      Color.fromARGB(255, 12, 134, 67),
                      16),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Colors.red,
                  child: GlobalView().textViewWithCenterAlign(
                      AppMessages.business_users_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.semi_bold_font_weight,
                      BaseColor.black_color,
                      16),
                ))
          ],
        ),
      ),
    );
  }
}

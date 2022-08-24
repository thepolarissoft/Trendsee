// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/common/set_passcode_screen.dart';
import 'package:trendoapp/providers/verify_otp_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';

class BusinessUserItem extends StatelessWidget {
  BusinessUserItem({Key? key, required this.businessUser}) : super(key: key);
  VerifiedUserResponse businessUser = VerifiedUserResponse();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("businessUser ID ${businessUser.id}");
        if (businessUser.isApproved == 1) {
          Provider.of<VerifyOtpProvider>(context, listen: false)
              .getUserByIdToken(context, businessUser.id);
        } else {
          if (businessUser.isVerified == 0) {
            // Provider.of<VerifyOtpProvider>(context, listen: false)
            //     .sendOTPByBusinessID(context, businessUser.id);
            Navigator.pushNamed(context, AppRoutes.setPasscode,
                arguments: SetPasscodeArgs(email: businessUser.email));
          } else {
            DialogUtils().showSupportAlertDialog(context, "approval");
          }
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: DeviceSize().deviceWidth(context) * 0.2,
                    width: DeviceSize().deviceWidth(context) * 0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                          image: (businessUser.avatar != ""
                              ? NetworkImage(businessUser.avatar!)
                              : AssetImage(AppImages.default_profile_Pic)) as ImageProvider<Object>,
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
                            businessUser.businessName!,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.btn_gradient_end_color1,
                            16),
                        GlobalView().textViewWithStartAlign(
                            businessUser.username!,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.semi_bold_font_weight,
                            BaseColor.black_color,
                            18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  decoration: BoxDecoration(
                      color: businessUser.isApproved == 1
                          ? Colors.green
                          : BaseColor.forgot_pass_txt_color,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12))),
                  child: GlobalView().textViewWithCenterAlign(
                      getBusinessStatus(businessUser),
                      AppTextStyle.inter_font_family,
                      AppTextStyle.semi_bold_font_weight,
                      BaseColor.pure_white_color,
                      16),
                ))
          ],
        ),
      ),
    );
  }

  String getBusinessStatus(VerifiedUserResponse user) {
    String str = AppMessages.approved_text;
    if (user.isVerified == 0) {
      str = AppMessages.verify_text;
    } else if (user.isApproved == 0) {
      str = AppMessages.not_approve_text;
    } else if (user.isApproved == 1) {
      str = AppMessages.approved_text;
    }
    return str;
  }
}

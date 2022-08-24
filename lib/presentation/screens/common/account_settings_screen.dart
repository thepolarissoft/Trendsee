import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/business_user_profile_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/settings/account_settings_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';

// ignore: must_be_immutable
class AccountSettingsScreen extends StatelessWidget {
  ProfileResponse? profileResponse;
  BusinessUserProfileResponse? businessUserProfileResponse;
  int userType;
  AccountSettingsScreen({
    Key? key,
    required this.profileResponse,
    required this.businessUserProfileResponse,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.home_bg_color,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            AppImages.background_image1,
          ),
          fit: BoxFit.cover,
          // alignment: Alignment.topCenter,
        )),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GlobalView().sizedBoxView(40),
                  Container(
                    alignment: Alignment.topCenter,
                    child: GlobalView().textViewWithCenterAlign(
                        AppMessages.account_settings_title,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.semi_bold_font_weight,
                        BaseColor.black_color,
                        18),
                  ),
                  GlobalView().sizedBoxView(30),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: GlobalView().textViewWithStartAlign(
                            AppMessages.notification_settings_title,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color,
                            14),
                      ),
                      Consumer<AccountSettingsProvider>(
                          builder: (context, provider, child) {
                        return FlutterSwitch(
                          width: 52,
                          height: 30,
                          // value: provider.allowNotification,
                          value: userType == 1
                              ? profileResponse!.user!.allowNotification == 1
                                  ? true
                                  : false
                              : businessUserProfileResponse!
                                          .user!.allowNotification ==
                                      1
                                  ? true
                                  : false,
                          borderRadius: 20,
                          padding: 4,
                          activeColor: BaseColor.btn_gradient_end_color2,
                          // showOnOff: true,
                          onToggle: (value) {
                            provider.setNotificationSwitchValue(value);
                            provider.saveNotificationSettings(context,
                                profileResponse, businessUserProfileResponse);
                          },
                        );
                      }),
                    ],
                  ),
                  GlobalView().sizedBoxView(15),
                  Divider(
                    color: BaseColor.divider_color.withOpacity(0.4),
                  ),
                  GlobalView().sizedBoxView(15),
                  GestureDetector(
                    onTap: () {
                      DialogUtils().onClickSettings(context, "deactivate");
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: GlobalView().textViewWithStartAlign(
                              AppMessages.account_de_active_message,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              14),
                        ),
                        Image.asset(
                          AppImages.ic_next2,
                          height: 16,
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  GlobalView().sizedBoxView(15),
                  Divider(
                    color: BaseColor.divider_color.withOpacity(0.4),
                  ),
                  GlobalView().sizedBoxView(15),
                  GestureDetector(
                    onTap: () {
                      DialogUtils().onClickSettings(context, "delete");
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: GlobalView().textViewWithStartAlign(
                              AppMessages.account_delete_message,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              14),
                        ),
                        Image.asset(
                          AppImages.ic_next2,
                          height: 16,
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  GlobalView().sizedBoxView(15),
                  Divider(
                    color: BaseColor.divider_color.withOpacity(0.4),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 57,
              left: 21,
              child: Container(
                // color: Colors.red,
                height: 25,
                width: 25,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GlobalView().assetImageView(AppImages.ic_back)),
              ),
            ),
            // Positioned(
            //   bottom: 50,
            //   left: 30,
            //   right: 30,
            //   child: GestureDetector(
            //     onTap: () {
            //       print("object");
            //     },
            //     child: GlobalView()
            //         .buttonFilled(context, AppMessages.save_changes_btn_text),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

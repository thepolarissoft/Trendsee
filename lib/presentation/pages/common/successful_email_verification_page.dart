import 'package:flutter/material.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/utils/url_launcher.dart';

class SuccessfulEmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
            // GlobalView().assetImageView(AppImages.backgroundImage1),
            Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: DeviceSize().deviceHeight(context) / 8),
                        child: SizedBox(
                            height: 120,
                            width: 120,
                            child: GlobalView()
                                .assetImageView(AppImages.ic_success)),
                      ),
                      GlobalView().sizedBoxView(20),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: GlobalView().textViewWithCenterAlign(
                            AppMessages.approve_msg,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.normal_font_weight,
                            BaseColor.black_color,
                            18),
                      ),
                      GlobalView().sizedBoxView(40),
                      GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, AppRoutes.signin_route_name);
                            UrlLauncher().launchUrl(ApiUrls.msa_url);
                          },
                          child: GlobalView().buttonFilled(
                              context, AppMessages.continue_text)),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: DeviceSize().deviceHeight(context) / 8),
                      //   child: SizedBox(
                      //       height: 120,
                      //       width: 120,
                      //       child: GlobalView()
                      //           .assetImageView(AppImages.ic_success)),
                      // ),
                      // GlobalView().sizedBoxView(20),
                      // GlobalView().textViewWithCenterAlign(
                      //     AppMessages.success_title,
                      //     AppTextStyle.inter_font_family,
                      //     AppTextStyle.bold_font_weight,
                      //     BaseColor.black_color,
                      //     24),
                      // GlobalView().sizedBoxView(20),
                      // GlobalView().textViewWithCenterAlign(
                      //     AppMessages.success_message,
                      //     AppTextStyle.inter_font_family,
                      //     AppTextStyle.normal_font_weight,
                      //     BaseColor.black_color.withOpacity(0.5),
                      //     16),
                      // GlobalView().sizedBoxView(40),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 30),
                      //   child: Consumer<VerifyOtpProvider>(
                      //       builder: (_, user, child) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         // print(
                      //         //     "User Type-> ${user.verifiedOtpResponse.user.userType}");
                      //         // print(
                      //         //     "User Token-> ${user.verifiedOtpResponse.token}");
                      //         if (StorageUtils.readIntValue(
                      //                 StorageUtils.keyUserType) !=
                      //             null) {
                      //           if (StorageUtils.readIntValue(
                      //                   StorageUtils.keyUserType) ==
                      //               1) {
                      //             Navigator.pushNamed(
                      //                 context, AppRoutes.timeline_route_name);
                      //           } else {
                      //             // if (UserUtils.token != null) {
                      //             //   Navigator.pushNamed(context,
                      //             //       AppRoutes.business_timeline_route_name);
                      //             // } else {
                      //             //   Navigator.pushNamed(
                      //             //       context, AppRoutes.signin_route_name);
                      //             // }
                      //             Navigator.pushNamed(context,
                      //                 AppRoutes.business_timeline_route_name);
                      //           }
                      //         }
                      //       },
                      //       child: GlobalView()
                      //           .buttonFilled(context, AppMessages.feed_show),
                      //     );
                      //   }),
                      // ),
                    ],
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}

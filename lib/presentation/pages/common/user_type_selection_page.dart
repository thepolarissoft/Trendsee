import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/businessUser/business_user_registration_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/simple_user_registration_screen.dart';
import 'package:trendoapp/utils/preference_utils.dart';

class UserTypeSelectionPage extends StatelessWidget {
  Widget build(BuildContext context) {
    print(
        "IS CONNECTION-> ${PreferenceUtils.getBoolValue(PreferenceUtils.isInternet)}");
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
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 80),
              child: Center(
                child: SizedBox(
                  height: DeviceSize().deviceHeight(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(
                              // top: DeviceSize().deviceHeight(context) * 0.01,
                              bottom: DeviceSize().deviceHeight(context) * 0.04,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SimpleUserRegistrationScreen(
                                                false)));
                              },
                              child: Container(
                                // color: Colors.red,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.become_trendsee_user_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      DeviceSize().deviceHeight(context) *
                                          0.024),
                                  // GlobalView().buttonFilled(context,
                                  //     AppMessages.become_trendsee_user_text),
                                ),
                              ),
                            ),
                            //  GlobalView()
                            //     .assetImageView(AppImages.standard_user_image),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          thickness: 1,
                          color: BaseColor.btn_gradient_start_color1,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  DeviceSize().deviceHeight(context) * 0.004,
                              top: DeviceSize().deviceHeight(context) * 0.03,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context,
                                //     AppRoutes.business_user_registration_route_name);
                                print("business called");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessUserRegistrationScreen(
                                                false)));
                              },
                              child: Container(
                                // color: Colors.red,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.sign_up_business_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      DeviceSize().deviceHeight(context) *
                                          0.024),
                                  // GlobalView().buttonFilled(context,
                                  //     AppMessages.sign_up_business_text),
                                  // GlobalView()
                                  //     .assetImageView(AppImages.business_user_image),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.topCenter,
                child: GlobalView().textViewWithCenterAlign(
                    AppMessages.title_user_select_type,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.semi_bold_font_weight,
                    BaseColor.black_color,
                    22),
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  // color: Colors.red,
                  margin:
                      EdgeInsets.all(DeviceSize().deviceHeight(context) * 0.04),
                  height: DeviceSize().deviceWidth(context) / 2 + 100,
                  width: DeviceSize().deviceWidth(context) / 2 + 100,
                  // decoration: BoxDecoration(
                  // image: DecorationImage(
                  // image: AssetImage(AppImages.trendsee_logo_transparent),
                  // // colorFilter: ColorFilter.mode(Colors.orange, BlendMode.colorBurn),
                  // ),
                  // ),
                  child: Image.asset(
                    AppImages.trendsee_logo_transparent,
                    color: BaseColor.btn_gradient_end_color1.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

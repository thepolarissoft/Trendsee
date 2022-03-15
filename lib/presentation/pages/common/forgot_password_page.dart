import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/utils/preference_utils.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  String username = "";
  @override
  Widget build(BuildContext context) {
    username = PreferenceUtils.getStringValue(
      PreferenceUtils.keyUsername,
    );
    return ListenableProvider(
        create: (_) => BaseResponseProvider(),
        builder: (context, child) {
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
                  // Positioned(
                  //     child: GlobalView().assetImageView(AppImages.backgroundImage1)),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Center(
                        child: SizedBox(
                          height: DeviceSize().deviceHeight(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GlobalView().sizedBoxView(220),
                              GlobalView().textViewWithCenterAlign(
                                  AppMessages.forgot_pass_title,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.black_color,
                                  20),
                              GlobalView().sizedBoxView(20),
                              GlobalView().textViewWithCenterAlign(
                                  AppMessages.forgot_pass_message,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.normal_font_weight,
                                  BaseColor.black_color.withOpacity(0.5),
                                  12),
                              GlobalView().sizedBoxView(30),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: GlobalView().textFieldView(
                                    AppImages.ic_email,
                                    emailTextEditingController,
                                    AppMessages.hint_email,
                                    AppTextStyle.start_text_align),
                              ),
                              // GlobalView().sizedBoxView(270),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 30, right: 30, bottom: 70),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(context,
                                    //     AppRoutes.emailVerificationRouteName);
                                    // if (emailTextEditingController
                                    //     .text.isNotEmpty) {
                                    //   print(emailTextEditingController.text);
                                    //   if (EmailValidator.validate(
                                    //       emailTextEditingController.text)) {
                                    //     Provider.of<BaseResponseProvider>(
                                    //             context,
                                    //             listen: false)
                                    //         .sign_in(
                                    //             context,
                                    //             username,
                                    //             emailTextEditingController
                                    //                 .text);
                                    //   } else {
                                    //     GlobalView().showToast(
                                    //         AppToastMessages.validEmailMessage);
                                    //   }
                                    // } else {
                                    //   GlobalView().showToast(
                                    //       AppToastMessages.emptyValueMessage);
                                    // }
                                  },
                                  child: GlobalView().buttonFilled(
                                      context, AppMessages.send_text),
                                ),
                              ),
                            ],
                          ),
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
                          child:
                              GlobalView().assetImageView(AppImages.ic_back)),
                    ),
                  ),
                  Consumer<BaseResponseProvider>(builder: (_, user, child) {
                    return Visibility(
                      visible:
                          Provider.of<BaseResponseProvider>(context).isLoading,
                      // visible: true,
                      child: Positioned(
                        child: Container(
                          // color: BaseColor.loader_bg_color,
                          child: GlobalView().loaderView(),
                        ),
                      ),
                    );
                  }),
                  // Positioned(
                  //   top: 57,
                  //   left: 0,
                  //   right: 0,
                  //   child: Container(
                  //     alignment: Alignment.topCenter,
                  //     child: GlobalView().textViewWithCenterAlign(
                  //         AppMessages.forgotPassText
                  //             .substring(0, AppMessages.forgotPassText.length - 1),
                  //         AppTextStyle.interFontFamily,
                  //         AppTextStyle.semiBoldFontWeight,
                  //         BaseColor.blackColor,
                  //         18),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}

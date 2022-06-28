import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/profile_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';
import 'package:trendoapp/utils/url_launcher.dart';
import 'package:trendoapp/utils/validation_utils.dart';

// ignore: must_be_immutable
class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isObscure = true;
  @override
  void initState() {
    if (kDebugMode) {
      emailTextEditingController.text = "testuser01@gmail.com";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "LAT=-=-=-->>${StorageUtils.readStringValue(StorageUtils.keyLatitude)}");
    // print("USER LAT->> ${UserUtils.userLatitude}");
    // userNameTextEditingController.text = "kaushitapolaris";
    //  userNameTextEditingController.text = "abct9551@gmail.com";
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pop(context, true);
        SystemNavigator.pop();
        return false;
      },
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
              //  TweenAnimationBuilder(
              //     tween: Tween<double>(
              //       begin: 5,
              //       end: 10,
              //     ),
              //     duration: Duration(seconds: 2),
              //     builder: (_, double size, __) {
              //       return
              Stack(
            children: [
              GlobalView().assetImageView(AppImages.bg_signin),
              // Padding(
              //   padding: EdgeInsets.only(top: 240),
              //   child: Container(
              //     // height: ScreenSize().screenHeight(context) - 250,
              //     decoration: BoxDecoration(
              //         color: BaseColor.pureWhiteColor,
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(60),
              //             topRight: Radius.circular(60))),
              //   ),
              // ),
              // Positioned.fill(
              //     top: 50,
              //     child:
              Scrollbar(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.03),
                          // GlobalView().assetImageView(AppImages.sliderImg1),
                          Image.asset(
                            // AppImages.sliderImg1,
                            AppImages.trendsee_logo_transparent,
                            height: DeviceSize().deviceWidth(context) / 2 + 50,
                          ),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.03),
                          GlobalView().textViewWithCenterAlign(
                              AppMessages.app_name,
                              AppTextStyle.alphapipe_font_family,
                              AppTextStyle.bold_font_weight,
                              BaseColor.app_name_color,
                              // 36
                              DeviceSize().deviceHeight(context) * 0.046),
                          GlobalView().sizedBoxView(10),
                          GlobalView().textViewWithCenterAlign(
                              AppMessages.signin_content,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.normal_font_weight,
                              BaseColor.black_color.withOpacity(0.5),
                              // 18
                              DeviceSize().deviceHeight(context) * 0.02),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: GlobalView().textFieldView(
                                AppImages.ic_user,
                                emailTextEditingController,
                                AppMessages.hint_email,
                                AppTextStyle.start_text_align),
                          ),
                          // GlobalView().sizedBoxView(
                          //     DeviceSize().deviceHeight(context) * 0.06),
                          Visibility(
                            visible: false,
                            child: Column(
                              children: [
                                GlobalView().sizedBoxView(20),
                                StatefulBuilder(builder: (context, state) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: GlobalView().textFieldView(
                                        AppImages.ic_password,
                                        passwordTextEditingController,
                                        AppMessages.hint_password,
                                        AppTextStyle.start_text_align,
                                        isObscure: isObscure,
                                        suffixIcon: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              isObscure = !isObscure;
                                              state(() {});
                                            },
                                            icon: Icon(
                                              isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: BaseColor
                                                  .btn_gradient_start_color1,
                                            ))),
                                  );
                                }),
                                GlobalView().sizedBoxView(20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.forgot_password_route_name);
                                  },
                                  child: GlobalView().textViewWithCenterAlign(
                                      AppMessages.forgot_pass_text,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.forgot_pass_txt_color,
                                      14),
                                ),
                              ],
                            ),
                          ),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.03),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context,
                              //     AppRoutes.forgot_password_route_name);
                              onTapForgotPasscode();
                            },
                            child: GlobalView().textViewWithCenterAlign(
                                AppMessages.forgot_passcode_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.forgot_pass_txt_color,
                                14),
                          ),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, AppRoutes.timelineRouteName);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SuccessfulEmailVerificationScreen()));
                                if (emailTextEditingController.text.isEmpty) {
                                  GlobalView().showToast(
                                      AppToastMessages.empty_email_message);
                                } else if (!ValidationUtils().isEmailValidate(
                                    emailTextEditingController.text)) {
                                  GlobalView().showToast(
                                      AppToastMessages.valid_email_message);
                                } else {
                                  PreferenceUtils.setStringValue(
                                      PreferenceUtils.keyUsername,
                                      emailTextEditingController.text);
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .signIn(context,
                                          emailTextEditingController.text);
                                }
                              },
                              child: GlobalView().buttonFilled(
                                  context, AppMessages.login_btn_text),
                            ),
                          ),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.009),
                          lineBreakerView(),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.009),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    AppRoutes.user_type_selection_route_name);
                                //  Navigator.of(context).push(_createRoute());
                              },
                              child: GlobalView().buttonFilled2(
                                  context, AppMessages.register_btn_text),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // ),
              Consumer<ProfileProvider>(builder: (_, user, child) {
                return Visibility(
                  visible: Provider.of<ProfileProvider>(context).isLoading,
                  // visible: true,
                  child: Positioned(
                    child: Container(
                      // color: BaseColor.loader_bg_color,
                      child: GlobalView().loaderView(),
                    ),
                  ),
                );
              }),
            ],
          )
          //   ;
          // }),
          ),
    );
  }

// Route _createRoute() {
  Widget lineBreakerView() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: GlobalView().dividerView()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GlobalView().textViewWithCenterAlign(
                  AppMessages.or_text,
                  AppTextStyle.inter_font_family,
                  AppTextStyle.normal_font_weight,
                  BaseColor.black_color.withOpacity(0.6),
                  14),
            ),
            Expanded(child: GlobalView().dividerView()),
          ],
        ),
      );

  void onTapForgotPasscode() {
    DialogUtils.displayDialogCallBack(
            context,
            "",
            AppMessages.forgot_passcode_text
                .substring(0, AppMessages.forgot_passcode_text.length - 1),
            AppMessages.forgot_passcode_message,
            "",
            AppMessages.cancel_text,
            AppMessages.ok_text)
        .then((value) {
      if (value == AppMessages.ok_text) {
        UrlLauncher().openEmail(
            ApiUrls.passcode_reset_email,
            AppMessages.forgot_passcode_text
                .substring(0, AppMessages.forgot_passcode_text.length - 1));
      }
    });
  }
}

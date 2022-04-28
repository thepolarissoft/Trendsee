import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/profile_provider.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(
        "LAT=-=-=-->>${StorageUtils.readStringValue(StorageUtils.keyLatitude)}");
    // print("USER LAT->> ${UserUtils.userLatitude}");
    if (kDebugMode) {
      userNameTextEditingController.text = "testBusiness01";
    }
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
                                userNameTextEditingController,
                                AppMessages.hint_for_login,
                                AppTextStyle.start_text_align),
                          ),
                          GlobalView().sizedBoxView(
                              DeviceSize().deviceHeight(context) * 0.06),
                          // GlobalView().sizedBoxView(20),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: GlobalView().textFieldView(
                          //       AppImages.ic_password,
                          //       passwordTextEditingController,
                          //       AppMessages.hintPassword,
                          //       AppTextStyle.startTextAlign),
                          // ),
                          // GlobalView().sizedBoxView(20),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(
                          //         context, AppRoutes.forgotPasswordRouteName);
                          //   },
                          //   child: GlobalView().textViewWithCenterAlign(
                          //       AppMessages.forgotPassText,
                          //       AppTextStyle.interFontFamily,
                          //       AppTextStyle.semiBoldFontWeight,
                          //       BaseColor.forgotPassTxtColor,
                          //       14),
                          // ),
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
                                if (userNameTextEditingController
                                    .text.isNotEmpty) {
                                  PreferenceUtils.setStringValue(
                                      PreferenceUtils.keyUsername,
                                      userNameTextEditingController.text);
                                  Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .signIn(context,
                                          userNameTextEditingController.text);
                                  //   Navigator.pushNamed(
                                  //       context, AppRoutes.forgotPasswordRouteName);
                                } else {
                                  GlobalView().showToast(AppToastMessages
                                      .login_with_no_value_message);
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
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) =>  UserTypeSelectionScreen(),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, 1.0);
//         const end = Offset.zero;
//         const curve = Curves.linearToEaseOut;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
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
}

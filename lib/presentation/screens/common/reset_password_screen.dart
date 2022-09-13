// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  bool isObscureCurrentPass = true;
  bool isObscureNewPass = true;
  bool isObscureReEnterPass = true;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: StatefulBuilder(builder: (context, state) {
                return Column(
                  children: [
                    GlobalView().sizedBoxView(30),
                    Container(
                      alignment: Alignment.topCenter,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.reset_password_title,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.semi_bold_font_weight,
                          BaseColor.black_color,
                          18),
                    ),
                    GlobalView().sizedBoxView(30),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.currentPassword,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        currentPasswordController,
                        AppMessages.currentPassword,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureCurrentPass,
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureCurrentPass = !isObscureCurrentPass;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureCurrentPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.newPassword,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        newPasswordController,
                        AppMessages.newPassword,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureNewPass,
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureNewPass = !isObscureNewPass;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureNewPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.reEnterNewPassword,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        reEnterPasswordController,
                        AppMessages.reEnterNewPassword,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureReEnterPass,
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureReEnterPass = !isObscureReEnterPass;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureReEnterPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(
                        DeviceSize().deviceHeight(context) * 0.06),
                    GlobalView().buttonFilled(
                        context, AppMessages.reset_password_title),
                  ],
                );
              }),
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

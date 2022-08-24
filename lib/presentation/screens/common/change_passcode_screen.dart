// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/settings/account_settings_provider.dart';

class ChangePasscodeScreen extends StatelessWidget {
  ChangePasscodeScreen({Key? key}) : super(key: key);
  TextEditingController oldPasscodeController = TextEditingController();
  TextEditingController newPasscodeController = TextEditingController();
  TextEditingController reEnterPasscodeController = TextEditingController();

  bool isObscureCurrentPasscode = true;
  bool isObscureNewPasscode = true;
  bool isObscureReEnterPasscode = true;

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
                          AppMessages.changePasscodeTitle,
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
                          AppMessages.currentPasscode,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        oldPasscodeController,
                        AppMessages.currentPasscode,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureCurrentPasscode,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureCurrentPasscode =
                                  !isObscureCurrentPasscode;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureCurrentPasscode
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.newPasscode,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        newPasscodeController,
                        AppMessages.newPasscode,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureNewPasscode,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureNewPasscode = !isObscureNewPasscode;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureNewPasscode
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(10),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.reEnterNewPasscode,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.normal_font_weight,
                          BaseColor.black_color.withOpacity(0.5),
                          // 11
                          DeviceSize().deviceHeight(context) * 0.014),
                    ),
                    GlobalView().textFieldView(
                        AppImages.ic_password,
                        reEnterPasscodeController,
                        AppMessages.reEnterNewPasscode,
                        AppTextStyle.start_text_align,
                        isObscure: isObscureReEnterPasscode,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        suffixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              isObscureReEnterPasscode =
                                  !isObscureReEnterPasscode;
                              state(() {});
                            },
                            icon: Icon(
                              isObscureReEnterPasscode
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: BaseColor.btn_gradient_start_color1,
                            ))),
                    GlobalView().sizedBoxView(
                        DeviceSize().deviceHeight(context) * 0.06),
                    GestureDetector(
                      onTap: () {
                        onTapChangePasscodeBtn(context);
                      },
                      child: GlobalView().buttonFilled(
                          context, AppMessages.changePasscodeTitle),
                    ),
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

  void onTapChangePasscodeBtn(BuildContext context) {
    if (oldPasscodeController.text.isEmpty ||
        newPasscodeController.text.isEmpty ||
        reEnterPasscodeController.text.isEmpty) {
      GlobalView().showToast(AppToastMessages.empty_value_message);
    } else if (newPasscodeController.text != reEnterPasscodeController.text) {
      GlobalView().showToast(AppToastMessages.passcode_not_same_message);
    } else {
      Provider.of<AccountSettingsProvider>(context, listen: false)
          .changePasscode(
              context, oldPasscodeController.text, newPasscodeController.text);
    }
  }
}

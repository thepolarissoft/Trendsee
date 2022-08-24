// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/verify_otp_provider.dart';

class SetPasscodeScreen extends StatefulWidget {
  SetPasscodeScreen({Key? key, required this.args}) : super(key: key);
  SetPasscodeArgs? args;
  @override
  State<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends State<SetPasscodeScreen> {
  String otp = "12345";
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(
      GestureDetector(
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
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: DeviceSize().deviceHeight(context) * 0.1),
                          child: SizedBox(
                              height: DeviceSize().deviceWidth(context) / 3,
                              width: DeviceSize().deviceWidth(context) / 3,
                              child: GlobalView()
                                  .assetImageView(AppImages.ic_message)),
                        ),
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.02),
                        GlobalView().textViewWithCenterAlign(
                            AppMessages.set_passcode_title,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.bold_font_weight,
                            BaseColor.black_color,
                            DeviceSize().deviceHeight(context) * 0.034),
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.02),
                        GlobalView().textViewWithCenterAlign(
                            AppMessages.verify_passcode_message,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.normal_font_weight,
                            BaseColor.black_color.withOpacity(0.5),
                            DeviceSize().deviceHeight(context) * 0.02),
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.04),
                        otpTextFieldView(context),
                        GlobalView().sizedBoxView(
                            DeviceSize().deviceHeight(context) * 0.1),
                        // Spacer(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30,
                              right: 30,
                              bottom:
                                  DeviceSize().deviceHeight(context) * 0.07),
                          child: GestureDetector(
                            onTap: () {
                              if (otp != null) {
                                Provider.of<VerifyOtpProvider>(context,
                                        listen: false)
                                    .setPasscode(
                                        context, widget.args!.email, otp);
                              } else {
                                GlobalView().showToast(
                                    AppToastMessages.empty_value_message);
                              }
                            },
                            child: GlobalView().buttonFilled(
                                context, AppMessages.set_passcode_title),
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
              Consumer<VerifyOtpProvider>(builder: (_, user, child) {
                return Visibility(
                  visible: Provider.of<VerifyOtpProvider>(context).isLoading,
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
          ),
        ),
      ),
    );
  }

  Widget otpTextFieldView(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceSize().deviceWidth(context) / 25
            // horizontal: 0
            ),
        child: PinCodeTextField(
          appContext: context,
          length: 5,
          pastedTextStyle: TextStyle(
              color: BaseColor.black_color,
              fontWeight: AppTextStyle.medium_font_weight,
              fontSize: 20,
              fontFamily: AppTextStyle.inter_font_family),
          onChanged: (value) {},
          onSubmitted: (value) {
            setState(() {
              otp = value;
              print("otp $otp");
            });
          },
          onCompleted: (value) {
            setState(() {
              otp = value;
              print("otp $otp");
            });
          },
          cursorColor: BaseColor.black_color,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.circle,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 55,
            fieldWidth: 55,
            fieldOuterPadding: EdgeInsets.all(0),
            activeFillColor: BaseColor.border_txtfield_color,
            activeColor: BaseColor.border_txtfield_color,
            disabledColor: BaseColor.border_txtfield_color,
            inactiveColor: BaseColor.border_txtfield_color,
            selectedColor: BaseColor.border_txtfield_color,
          ),
          keyboardType: TextInputType.number,
          backgroundColor: BaseColor.pure_white_color,
          // boxShadows: [
          //   BoxShadow(
          //     offset: Offset.zero,
          //     color: BaseColor.shadowColor.withOpacity(0.2),
          //     blurRadius: 2,
          //   )
          // ],
        ),
      );
}

class SetPasscodeArgs {
  String? email;
  SetPasscodeArgs({this.email});
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';

class GlobalView {
  Widget safeAreaView(Widget widget) => Container(
        color: BaseColor.pure_white_color,
        child: Scaffold(
          backgroundColor: BaseColor.pure_white_color,
          body: widget,
        ),
      );

  Widget assetImageView(String image) => Image.asset(image);

  // Widget appLogoView() => Image.asset(AppImages.appLogo);
  // Widget backgroundImageView() => Image.asset(AppImages.backgroundImage);
  // Widget backgroundImageView1() => Image.asset(AppImages.backgroundImage1);
  // Widget sliderImage1() => Image.asset(AppImages.sliderImg1);

  Widget textViewWithCenterAlign(String data, String fontFamily,
          FontWeight fontWeight, Color color, double fontSize) =>
      Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize),
        // style: Styles.titleText,
      );

  Widget textViewWithStartAlign(String data, String fontFamily,
          FontWeight fontWeight, Color color, double fontSize) =>
      Text(
        data,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize),
      );

  Widget textViewWithEndAlign(String data, String fontFamily,
          FontWeight fontWeight, Color color, double fontSize) =>
      Text(
        data,
        textAlign: TextAlign.end,
        style: TextStyle(
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize),
      );
  Widget sizedBoxView(double height) => SizedBox(
        height: height,
      );

  Widget textFieldView(String image, TextEditingController controller,
          String hintText, TextAlign textAlign,
          {TextInputType? textInputType,
          Widget? suffixIcon,
          bool isObscure = false,
          List<TextInputFormatter>? inputFormatters,
          bool? isReadOnly,
          Function? onTap}) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          controller: controller,
          cursorColor: BaseColor.border_txtfield_color,
          style: TextStyle(
            color: BaseColor.hint_color,
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
          inputFormatters: inputFormatters,
          keyboardType: textInputType ?? TextInputType.text,
          textAlign: textAlign,
          obscureText: isObscure,
          readOnly: isReadOnly ?? false,
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          decoration: InputDecoration(
            isDense: true,
            focusColor: BaseColor.pure_white_color,
            contentPadding: EdgeInsets.only(left: 60, right: -40),
            prefixIcon: prefixIconView(image),
            suffixIcon: suffixIcon,
            //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: BaseColor.border_txtfield_color),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: BaseColor.hint_color.withOpacity(0.6),
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
          ),
        ),
      );

  Widget textFieldViewReadOnly(String image, TextEditingController controller,
          String hintText, TextAlign textAlign) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          readOnly: true,
          controller: controller,
          cursorColor: BaseColor.border_txtfield_color,
          style: TextStyle(
            color: BaseColor.hint_color,
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
          textAlign: textAlign,
          decoration: InputDecoration(
            isDense: true,
            focusColor: BaseColor.pure_white_color,
            contentPadding: EdgeInsets.only(left: 60, right: -30),
            prefixIcon: prefixIconView(image),
            //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: BaseColor.border_txtfield_color),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: BaseColor.hint_color.withOpacity(0.6),
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
          ),
        ),
      );

  Widget prefixIconView(String image) => Padding(
        padding: EdgeInsets.only(right: 15),
        child: Container(
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.ic_bg)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 20),
              child: Image.asset(
                image,
                height: 24,
                width: 24,
                color: BaseColor.pure_white_color,
              ),
            )),
      );

  Widget textFieldViewPhone(String image, TextEditingController controller,
          String hintText, TextAlign textAlign,
          {bool? isReadOnly, Function? onTap}) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          controller: controller,
          cursorColor: BaseColor.border_txtfield_color,
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: BaseColor.hint_color,
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          textAlign: textAlign,
          readOnly: isReadOnly ?? false,
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          decoration: InputDecoration(
            isDense: true,
            focusColor: BaseColor.pure_white_color,
            contentPadding: EdgeInsets.only(left: 60, right: -30),
            prefixIcon: prefixIconView(image),
            //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: BaseColor.border_txtfield_color),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: BaseColor.hint_color.withOpacity(0.6),
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
          ),
        ),
      );

  Widget buttonFilled(BuildContext context, String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              BaseColor.btn_gradient_start_color1,
              BaseColor.btn_gradient_end_color1
            ]),
            boxShadow: [
              BoxShadow(
                  color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(25)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: textViewWithCenterAlign(text, AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight, BaseColor.pure_white_color, 16),
      );

  Widget buttonRoundedBorder(BuildContext context, String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: BaseColor.pure_white_color,
            boxShadow: [
              BoxShadow(
                  color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
            ],
            border: Border.all(color: BaseColor.forgot_pass_txt_color),
            borderRadius: BorderRadius.circular(25)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: textViewWithCenterAlign(
            text,
            AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight,
            BaseColor.forgot_pass_txt_color,
            16),
      );

  Widget smallSizeButtonFilled(BuildContext context, String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              BaseColor.btn_gradient_start_color1,
              BaseColor.btn_gradient_end_color1
            ]),
            boxShadow: [
              BoxShadow(
                  color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(25)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: textViewWithCenterAlign(text, AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight, BaseColor.pure_white_color, 16),
      );

  Widget wrappedButtonFilledView(BuildContext context, String text) =>
      Container(
          child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: DeviceSize().deviceHeight(context) * 0.012,
                horizontal: 25),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  BaseColor.btn_gradient_start_color1,
                  BaseColor.btn_gradient_end_color1
                ]),
                boxShadow: [
                  BoxShadow(
                      color: BaseColor.shadow_color.withOpacity(0.3),
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.circular(25)),
            // width: ScreenSize().screenWidth(context) - 50,
            child: GlobalView().textViewWithCenterAlign(
                text,
                AppTextStyle.inter_font_family,
                AppTextStyle.medium_font_weight,
                BaseColor.pure_white_color,
                16),
          ),
        ],
      ));

  Widget wrappedButtonViewWithImage(BuildContext context, Widget child) =>
      Container(
          child: Container(
        padding: EdgeInsets.symmetric(
            vertical: DeviceSize().deviceHeight(context) * 0.007,
            horizontal: 25),
        decoration: BoxDecoration(
          color: BaseColor.pure_white_color,
          boxShadow: [
            BoxShadow(
                color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
          ],
          border: Border.all(color: BaseColor.forgot_pass_txt_color),
          borderRadius: BorderRadius.circular(20),
        ),
        // width: ScreenSize().screenWidth(context) - 50,
        child: child,
      ));

  Widget buttonFilled2(BuildContext context, String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              BaseColor.btn_gradient_start_color2,
              BaseColor.btn_gradient_end_color2
            ]),
            boxShadow: [
              BoxShadow(
                  color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(25)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: textViewWithCenterAlign(text, AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight, BaseColor.pure_white_color, 16),
      );

  Widget alertButtons(
          BuildContext context, String text, Color color1, Color color2) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color1,
                color2,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  color: BaseColor.shadow_color.withOpacity(0.3), blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(12)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: textViewWithCenterAlign(text, AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight, BaseColor.pure_white_color, 16),
      );

  Widget dividerView() => Divider(
        color: BaseColor.divider_color.withOpacity(0.5),
        thickness: 2,
      );

  Widget buttonBack(BuildContext context) => GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image.asset(AppImages.ic_back));

  void showToast(String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        // textColor: BaseColor.btnGradientEndColor1,
        // backgroundColor: BaseColor.homeBGColor,
        gravity: ToastGravity.BOTTOM,
        // webPosition: "center"
      );

  Widget loaderView() => Center(
        child: Container(
          // color: BaseColor.pureWhiteColor.withOpacity(0.5),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                BaseColor.btn_gradient_end_color1),
          ),
        ),
      );

  Widget buttonFilledDisabled(BuildContext context, String text) => Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [
            //   BaseColor.btnGradientStartColor1,
            //   BaseColor.btnGradientEndColor1
            // ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  // BaseColor.shadow_color.withOpacity(0.3),
                  blurRadius: 4)
            ], borderRadius: BorderRadius.circular(25)),
        width: DeviceSize().deviceWidth(context) - 50,
        child: GlobalView().textViewWithCenterAlign(
            text,
            AppTextStyle.inter_font_family,
            AppTextStyle.medium_font_weight,
            BaseColor.pure_white_color,
            16),
      );

  Widget myCheckInsGlobalView(
    BuildContext context,
    String avatar,
    String firstName,
    String lastName,
    String category,
    String businessName,
    String businessAddress,
    String description,
    int isLiked,
    int isDisliked,
    int totalLikes,
    int totalDislikes,
    int totalComments,
    int totalShares,
  ) =>
      Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                            image: NetworkImage(avatar), fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GlobalView().textViewWithStartAlign(
                                  firstName + " " + lastName,
                                  AppTextStyle.metropolis_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.black_color,
                                  12),
                              GlobalView().textViewWithStartAlign(
                                  "15 min ago",
                                  AppTextStyle.metropolis_font_family,
                                  AppTextStyle.medium_font_weight,
                                  BaseColor.black_color,
                                  10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        height: 24,
                        width: 24,
                        child: GestureDetector(
                          onTap: () {
                            // user.changeIsVisibleValue();
                          },
                          child:
                              //  Text(
                              //   user.isVisible.toString(),
                              // ),
                              Image.asset(AppImages.ic_menu),
                        ))
                  ],
                ),
              ),
              GlobalView().sizedBoxView(10),
              Divider(
                color: BaseColor.home_divider_color,
                height: 2,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: GlobalView().textViewWithStartAlign(
                    category,
                    AppTextStyle.metropolis_font_family,
                    AppTextStyle.semi_bold_font_weight,
                    BaseColor.forgot_pass_txt_color,
                    10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GlobalView().textViewWithStartAlign(
                    businessName,
                    AppTextStyle.metropolis_font_family,
                    AppTextStyle.bold_font_weight,
                    BaseColor.black_color,
                    16),
              ),
              GlobalView().sizedBoxView(5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      child: Image.asset(
                        AppImages.ic_location_black,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 7, top: 2),
                        alignment: Alignment.centerLeft,
                        child: GlobalView().textViewWithStartAlign(
                            businessAddress,
                            AppTextStyle.metropolis_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color.withOpacity(0.6),
                            12),
                      ),
                    )
                  ],
                ),
              ),
              GlobalView().sizedBoxView(15),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: GlobalView().textViewWithStartAlign(
                      description,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.black_color,
                      12),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   child: Container(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "See more",
              //         style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           fontFamily: AppTextStyle.interFontFamily,
              //           fontWeight: FontWeight.w600,
              //           fontSize: 12,
              //           color: BaseColor.blackColor.withOpacity(0.5),
              //         ),
              //       )),
              // ),
            ],
          ),
        ],
      );

  Decoration gradientDecorationView(Color color1, Color color2) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
        ),
      );

  Widget feedItemCell(dynamic list, int itemIndex) => Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // Container(
                  //   height: 32,
                  //   width: 32,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.grey,
                  //     image: DecorationImage(
                  //         image: homeFeed
                  //                     .listFeedInfo[
                  //                         itemIndex]
                  //                     .user
                  //                     .avatar !=
                  //                 ""
                  //             ? NetworkImage(
                  //                 homeFeed
                  //                     .listFeedInfo[
                  //                         itemIndex]
                  //                     .user
                  //                     .avatar)
                  //             : AssetImage(AppImages
                  //                 .default_profile_Pic),
                  //         fit: BoxFit.cover),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      // padding: EdgeInsets.symmetric(
                      //     horizontal: 10),
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GlobalView().textViewWithStartAlign(
                                list[itemIndex].user.firstName == null &&
                                        list[itemIndex].user.lastName == null
                                    ? "John Doe"
                                    : list[itemIndex].user.firstName +
                                        " " +
                                        list[itemIndex].user.lastName,
                                // "John Doe",
                                AppTextStyle.metropolis_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                12),
                            GlobalView().textViewWithStartAlign(
                                "15 min ago",
                                AppTextStyle.metropolis_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.black_color,
                                10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 24,
                    child: Image.asset(AppImages.ic_menu),
                  )
                ],
              ),
            ),
            GlobalView().sizedBoxView(10),
            Divider(
              color: BaseColor.home_divider_color,
              height: 2,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: GlobalView().textViewWithStartAlign(
                  list[itemIndex].category.name == null
                      ? "Cafe"
                      : list[itemIndex].category.name,
                  // "Cafe",
                  AppTextStyle.metropolis_font_family,
                  AppTextStyle.semi_bold_font_weight,
                  BaseColor.forgot_pass_txt_color,
                  10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GlobalView().textViewWithStartAlign(
                  list[itemIndex].businessUser.businessName == null
                      ? "ChoxBlast Cafe"
                      : list[itemIndex].businessUser.businessName,
                  // "ChoxBlast Cafe",
                  AppTextStyle.metropolis_font_family,
                  AppTextStyle.bold_font_weight,
                  BaseColor.black_color,
                  16),
            ),
            GlobalView().sizedBoxView(5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: 16,
                    child: Image.asset(
                      AppImages.ic_location_black,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 7, top: 2),
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          list[itemIndex].businessUser.businessAddress == null
                              ? "Abix Street, Main Road, San Fransisco, California"
                              : list[itemIndex].businessUser.businessAddress,
                          // "Abix Street",
                          AppTextStyle.metropolis_font_family,
                          AppTextStyle.medium_font_weight,
                          BaseColor.black_color.withOpacity(0.6),
                          12),
                    ),
                  )
                ],
              ),
            ),
            GlobalView().sizedBoxView(5),
            Visibility(
              visible: list[itemIndex].description == "" ? false : true,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: GlobalView().textViewWithStartAlign(
                      list[itemIndex].description == null
                          ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
                          : list[itemIndex].description,
                      // "Lorem ipsum dolor sit amet",
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.black_color,
                      12),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10, right: 10),
            //   child: Container(
            //       alignment: Alignment.centerLeft,
            //       child: Text(
            //         "See more",
            //         style: TextStyle(
            //           decoration: TextDecoration.underline,
            //           fontFamily: AppTextStyle.interFontFamily,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 12,
            //           color:
            //               BaseColor.blackColor.withOpacity(0.5),
            //         ),
            //       )),
            // ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 5),
              child: Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // homeFeed.homeFeedLike(
                        //     context,
                        //     homeFeed.listFeedInfo[itemIndex].id.toString(),
                        //     homeFeed.listFeedInfo[itemIndex].isLiked == 1
                        //         ? "0"
                        //         : "1",
                        //     itemIndex);
                      },
                      child: Image.asset(
                        list[itemIndex].isLiked == 1
                            ? AppImages.thumbs_up_filled
                            : AppImages.thumbs_up,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: GlobalView().textViewWithStartAlign(
                            list[itemIndex].totalLikes.toString() == null
                                ? "0"
                                : list[itemIndex].totalLikes.toString(),
                            // "0",
                            AppTextStyle.metropolis_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color.withOpacity(0.5),
                            12),
                      ),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     // homeFeed.changeDislikeValue(itemIndex);
                    //     // homeFeedResponseProvider
                    //     //     .home_feed_like_dislike(
                    //     //         context,
                    //     //         homeFeedResponseProvider
                    //     //             .listFeedInfo[
                    //     //                 itemIndex]
                    //     //             .id
                    //     //             .toString(),
                    //     //         "dislike",
                    //     //         "0",
                    //     //         homeFeedResponseProvider
                    //     //                     .listFeedInfo[
                    //     //                         itemIndex]
                    //     //                     .isDisliked ==
                    //     //                 1
                    //     //             ? "0"
                    //     //             : "1",
                    //     //         itemIndex);
                    //   },
                    //   child: Image.asset(
                    //     businessHomeFeedProvider
                    //                 .listFeedInfo[
                    //                     itemIndex]
                    //                 .isDisliked ==
                    //             1
                    //         ? AppImages
                    //             .thumbs_down_filled
                    //         : AppImages
                    //             .thumbs_down,
                    //     height: 24,
                    //     width: 24,
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Container(
                    //      margin: EdgeInsets.only(
                    //         left: 10),
                    //     child: GlobalView()
                    //         .textViewWithStartAlign(
                    //             businessHomeFeedProvider
                    //                         .listFeedInfo[
                    //                             itemIndex]
                    //                         .totalDislikes
                    //                         .toString() ==
                    //                     null
                    //                 ? "0"
                    //                 : businessHomeFeedProvider
                    //                     .listFeedInfo[
                    //                         itemIndex]
                    //                     .totalDislikes
                    //                     .toString(),
                    //             // "0",
                    //             AppTextStyle
                    //                 .metropolisFontFamily,
                    //             AppTextStyle
                    //                 .mediumFontWeight,
                    //             BaseColor
                    //                 .blackColor
                    //                 .withOpacity(
                    //                     0.5),
                    //             12),
                    //   ),
                    // ),
                    SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      AppImages.ic_comments,
                      height: 24,
                      width: 24,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: GlobalView().textViewWithStartAlign(
                            list[itemIndex].totalComments.toString() == null
                                ? "5.2k"
                                : list[itemIndex].totalComments.toString(),
                            // "0",
                            AppTextStyle.metropolis_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color.withOpacity(0.5),
                            12),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    // Image.asset(
                    //   AppImages.ic_share,
                    //   height: 24,
                    //   width: 24,
                    // ),
                    // Expanded(
                    //   child: Container(
                    //  margin: EdgeInsets.only(left: 10),
                    //     child: GlobalView()
                    //         .textViewWithStartAlign(
                    //             businessHomeFeedProvider
                    //                         .listFeedInfo[
                    //                             itemIndex]
                    //                         .totalShares
                    //                         .toString() ==
                    //                     null
                    //                 ? "150"
                    //                 : businessHomeFeedProvider
                    //                     .listFeedInfo[
                    //                         itemIndex]
                    //                     .totalShares
                    //                     .toString(),
                    //             // "0",
                    //             AppTextStyle
                    //                 .metropolisFontFamily,
                    //             AppTextStyle
                    //                 .mediumFontWeight,
                    //             BaseColor
                    //                 .blackColor
                    //                 .withOpacity(
                    //                     0.5),
                    //             12),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/api_urls.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/providers/settings/account_settings_provider.dart';
import 'package:trendoapp/utils/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogUtils {
  static Future<String> displayDialogCallBack(
    BuildContext context,
    String image,
    String title,
    String message,
    String subMessage,
    String negativeMsg,
    String positiveMsg,
  ) async {
    // String clickedValue;
    return await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            contentPadding:
                EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
            // title: Text(''),
            content: Container(
              width: DeviceSize().deviceWidth(context) - 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Visibility(
                      visible: image == "" ? false : true,
                      child: Container(
                        height: 52,
                        width: 52,
                        margin: EdgeInsets.only(bottom: 25),
                        child: GlobalView().assetImageView(image),
                      ),
                    ),
                    Visibility(
                      visible: title == "" ? false : true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: GlobalView().textViewWithCenterAlign(
                            title,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.bold_font_weight,
                            BaseColor.black_color,
                            20),
                      ),
                    ),
                    Visibility(
                      visible: message == "" ? false : true,
                      child: Container(
                        // margin: EdgeInsets.only(top: 20),
                        child: GlobalView().textViewWithCenterAlign(
                            message,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.semi_bold_font_weight,
                            BaseColor.black_color,
                            16),
                      ),
                    ),
                    Visibility(
                      visible: subMessage == "" ? false : true,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: GlobalView().textViewWithCenterAlign(
                            subMessage,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.normal_font_weight,
                            BaseColor.count_color,
                            14),
                      ),
                    ),
                    GlobalView().sizedBoxView(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Visibility(
                          visible: negativeMsg == "" ? false : true,
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    //  GlobalView().alertButtons(
                                    //     context,
                                    //     negativeMsg,
                                    //     BaseColor.btn_gradient_start_color2,
                                    //     BaseColor.btn_gradient_end_color2),
                                    GlobalView()
                                        .buttonFilled2(context, negativeMsg),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: positiveMsg == "" ? false : true,
                          child: Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(positiveMsg);
                              },
                              child:
                                  //  GlobalView().alertButtons(
                                  //     context,
                                  //     positiveMsg,
                                  //     BaseColor.btn_gradient_start_color1,
                                  //     BaseColor.btn_gradient_end_color1),
                                  GlobalView()
                                      .buttonFilled(context, positiveMsg),
                            ),
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static Future<String> displayDislikeDialog(
    BuildContext context,
    TextEditingController reasonEditingController,
    VoidCallback voidCallback,
    // SearchByBusinessProvider provider,
  ) async {
    // String clickedValue;
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          contentPadding:
              EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
          content: Container(
            width: DeviceSize().deviceWidth(context) - 100,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalView().textViewWithStartAlign(
                      AppMessages.has_bad_experience_msg,
                      AppTextStyle.metropolis_font_family,
                      AppTextStyle.bold_font_weight,
                      BaseColor.black_color,
                      18),
                  GlobalView()
                      .sizedBoxView(DeviceSize().deviceHeight(context) * 0.03),
                  // GlobalView().textViewWithStartAlign(
                  //     AppMessages.dislike_feed_reason_message,
                  //     AppTextStyle.metropolis_font_family,
                  //     AppTextStyle.medium_font_weight,
                  //     BaseColor.grey_color,
                  //     16),
                  // GlobalView()
                  //     .sizedBoxView(DeviceSize().deviceHeight(context) * 0.01),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      // left: 10,
                      // right: 10,
                    ),
                    height: 80,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      // image: DecorationImage(
                      //     image: AssetImage(
                      //         AppImages.rect),
                      //     fit: BoxFit.fitHeight),
                      border: Border.all(
                        color: BaseColor.btn_gradient_start_color2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: reasonEditingController,
                      expands: true,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: BaseColor.hint_color,
                        fontFamily: AppTextStyle.inter_font_family,
                        fontSize: 14,
                      ),
                      cursorColor: BaseColor.border_txtfield_color,
                      decoration: InputDecoration(
                        isDense: true,
                        focusColor: BaseColor.pure_white_color,
                        contentPadding: EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: AppMessages.send_msg_business_msg,
                        hintStyle: TextStyle(
                          color: BaseColor.hint_color.withOpacity(0.6),
                          fontFamily: AppTextStyle.inter_font_family,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  GlobalView()
                      .sizedBoxView(DeviceSize().deviceHeight(context) * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: GlobalView().buttonFilled2(
                                context, AppMessages.cancel_text),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          onTap: () {
                            print("Like clicked");
                            voidCallback();
                            Navigator.of(context).pop(AppMessages.send_text);
                            reasonEditingController.text = "";
                          },
                          child: GlobalView()
                              .buttonFilled(context, AppMessages.send_text),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void onClickFollowingBusiness(BuildContext context, SearchByBusinessProvider provider,
  //     int index, String route, int businessId) {
  //   DialogUtils.displayDialogCallBack(
  //           context,
  //           "",
  //           AppMessages.unFollow_text,
  //           AppMessages.unFollow_message,
  //           provider.listBusiness[index].businessName + "?",
  //           AppMessages.no_text,
  //           AppMessages.yes_text)
  //       .then((value) {
  //     if (value == AppMessages.yes_text) {
  //       if (route.toLowerCase() == "details") {
  //         provider.unFollowBusinessDetails(context, businessId);
  //       } else {
  //         provider.unFollowBusiness(context, businessId, index);
  //       }
  //     } else {
  //       // Navigator.pop(context);
  //       return null;
  //     }
  //   });
  // }

  void onClickLikedBusiness(
      BuildContext context,
      SearchByBusinessProvider provider,
      int index,
      String route,
      int businessId) {
    DialogUtils.displayDialogCallBack(
            context,
            "",
            AppMessages.unlike_title,
            AppMessages.unlike_message,
            provider.listBusiness[index].businessName + "?",
            AppMessages.no_text,
            AppMessages.yes_text)
        .then((value) {
      if (value == AppMessages.yes_text) {
        if (route.toLowerCase() == "details") {
          provider.unLikeBusinessDetails(context, businessId);
        } else {
          provider.unLikeBusiness(context, businessId, index, route);
        }
      } else {
        // Navigator.pop(context);
        return null;
      }
    });
  }

  void onClickLogout(BuildContext context) {
    DialogUtils.displayDialogCallBack(
            context,
            AppImages.logout,
            AppMessages.logout_title,
            AppMessages.logout_message,
            AppMessages.logout_sub_message,
            AppMessages.no_text,
            AppMessages.yes_text)
        .then((value) {
      if (value == AppMessages.yes_text) {
        Provider.of<BaseResponseProvider>(context, listen: false)
            .signOut(context);
      }
    });
  }

  void onClickSettings(BuildContext context, String route) {
    DialogUtils.displayDialogCallBack(
            context,
            "",
            route.toLowerCase() == "delete"
                ? AppMessages.delete_account_title
                : AppMessages.deactivate_account_title,
            AppMessages.logout_message,
            route.toLowerCase() == "delete"
                ? AppMessages.delete_account_sub_message
                : AppMessages.deactivate_account_sub_message,
            AppMessages.no_text,
            AppMessages.yes_text)
        .then((value) {
      if (value == AppMessages.yes_text) {
        if (route.toLowerCase() == "delete") {
          Provider.of<AccountSettingsProvider>(context, listen: false)
              .deleteAccount(context);
        } else if (route.toLowerCase() == "deactivate") {
          Provider.of<AccountSettingsProvider>(context, listen: false)
              .deactivateAccount(context);
        }
      }
    });
  }

// approval
  void showSupportAlertDialog(BuildContext context, String route) {
    DialogUtils.displayDialogCallBack(
            context,
            "",
            route.toLowerCase() == "deactivate"
                ? AppMessages.deactivate_account_title
                : route.toLowerCase() == "delete"
                    ? AppMessages.delete_account_title
                    : AppMessages.approval_account_title,
            route.toLowerCase() == "deactivate"
                ? AppMessages.deactivated_user_message
                : route.toLowerCase() == "delete"
                    ? AppMessages.deleted_user_message
                    : AppMessages.approval_user_message,
            "",
            AppMessages.close_text,
            AppMessages.support_text)
        .then((value) {
      if (value == AppMessages.support_text) {
        UrlLauncher().openEmail(
            ApiUrls.business_error_email, AppMessages.business_ac_error_text);
      }
    });
  }

  void onClickSupportButton() async {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'help@trendsee.app',
      query: encodeQueryParameters(
          <String, String>{'subject': "Business Account error"}),
    );
    print("emailLaunchUri-> $emailLaunchUri");
    launch(emailLaunchUri.toString());
  }
}

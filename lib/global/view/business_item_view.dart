import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/utils/category_utils.dart';

import 'global_view.dart';

// ignore: must_be_immutable
class BusinessItemView extends StatelessWidget {
  VerifiedUserResponse verifiedUserResponse;
  VoidCallback onClickLikeButton;
  BusinessItemView(
      {@required this.verifiedUserResponse, @required this.onClickLikeButton});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 74,
                // width: 75,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  // image: DecorationImage(
                  //     image: AssetImage(
                  //       AppImages.photo3,
                  //     ),
                  //     fit: BoxFit.cover),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: verifiedUserResponse.businessMedia[0].media != null
                      ? FadeInImage.assetNetwork(
                          placeholder: AppImages.loader_gif_removeBG,
                          image: verifiedUserResponse.businessMedia[0].media,
                          fit: BoxFit.cover)
                      : Image.asset(AppImages.photo3, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GlobalView().textViewWithStartAlign(
                                // "ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe",
                                verifiedUserResponse.businessName != null
                                    ? verifiedUserResponse.businessName
                                    : "ChoxBlast Cafe",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.divider_color,
                                14),
                          ),
                          GestureDetector(
                            onTap: () {
                              onClickLikeButton();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: GlobalView().gradientDecorationView(
                                  BaseColor.forgot_pass_txt_color,
                                  BaseColor.forgot_pass_txt_color),
                              child: GlobalView().textViewWithStartAlign(
                                  // verifiedUserResponse.isLiked == 1
                                  //     ? AppMessages.liked_text
                                  //     : AppMessages.like_text,
                                  verifiedUserResponse.isLiked == 0 &&
                                          verifiedUserResponse.isDisliked == 0
                                      ? AppMessages.like_text
                                      : verifiedUserResponse.isLiked == 1
                                          ? AppMessages.liked_text
                                          : AppMessages.disliked_text,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.normal_font_weight,
                                  BaseColor.pure_white_color,
                                  10),
                            ),
                          )
                        ],
                      ),
                      GlobalView().sizedBoxView(3),
                    
                        GlobalView().textViewWithStartAlign(
                          verifiedUserResponse.categories != null
                              ? CategoryUtils().getCategoryName(
                                  verifiedUserResponse.categories)
                              : "Reastaurant",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.medium_font_weight,
                          BaseColor.forgot_pass_txt_color,
                          12),
                      GlobalView().sizedBoxView(2),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.ic_location_black,
                            height: 16,
                            width: 12,
                          ),
                          Expanded(
                            child: GlobalView().textViewWithStartAlign(
                                verifiedUserResponse.isMobile == 1
                                    ? AppMessages.mobile_business_text
                                    : verifiedUserResponse.isOnline == 0
                                        ? verifiedUserResponse
                                                    .businessAddress !=
                                                null
                                            ? verifiedUserResponse
                                                .businessAddress
                                            : "San Fransisco, California, USA"
                                        : AppMessages.online_business_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.divider_color,
                                10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';

class FollowersTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutes.followers_details_route_name);
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                  AppImages.photo3,
                                ),
                                fit: BoxFit.cover),
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
                                          "ChoxBlast Cafe",
                                          AppTextStyle.inter_font_family,
                                          AppTextStyle.semi_bold_font_weight,
                                          BaseColor.divider_color,
                                          14),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      decoration: GlobalView()
                                          .gradientDecorationView(
                                              BaseColor.forgot_pass_txt_color,
                                              BaseColor.forgot_pass_txt_color),
                                      child: GlobalView()
                                          .textViewWithStartAlign(
                                              AppMessages.add_friend_text,
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle.normal_font_weight,
                                              BaseColor.pure_white_color,
                                              10),
                                    )
                                  ],
                                ),
                                GlobalView().sizedBoxView(5),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.ic_location_black,
                                      height: 16,
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: GlobalView()
                                          .textViewWithStartAlign(
                                              "San Fransisco, California, USA",
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
              ),
            );
          },
        ),
      ),
    );
  }
}

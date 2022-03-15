import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';

class PlacesSearchTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  BaseColor.home_bg_color,
      body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GlobalView().textViewWithStartAlign(
                          AppMessages.featured_places_text,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.semi_bold_font_weight,
                          BaseColor.black_color,
                          16),
                    ),
                    GlobalView().textViewWithStartAlign(
                        AppMessages.see_all_text,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.semi_bold_font_weight,
                        BaseColor.forgot_pass_txt_color,
                        12),
                  ],
                ),
                GlobalView().sizedBoxView(15),
                featuredPlacesView(context),
                GlobalView().sizedBoxView(15),
                Row(
                  children: [
                    Expanded(
                      child: GlobalView().textViewWithStartAlign(
                          AppMessages.new_places_text,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.semi_bold_font_weight,
                          BaseColor.black_color,
                          16),
                    ),
                    GlobalView().textViewWithStartAlign(
                        AppMessages.see_all_text,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.semi_bold_font_weight,
                        BaseColor.forgot_pass_txt_color,
                        12),
                  ],
                ),
                GlobalView().sizedBoxView(15),
                // Expanded(flex: 2, child: newPlacesView(context)),
                 newPlacesView(context),
              ],
            ),
          )),
    );
  }

  Widget featuredPlacesView(BuildContext context) => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, AppRoutes.search_place_details_route_name);
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
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 74,
                          // width: 75,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
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
                                              AppMessages.follow_text,
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle.normal_font_weight,
                                              BaseColor.pure_white_color,
                                              10),
                                    )
                                  ],
                                ),
                                GlobalView().sizedBoxView(3),
                                GlobalView().textViewWithStartAlign(
                                    "Reastaurant",
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.medium_font_weight,
                                    BaseColor.forgot_pass_txt_color,
                                    12),
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
      );

  Widget newPlacesView(BuildContext context) => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: ListView.builder(
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
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
                                              AppMessages.follow_text,
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle.normal_font_weight,
                                              BaseColor.pure_white_color,
                                              10),
                                    )
                                  ],
                                ),
                                GlobalView().sizedBoxView(3),
                                GlobalView().textViewWithStartAlign(
                                    "Reastaurant",
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.medium_font_weight,
                                    BaseColor.forgot_pass_txt_color,
                                    12),
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
              );
            },
          ),
        ),
      );
}

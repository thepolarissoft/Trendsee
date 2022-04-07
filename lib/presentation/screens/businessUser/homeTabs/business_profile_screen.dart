import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/businessUser/business_user_registration_screen.dart';
import 'package:trendoapp/presentation/screens/common/account_settings_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/disliked_review_comment_screen.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/day_time_utils.dart';
import 'package:trendoapp/utils/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessProfileScreen extends StatefulWidget {
  @override
  _BusinessProfileScreenState createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  List<String> listImages = [
    AppImages.photo3,
    AppImages.photo3,
    AppImages.photo3,
  ];
  TextEditingController businessKeywordsTextEditingController =
      new TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<BusinessUserProvider>(context, listen: false)
        .getBusinessUserProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Consumer<BusinessUserProvider>(builder: (_, profile, child) {
            if (!profile.isLoading) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: BaseColor.pure_white_color,
                    expandedHeight: DeviceSize().deviceWidth(context) / 2 + 50,
                    // pinned: true,
                    // floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                            child: profile.listMediaImages.length == 1
                                ? FadeInImage.assetNetwork(
                                    placeholder: AppImages.loader_gif_removeBG,
                                    image: profile.listMediaImages[0],
                                    fit: BoxFit.cover,
                                    height:
                                        DeviceSize().deviceWidth(context) / 2 +
                                            50,
                                    width: DeviceSize().deviceWidth(context),
                                  )
                                : CarouselSlider(
                                    // items: profile.profileResponse.user.businessMedia[0].media
                                    items: profile.listMediaImages
                                        .map(
                                          (item) => Container(
                                            child:
                                                // ClipRRect(
                                                //     child: Stack(
                                                //   children: <Widget>[
                                                FadeInImage.assetNetwork(
                                              placeholder:
                                                  AppImages.loader_gif_removeBG,
                                              image: item,
                                              fit: BoxFit.cover,
                                              // height: 300,
                                              height: DeviceSize().deviceWidth(
                                                          context) /
                                                      2 -
                                                  50,
                                              width: DeviceSize()
                                                  .deviceWidth(context),
                                            ),
                                            //  Image.network(item),
                                            // CachedNetworkImage(
                                            //   imageUrl:
                                            //     item,
                                            //   placeholder: (context, url) =>
                                            //     Lottie.asset(AppImages.loader_gif1),
                                            //   errorWidget:
                                            //       (context, url, error) =>
                                            //           Icon(Icons.error),
                                            //            fit: BoxFit.cover,
                                            //   height: 300,
                                            //   width: ScreenSize()
                                            //       .screenWidth(context),
                                            // ),

                                            //   ],
                                            // )),
                                          ),
                                        )
                                        .toList(),
                                    options: CarouselOptions(
                                        // height: height,
                                        // enlargeCenterPage: false,
                                        // reverse: true,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 5),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 1500),
                                        autoPlayCurve: Curves.ease,
                                        aspectRatio: 1.0,
                                        viewportFraction: 1.0,
                                        onPageChanged: (index, season) {
                                          // _current = index;
                                          profile.setCurrentIndex(index);
                                        }),
                                  )
                            //  Image.asset(
                            //   AppImages.photo3,
                            //   fit: BoxFit.cover,
                            // ),
                            )),
                    leading: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => EditProfileScreen()))
                        //     .then(onCallBack);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            profile.editProfileResponse =
                                profile.businessUserProfileResponse.user;
                            // Navigator.pushNamed(context,
                            //     AppRoutes.editBusinessProfileRouteName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BusinessUserRegistrationScreen(
                                            true))).then(onCallBack);
                          },
                          child: Container(
                            child: Image.asset(
                              AppImages.ic_edit_filled,
                            ),
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, top: 10),
                        child: GestureDetector(
                          onTap: () {
                            DialogUtils().onClickLogout(context);
                          },
                          child: Container(
                            child: Image.asset(AppImages.ic_logout_filled),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        GlobalView().sizedBoxView(20),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: BaseColor.pure_white_color, width: 5),
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.shadow_color, blurRadius: 5)
                            ],
                            image: DecorationImage(
                                image: profile.businessUserProfileResponse.user
                                            .avatar ==
                                        null
                                    ? AssetImage(AppImages.default_profile_Pic)
                                    : NetworkImage(
                                        profile.businessUserProfileResponse.user
                                            .avatar,
                                      ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        GlobalView().sizedBoxView(20),
                        GlobalView().textViewWithCenterAlign(
                            profile.businessUserProfileResponse.user
                                        .businessName !=
                                    null
                                ? profile.businessUserProfileResponse.user
                                    .businessName
                                : "ChoxBlast Cafe",
                            AppTextStyle.inter_font_family,
                            AppTextStyle.bold_font_weight,
                            BaseColor.black_color,
                            20),
                        GlobalView().sizedBoxView(5),
                        // GlobalView().textViewWithCenterAlign(
                        //     profile.businessUserProfileResponse.user.feed.isNotEmpty &&
                        //             profile.businessUserProfileResponse.user.feed[0]
                        //                     .category.name.length >
                        //                 1
                        //         ? profile.businessUserProfileResponse.user.feed[0]
                        //             .category.name
                        //         : "Restaurant",
                        //     AppTextStyle.interFontFamily,
                        //     AppTextStyle.mediumFontWeight,
                        //     BaseColor.forgotPassTxtColor,
                        //     12),
                        // GlobalView().sizedBoxView(10),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Column(
                        //         children: [
                        //           GlobalView().textViewWithCenterAlign(
                        //               profile.businessUserProfileResponse.user.totalViews
                        //                           .toString() !=
                        //                       null
                        //                   ? profile
                        //                       .businessUserProfileResponse.user.totalViews
                        //                       .toString()
                        //                   : "0",
                        //               AppTextStyle.interFontFamily,
                        //               AppTextStyle.boldFontWeight,
                        //               BaseColor.blackColor,
                        //               20),
                        //           GlobalView().sizedBoxView(5),
                        //           GlobalView().textViewWithCenterAlign(
                        //               AppMessages.viewsText,
                        //               AppTextStyle.interFontFamily,
                        //               AppTextStyle.mediumFontWeight,
                        //               BaseColor.selectedTabColor,
                        //               12),
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         children: [
                        //           GlobalView().textViewWithCenterAlign(
                        //               profile.businessUserProfileResponse.user.totalLikes
                        //                           .toString() !=
                        //                       null
                        //                   ? profile
                        //                       .businessUserProfileResponse.user.totalLikes
                        //                       .toString()
                        //                   : "0",
                        //               AppTextStyle.interFontFamily,
                        //               AppTextStyle.boldFontWeight,
                        //               BaseColor.blackColor,
                        //               20),
                        //           GlobalView().sizedBoxView(5),
                        //           GlobalView().textViewWithCenterAlign(
                        //               AppMessages.likesText,
                        //               AppTextStyle.interFontFamily,
                        //               AppTextStyle.mediumFontWeight,
                        //               BaseColor.selectedTabColor,
                        //               12),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        GlobalView().sizedBoxView(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: BaseColor.selected_tab_color,
                          ),
                        ),
                        GlobalView().sizedBoxView(15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context,
                              //     AppRoutes.account_settings_route_name);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AccountSettingsScreen(
                                            profileResponse: null,
                                            businessUserProfileResponse: profile
                                                .businessUserProfileResponse,
                                            userType: 2,
                                          )));
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: GlobalView().textViewWithStartAlign(
                                        AppMessages.account_settings_title,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.semi_bold_font_weight,
                                        BaseColor.black_color,
                                        14)),
                                Container(
                                  padding: EdgeInsets.zero,
                                  height: 15,
                                  width: 15,
                                  // color: Colors.red,
                                  child: Image.asset(AppImages.ic_next2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GlobalView().sizedBoxView(15),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: BaseColor.selected_tab_color,
                          ),
                        ),
                        // GlobalView().sizedBoxView(15),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: GlobalView().textViewWithStartAlign(
                        //             AppMessages.resetPasswordTitle,
                        //             AppTextStyle.interFontFamily,
                        //             AppTextStyle.semiBoldFontWeight,
                        //             BaseColor.blackColor,
                        //             14),
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.zero,
                        //         height: 15,
                        //         width: 15,
                        //         // color: Colors.red,
                        //         child: Image.asset(AppImages.ic_next2),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // GlobalView().sizedBoxView(15),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Divider(
                        //     color: BaseColor.selectedTabColor,
                        //   ),
                        // ),

                        // GlobalView().sizedBoxView(20),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: GlobalView().textViewWithStartAlign(
                        //         AppMessages.aboutText,
                        //         AppTextStyle.interFontFamily,
                        //         AppTextStyle.semiBoldFontWeight,
                        //         BaseColor.blackColor,
                        //         16),
                        //   ),
                        // ),
                        // GlobalView().sizedBoxView(10),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: GlobalView().textViewWithStartAlign(
                        //       profile.profileResponse.user.desc
                        //                     .toString() !=
                        //                 null
                        //             ? profile.profileResponse.user.totalLikes
                        //                 .toString()
                        //             : "0",
                        //       AppTextStyle.interFontFamily,
                        //         AppTextStyle.mediumFontWeight,
                        //         BaseColor.blackColor,
                        //         12),
                        //   ),
                        // ),

                        Visibility(
                          visible: profile.businessUserProfileResponse.user
                                          .businessWebsite
                                          .toString() !=
                                      null &&
                                  profile.businessUserProfileResponse.user
                                          .businessWebsite.length >
                                      0
                              ? true
                              : false,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlobalView().sizedBoxView(20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithStartAlign(
                                      AppMessages.hint_business_website,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      16),
                                ),
                                GlobalView().sizedBoxView(5),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithStartAlign(
                                      profile.businessUserProfileResponse.user
                                                      .businessWebsite
                                                      .toString() !=
                                                  null &&
                                              profile
                                                      .businessUserProfileResponse
                                                      .user
                                                      .businessWebsite
                                                      .length >
                                                  0
                                          ? profile.businessUserProfileResponse
                                              .user.businessWebsite
                                              .toString()
                                          : "",
                                      // "AppTextStyle AppTextStyle AppTextStyleAppTextStyle AppTextStyle AppTextStyle AppTextStyle ",
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.medium_font_weight,
                                      BaseColor.black_color,
                                      14),
                                ),
                                GlobalView().sizedBoxView(5),
                                GestureDetector(
                                  onTap: () {
                                    String url = profile
                                        .businessUserProfileResponse
                                        .user
                                        .businessWebsite;
                                    UrlLauncher().launchUrl(url);
                                  },
                                  child: GlobalView().wrappedButtonFilledView(
                                      context, AppMessages.visit_site_text),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GlobalView().sizedBoxView(20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithStartAlign(
                                AppMessages.business_hours_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                16),
                          ),
                        ),
                        GlobalView().sizedBoxView(5),
                        businessHoursView(),
                        GlobalView().sizedBoxView(5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                    context,
                                    AppRoutes
                                        .add_edit_business_hours_route_name)
                                .then(onCallBack);
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: GlobalView().wrappedButtonFilledView(
                                  context,
                                  profile.businessUserProfileResponse.user
                                          .businessHours.isEmpty
                                      ? AppMessages.add_text +
                                          " " +
                                          AppMessages.business_hours_text
                                      : AppMessages.edit_text +
                                          " " +
                                          AppMessages.business_hours_text),
                            ),
                          ),
                        ),
                        GlobalView().sizedBoxView(20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithStartAlign(
                                AppMessages.hint_business_keywords,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                16),
                          ),
                        ),
                        GlobalView().sizedBoxView(5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GlobalView().textFieldView(
                                      AppImages.ic_business,
                                      businessKeywordsTextEditingController,
                                      AppMessages.hint_business_keywords,
                                      AppTextStyle.start_text_align),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      onClickAddKeywordButton();
                                    },
                                    child: GlobalView().wrappedButtonFilledView(
                                        context, AppMessages.add_text),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GlobalView().sizedBoxView(10),
                        // Text(profile.businessUserProfileResponse.user.businessKeywords),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Wrap(
                                // runAlignment:WrapAlignment.start,
                                // alignment:WrapAlignment.start,
                                runSpacing: 8,
                                spacing: 0,
                                children: List.generate(
                                    Provider.of<BusinessUserProvider>(context)
                                        .listBusinessKeywords
                                        .length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    child: Container(
                                      // color:Colors.green,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            DeviceSize().deviceHeight(context) *
                                                0.016),
                                        border: Border.all(
                                            color: BaseColor
                                                .btn_gradient_end_color1),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GlobalView().textViewWithStartAlign(
                                              Provider.of<BusinessUserProvider>(
                                                      context)
                                                  .listBusinessKeywords[index],
                                              AppTextStyle.inter_font_family,
                                              AppTextStyle
                                                  .semi_bold_font_weight,
                                              BaseColor.btn_gradient_end_color1,
                                              DeviceSize()
                                                      .deviceHeight(context) *
                                                  0.02),
                                          GestureDetector(
                                              onTap: () {
                                                Provider.of<BusinessUserProvider>(
                                                        context,
                                                        listen: false)
                                                    .removeFromListBusinessKeywords(
                                                        index, context);
                                              },
                                              child: Icon(Icons.close,
                                                  size: DeviceSize()
                                                          .deviceHeight(
                                                              context) *
                                                      0.018)),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        ),
                        GlobalView().sizedBoxView(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithStartAlign(
                                AppMessages.hint_business_phone_number,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                16),
                          ),
                        ),
                        GlobalView().sizedBoxView(5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithStartAlign(
                                profile.businessUserProfileResponse.user
                                            .businessPhone
                                            .toString() !=
                                        null
                                    ? profile.businessUserProfileResponse.user
                                        .businessPhone
                                        .toString()
                                    : "0",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.black_color,
                                14),
                          ),
                        ),
                        GlobalView().sizedBoxView(10),
                        GestureDetector(
                          onTap: () async {
                            print("Call now");
                            String url =
                                'tel:${profile.businessUserProfileResponse.user.businessPhone}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GlobalView().wrappedButtonFilledView(
                                  context, AppMessages.call_now_text),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: profile.businessUserProfileResponse.user
                                          .isOnline ==
                                      1 ||
                                  profile.businessUserProfileResponse.user
                                          .isMobile ==
                                      1
                              //||
                              // provider.selectedBusinessResponse.cityName == ""
                              ? false
                              : true,
                          child: Column(
                            children: [
                              GlobalView().sizedBoxView(10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithStartAlign(
                                      AppMessages.title_metropolitan_area,
                                      // +
                                      //     ", " +
                                      //     AppMessages.title_metropolitan_area,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      16),
                                ),
                              ),
                              GlobalView().sizedBoxView(10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: GlobalView().textViewWithStartAlign(
                                        profile.businessUserProfileResponse.user
                                                        .metropolitanArea !=
                                                    null &&
                                                profile
                                                        .businessUserProfileResponse
                                                        .user
                                                        .metropolitanArea
                                                        .name !=
                                                    null &&
                                                profile
                                                        .businessUserProfileResponse
                                                        .user
                                                        .metropolitanArea
                                                        .name !=
                                                    ""
                                            ? profile
                                                .businessUserProfileResponse
                                                .user
                                                .metropolitanArea
                                                .name
                                            //      +
                                            // ", " +
                                            // provider.selectedBusinessResponse
                                            //     .metropolitanArea
                                            : "-",
                                        // "Abix Street, Main Road, San Fransisco, California",
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.medium_font_weight,
                                        BaseColor.black_color,
                                        14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: profile.businessUserProfileResponse.user
                                          .isOnline ==
                                      1 ||
                                  profile.businessUserProfileResponse.user
                                          .isMobile ==
                                      1
                              //||
                              // provider.selectedBusinessResponse.cityName == ""
                              ? false
                              : true,
                          child: Column(
                            children: [
                              GlobalView().sizedBoxView(10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GlobalView().textViewWithStartAlign(
                                      AppMessages.city_text,
                                      // +
                                      //     ", " +
                                      //     AppMessages.title_metropolitan_area,
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.semi_bold_font_weight,
                                      BaseColor.black_color,
                                      16),
                                ),
                              ),
                              GlobalView().sizedBoxView(10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: GlobalView().textViewWithStartAlign(
                                        profile.businessUserProfileResponse.user
                                                        .cityName !=
                                                    null &&
                                                profile.businessUserProfileResponse
                                                        .user.cityName !=
                                                    ""
                                            ? profile
                                                .businessUserProfileResponse
                                                .user
                                                .cityName
                                            //      +
                                            // ", " +
                                            // provider.selectedBusinessResponse
                                            //     .metropolitanArea
                                            : "-",
                                        // "Abix Street, Main Road, San Fransisco, California",
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.medium_font_weight,
                                        BaseColor.black_color,
                                        14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        GlobalView().sizedBoxView(10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GlobalView().textViewWithStartAlign(
                                profile.businessUserProfileResponse.user
                                            .totalClick
                                            .toString() !=
                                        null
                                    ? AppMessages.total_clicks_text +
                                        " " +
                                        profile.businessUserProfileResponse.user
                                            .totalClick
                                            .toString()
                                    : AppMessages.total_clicks_text + " " + "0",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.black_color,
                                16),
                          ),
                        ),

                        GlobalView().sizedBoxView(10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DislikedReviewCommentScreen(
                                        businessId: profile
                                            .businessUserProfileResponse
                                            .user
                                            .id)));
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GlobalView().wrappedButtonFilledView(
                                  context, AppMessages.dislike_msg_text),
                            ),
                          ),
                        ),

                        GlobalView().sizedBoxView(20),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 20),
                        //   child: Card(
                        //     elevation: 2,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsets.symmetric(vertical: 10),
                        //       child: Column(
                        //         children: [
                        //           GlobalView().myCheckInsGlobalView(
                        //             context,
                        //             profile.profileResponse.user.avatar,
                        //             profile.profileResponse.user.firstName,
                        //             profile.profileResponse.user.lastName,
                        //             profile.profileResponse.user.feed[0]
                        //                 .category.name,
                        //             profile.profileResponse.user.businessName,
                        //             profile
                        //                 .profileResponse.user.businessAddress,
                        //             profile.profileResponse.user.feed[0]
                        //                 .description,
                        //             profile
                        //                 .profileResponse.user.feed[0].isLiked,
                        //             profile.profileResponse.user.feed[0]
                        //                 .isDisliked,
                        //             profile.profileResponse.user.feed[0]
                        //                 .totalLikes,
                        //             profile.profileResponse.user.feed[0]
                        //                 .totalDislikes,
                        //             profile.profileResponse.user.feed[0]
                        //                 .totalComments,
                        //             profile.profileResponse.user.feed[0]
                        //                 .totalShares,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        myCheckInsView(),
                        // GlobalView().sizedBoxView(20),
                        // myFriendsView(),
                        // GlobalView().sizedBoxView(20),
                        // myBusinessFriendsView(),
                        // GlobalView().sizedBoxView(20),
                        // mediaView(context),
                        GlobalView().sizedBoxView(30),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                // color: BaseColor.loader_bg_color,
                child: GlobalView().loaderView(),
              );
            }
          })
        ],
      ),
    );
  }

  FutureOr onCallBack(var value) {
    Provider.of<BusinessUserProvider>(context, listen: false)
        .listBusinessKeywords
        .clear();
    Provider.of<BusinessUserProvider>(context, listen: false)
        .getBusinessUserProfile(context);
  }

  void onClickAddKeywordButton() {
    if (businessKeywordsTextEditingController.text.isNotEmpty) {
      final provider =
          Provider.of<BusinessUserProvider>(context, listen: false);
      provider.addToListBusinessKeywords(
          businessKeywordsTextEditingController.text.toLowerCase());
      print(
          "listBusinessKeywords length==-> ${provider.listBusinessKeywords.length}");
      provider.updateListKeywords(
          context, provider.listBusinessKeywords.join(","));
      print(
          "listBusinessKeywords length-=-=-=-=> ${provider.listBusinessKeywords.length}");
      businessKeywordsTextEditingController.text = "";
    } else {
      GlobalView().showToast(AppToastMessages.empty_keywords_message);
    }
  }

  Widget businessHoursView() {
    return Consumer<BusinessUserProvider>(builder: (_, profile, child) {
      return Container(
          child: Visibility(
        visible:
            profile.businessUserProfileResponse.user.businessHours.isNotEmpty
                ? true
                : false,
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // GlobalView().textViewWithStartAlign(
                //     "All times in " +
                //         profile.selectedTimeZone.value +
                //         " Timezone",
                //     AppTextStyle.inter_font_family,
                //     AppTextStyle.bold_font_weight,
                //     BaseColor.black_color,
                //     16),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "All times in ",
                    style: TextStyle(
                        color: BaseColor.black_color,
                        fontFamily: AppTextStyle.inter_font_family,
                        fontWeight: AppTextStyle.medium_font_weight,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: profile.selectedTimeZone.value,
                    style: TextStyle(
                        color: BaseColor.black_color,
                        fontFamily: AppTextStyle.inter_font_family,
                        fontWeight: AppTextStyle.bold_font_weight,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: " Timezone",
                    style: TextStyle(
                        color: BaseColor.black_color,
                        fontFamily: AppTextStyle.inter_font_family,
                        fontWeight: AppTextStyle.medium_font_weight,
                        fontSize: 16),
                  ),
                ])),
                GlobalView().sizedBoxView(3),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profile
                        .businessUserProfileResponse.user.businessHours.length,
                    itemBuilder: (_, index) {
                      return Row(children: [
                        GlobalView().textViewWithStartAlign(
                            DayTimeUtils().getDay(profile
                                .businessUserProfileResponse
                                .user
                                .businessHours[index]
                                .dayNumber),
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color,
                            18),
                        SizedBox(width: 20),
                        GlobalView().textViewWithStartAlign(
                            profile.businessUserProfileResponse.user
                                        .businessHours[index].isOpen ==
                                    false
                                ? AppMessages.closed_text
                                : profile.businessUserProfileResponse.user
                                        .businessHours[index].openTime +
                                    " - " +
                                    profile.businessUserProfileResponse.user
                                        .businessHours[index].closeTime,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color,
                            18),
                        // GlobalView().textViewWithStartAlign(
                        //     profile.businessUserProfileResponse.user
                        //         .businessHours[index].closeTime,
                        //     AppTextStyle.inter_font_family,
                        //     AppTextStyle.medium_font_weight,
                        //     BaseColor.black_color,
                        //     18)
                      ]);
                    }),
              ],
            ),
          ),
        ),
      ));
    });
  }

  Widget myCheckInsView(
          // BusinessUserProfileProv user,
          ) =>
      Consumer<BusinessUserProvider>(builder: (_, profile, child) {
        return profile.businessUserProfileResponse.user.feed.isNotEmpty
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              GlobalView().textViewWithStartAlign(
                                  AppMessages.my_checkins,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.bold_font_weight,
                                  BaseColor.black_color,
                                  18),
                              GlobalView().textViewWithStartAlign(
                                  profile.businessUserProfileResponse.user
                                              .totalFeeds
                                              .toString()
                                              .isNotEmpty &&
                                          profile.businessUserProfileResponse
                                                  .user.totalFeeds
                                                  .toString() !=
                                              null
                                      ? " (" +
                                          profile.businessUserProfileResponse
                                              .user.totalFeeds
                                              .toString() +
                                          ")"
                                      : "0",
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.bold_font_weight,
                                  BaseColor.count_color,
                                  12),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.my_all_check_ins_route_name);
                          },
                          child: Container(
                            child: GlobalView().textViewWithStartAlign(
                                AppMessages.see_all_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.forgot_pass_txt_color,
                                12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GlobalView().sizedBoxView(15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                                    //         image: profile
                                    //                     .businessUserProfileResponse
                                    //                     .user
                                    //                     .avatar !=
                                    //                 ""
                                    //             ? NetworkImage(profile
                                    //                 .businessUserProfileResponse
                                    //                 .user
                                    //                 .avatar)
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              GlobalView()
                                                  .textViewWithStartAlign(
                                                      profile
                                                                  .businessUserProfileResponse
                                                                  .user
                                                                  .feed[0]
                                                                  .user
                                                                  .username ==
                                                              null
                                                          //     &&
                                                          // profile
                                                          //         .businessUserProfileResponse
                                                          //         .user
                                                          //         .lastName ==
                                                          //     null
                                                          ? "John Doe"
                                                          : profile
                                                              .businessUserProfileResponse
                                                              .user
                                                              .feed[0]
                                                              .user
                                                              .username
                                                      //     +
                                                      // " " +
                                                      // profile
                                                      //     .businessUserProfileResponse
                                                      //     .user
                                                      //     .lastName
                                                      ,
                                                      AppTextStyle
                                                          .metropolis_font_family,
                                                      AppTextStyle
                                                          .semi_bold_font_weight,
                                                      BaseColor.black_color,
                                                      12),
                                              GlobalView().textViewWithStartAlign(
                                                  DayTimeUtils().convertToAgo(
                                                      profile
                                                          .businessUserProfileResponse
                                                          .user
                                                          .feed[0]
                                                          .createdAt),
                                                  AppTextStyle
                                                      .metropolis_font_family,
                                                  AppTextStyle
                                                      .medium_font_weight,
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
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          DeviceSize().deviceWidth(context) *
                                              0.2,
                                      width: DeviceSize().deviceWidth(context) *
                                          0.2,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: profile
                                                        .businessUserProfileResponse
                                                        .user
                                                        .avatar !=
                                                    ""
                                                ? NetworkImage(profile
                                                    .businessUserProfileResponse
                                                    .user
                                                    .avatar)
                                                : AssetImage(AppImages
                                                    .default_profile_Pic),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: GlobalView()
                                                .textViewWithStartAlign(
                                                    profile.businessUserProfileResponse.user
                                                                .businessName ==
                                                            null
                                                        ? "ChoxBlast Cafe"
                                                        : profile
                                                            .businessUserProfileResponse
                                                            .user
                                                            .businessName,
                                                    // "ChoxBlast Cafe",
                                                    AppTextStyle
                                                        .metropolis_font_family,
                                                    AppTextStyle
                                                        .bold_font_weight,
                                                    BaseColor.black_color,
                                                    18),
                                          ),
                                          GlobalView().sizedBoxView(2),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 0, left: 0, right: 0),
                                            child: GlobalView()
                                                .textViewWithStartAlign(
                                                    profile
                                                            .businessUserProfileResponse
                                                            .user
                                                            .feed[0]
                                                            .categories
                                                            .isEmpty
                                                        ? "Cafe"
                                                        : CategoryUtils()
                                                            .getCategoryName(profile
                                                                .businessUserProfileResponse
                                                                .user
                                                                .feed[0]
                                                                .categories),
                                                    // "Cafe",
                                                    AppTextStyle
                                                        .metropolis_font_family,
                                                    AppTextStyle
                                                        .semi_bold_font_weight,
                                                    BaseColor
                                                        .forgot_pass_txt_color,
                                                    12),
                                          ),
                                          GlobalView().sizedBoxView(2),
                                          Visibility(
                                            visible: profile
                                                            .businessUserProfileResponse
                                                            .user
                                                            .feed[0]
                                                            .locationName ==
                                                        null ||
                                                    profile
                                                            .businessUserProfileResponse
                                                            .user
                                                            .feed[0]
                                                            .locationName ==
                                                        ""
                                                ? false
                                                : true,
                                            child: Container(
                                              child: GlobalView()
                                                  .textViewWithStartAlign(
                                                      profile
                                                                  .businessUserProfileResponse
                                                                  .user
                                                                  .feed[0]
                                                                  .locationName ==
                                                              null
                                                          ? "Cafe"
                                                          : profile
                                                              .businessUserProfileResponse
                                                              .user
                                                              .feed[0]
                                                              .locationName,
                                                      // "Cafe",
                                                      AppTextStyle
                                                          .metropolis_font_family,
                                                      AppTextStyle
                                                          .bold_font_weight,
                                                      BaseColor
                                                          .forgot_pass_txt_color,
                                                      12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                        padding:
                                            EdgeInsets.only(left: 7, top: 2),
                                        alignment: Alignment.centerLeft,
                                        child: GlobalView()
                                            .textViewWithStartAlign(
                                                profile.businessUserProfileResponse.user
                                                            .isMobile ==
                                                        1
                                                    ? AppMessages
                                                        .mobile_business_text
                                                    : profile.businessUserProfileResponse.user
                                                                .isOnline ==
                                                            0
                                                        ? profile.businessUserProfileResponse
                                                                        .user !=
                                                                    null &&
                                                                profile
                                                                        .businessUserProfileResponse
                                                                        .user
                                                                        .feed !=
                                                                    null &&
                                                                profile
                                                                        .businessUserProfileResponse
                                                                        .user
                                                                        .businessAddress ==
                                                                    null
                                                            ? "Abix Street, Main Road, San Fransisco, California"
                                                            : profile
                                                                .businessUserProfileResponse
                                                                .user
                                                                .businessAddress
                                                        : AppMessages
                                                            .online_business_text,
                                                AppTextStyle
                                                    .metropolis_font_family,
                                                AppTextStyle.medium_font_weight,
                                                BaseColor.black_color
                                                    .withOpacity(0.6),
                                                12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GlobalView().sizedBoxView(5),
                              Visibility(
                                visible: profile.businessUserProfileResponse
                                            .user.feed[0].description ==
                                        ""
                                    ? false
                                    : true,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: GlobalView().textViewWithStartAlign(
                                        profile.businessUserProfileResponse
                                                        .user !=
                                                    null &&
                                                profile.businessUserProfileResponse
                                                        .user.feed !=
                                                    null &&
                                                profile
                                                        .businessUserProfileResponse
                                                        .user
                                                        .feed[0]
                                                        .description !=
                                                    null
                                            ? profile
                                                .businessUserProfileResponse
                                                .user
                                                .feed[0]
                                                .description
                                            : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut…",
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
                              //           color: BaseColor.blackColor.withOpacity(0.5),
                              //         ),
                              //       )),
                              // ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 5),
                                child: Container(
                                  child: Row(
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     profile.profileCheckInsLike(
                                      //         context,
                                      //         profile
                                      //             .businessUserProfileResponse
                                      //             .user
                                      //             .feed[0]
                                      //             .id,
                                      //         profile.businessUserProfileResponse
                                      //                     .user.feed[0].isLiked ==
                                      //                 1
                                      //             ? 0
                                      //             : 1,
                                      //         0);
                                      //     print(
                                      //         "LIKED=-=-=>> ${profile.businessUserProfileResponse.user.feed[0].isLiked}");
                                      //   },
                                      //   child: Image.asset(
                                      //     profile.businessUserProfileResponse
                                      //                 .user.feed[0].isLiked ==
                                      //             1
                                      //         ? AppImages.thumbs_up_filled
                                      //         : AppImages.thumbs_up,
                                      //     height: 24,
                                      //     width: 24,
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   child: Container(
                                      //     margin: EdgeInsets.only(left: 10),
                                      //     child: GlobalView().textViewWithStartAlign(
                                      //         profile.businessUserProfileResponse.user != null &&
                                      //                 profile.businessUserProfileResponse
                                      //                         .user.feed !=
                                      //                     null &&
                                      //                 profile
                                      //                         .businessUserProfileResponse
                                      //                         .user
                                      //                         .feed[0]
                                      //                         .totalLikes
                                      //                         .toString() ==
                                      //                     null
                                      //             ? "0"
                                      //             : profile
                                      //                 .businessUserProfileResponse
                                      //                 .user
                                      //                 .feed[0]
                                      //                 .totalLikes
                                      //                 .toString(),
                                      //         AppTextStyle
                                      //             .metropolis_font_family,
                                      //         AppTextStyle.medium_font_weight,
                                      //         BaseColor.black_color
                                      //             .withOpacity(0.5),
                                      //         12),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 30,
                                      // ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     print(
                                      //         "DIS LIKED>> ${user.profileResponse.user.feed[0].isDisliked}");
                                      //     print(
                                      //         "TOTAL DIS LIKES>> ${user.profileResponse.user.feed[0].totalDislikes}");
                                      //     // home.feed_detail_like_dislike(
                                      //     //   context,
                                      //     //   user.profileResponse.user.feed[0].id
                                      //     //       .toString(),
                                      //     // "0",
                                      //     // user.profileResponse.user.feed[0]
                                      //     //             .isDisliked ==
                                      //     //         1
                                      //     //     ? "0"
                                      //     //     : "1",
                                      //     //   // user.profileResponse.user.feed[0],
                                      //     //   "dislike",
                                      //     // );
                                      //     // profile.checkIns_like_dislike(
                                      //     //     context,
                                      //     //     user.profileResponse.user.feed[0]
                                      //     //         .id
                                      //     //         .toString(),
                                      //     //     "dislike",
                                      //     //     "0",
                                      //     //     user.profileResponse.user.feed[0]
                                      //     //                 .isDisliked ==
                                      //     //             1
                                      //     //         ? "0"
                                      //     //         : "1",
                                      //     //     0);
                                      //     print(
                                      //         "DIS LIKED=-=-=>> ${user.profileResponse.user.feed[0].isDisliked}");
                                      //   },
                                      //   child: Image.asset(
                                      //     user.profileResponse.user.feed[0]
                                      //                 .isDisliked ==
                                      //             1
                                      //         ? AppImages.thumbs_down_filled
                                      //         : AppImages.thumbs_down,
                                      //     height: 24,
                                      //     width: 24,
                                      //   ),
                                      // ),
                                      // Expanded(
                                      //   child: Container(
                                      //     margin: EdgeInsets.only(left: 10),
                                      //     child: GlobalView()
                                      //         .textViewWithStartAlign(
                                      //             user.profileResponse.user ==
                                      //                         null &&
                                      //                     user.profileResponse
                                      //                             .user.feed ==
                                      //                         null &&
                                      //                     user
                                      //                             .profileResponse
                                      //                             .user
                                      //                             .feed[0]
                                      //                             .totalDislikes
                                      //                             .toString() ==
                                      //                         null
                                      //                 ? "0"
                                      //                 : user
                                      //                     .profileResponse
                                      //                     .user
                                      //                     .feed[0]
                                      //                     .totalDislikes
                                      //                     .toString(),
                                      //             AppTextStyle
                                      //                 .metropolisFontFamily,
                                      //             AppTextStyle.mediumFontWeight,
                                      //             BaseColor.blackColor
                                      //                 .withOpacity(0.5),
                                      //             12),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 30,
                                      // ),
                                      // Image.asset(
                                      //   AppImages.ic_comments,
                                      //   height: 24,
                                      //   width: 24,
                                      // ),
                                      // Expanded(
                                      //   child: Container(
                                      //     margin: EdgeInsets.only(left: 10),
                                      //     child: GlobalView().textViewWithStartAlign(
                                      //         profile.businessUserProfileResponse.user != null &&
                                      //                 profile.businessUserProfileResponse
                                      //                         .user.feed !=
                                      //                     null &&
                                      //                 profile
                                      //                         .businessUserProfileResponse
                                      //                         .user
                                      //                         .feed[0]
                                      //                         .totalComments
                                      //                         .toString() !=
                                      //                     null
                                      //             ? profile
                                      //                 .businessUserProfileResponse
                                      //                 .user
                                      //                 .feed[0]
                                      //                 .totalComments
                                      //                 .toString()
                                      //             : "0",
                                      //         AppTextStyle
                                      //             .metropolis_font_family,
                                      //         AppTextStyle.medium_font_weight,
                                      //         BaseColor.black_color
                                      //             .withOpacity(0.5),
                                      //         12),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   width: 30,
                                      // ),
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
                                      //             user.profileResponse.user !=
                                      //                         null &&
                                      //                     user.profileResponse
                                      //                             .user.feed !=
                                      //                         null &&
                                      //                     user
                                      //                             .profileResponse
                                      //                             .user
                                      //                             .feed[0]
                                      //                             .totalShares
                                      //                             .toString() !=
                                      //                         null
                                      //                 ? user
                                      //                     .profileResponse
                                      //                     .user
                                      //                     .feed[0]
                                      //                     .totalShares
                                      //                     .toString()
                                      //                 : "0",
                                      //             AppTextStyle
                                      //                 .metropolisFontFamily,
                                      //             AppTextStyle.mediumFontWeight,
                                      //             BaseColor.blackColor
                                      //                 .withOpacity(0.5),
                                      //             12),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            : Container();
      });

  Widget myFriendsView() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GlobalView().textViewWithStartAlign(
                          AppMessages.my_friends,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.black_color,
                          18),
                      GlobalView().textViewWithStartAlign(
                          " (" + 84.toString() + ")",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.count_color,
                          12),
                    ],
                  ),
                ),
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.see_all_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.forgot_pass_txt_color,
                      12),
                ),
              ],
            ),
          ),
          GlobalView().sizedBoxView(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                  // image: DecorationImage(
                                  //   image: NetworkImage(""),
                                  // ),
                                ),
                              ),
                              GlobalView().sizedBoxView(10),
                              GlobalView().textViewWithCenterAlign(
                                  "John Doe",
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.medium_font_weight,
                                  BaseColor.black_color,
                                  11)
                            ],
                          ),
                        );
                      }),
                )),
          ),
        ],
      );

  Widget myBusinessFriendsView() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GlobalView().textViewWithStartAlign(
                          AppMessages.my_business_friends,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.black_color,
                          18),
                      GlobalView().textViewWithStartAlign(
                          " (" + 84.toString() + ")",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.count_color,
                          12),
                    ],
                  ),
                ),
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.see_all_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.forgot_pass_txt_color,
                      12),
                ),
              ],
            ),
          ),
          GlobalView().sizedBoxView(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                height: 100,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 18, right: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              // image: DecorationImage(
                              //   image: NetworkImage(""),
                              // ),
                            ),
                          ),
                          GlobalView().sizedBoxView(10),
                          GlobalView().textViewWithCenterAlign(
                              "ChoxBlast \n Cafe",
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              11)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );

  Widget mediaView(BuildContext context) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.media_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.bold_font_weight,
                      BaseColor.black_color,
                      18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.media_route_name);
                  },
                  child: Container(
                    child: GlobalView().textViewWithStartAlign(
                        AppMessages.see_all_text,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.medium_font_weight,
                        BaseColor.forgot_pass_txt_color,
                        12),
                  ),
                ),
              ],
            ),
          ),
          GlobalView().sizedBoxView(15),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
            child: Container(
              height: 130,
              alignment: Alignment.center,
              // color: Colors.red,
              child: Card(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 7, left: 10, right: 10, bottom: 7),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.95,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppImages.photo1,
                          fit: BoxFit.cover,
                        );
                      }),
                ),
              ),
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';

class SearchPlaceDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(AppImages.background_image1))),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: BaseColor.pure_white_color,
              expandedHeight: 300,
              // pinned: true,
              // floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                child:
                    // profile.listMediaImages.length == 1
                    //     ?
                    //  FadeInImage.assetNetwork(
                    //     placeholder: AppImages.loader_gif_removeBG,
                    //     image: profile.listMediaImages[0],
                    //     fit: BoxFit.cover,
                    //     height: 300,
                    //     width: ScreenSize().screenWidth(context),
                    //   )
                    // :
                    // CarouselSlider(
                    //     // items: profile.profileResponse.user.businessMedia[0].media
                    //     items: profile.listMediaImages
                    //         .map((item) => Container(
                    //               child: Container(
                    //                 child:
                    //                     // ClipRRect(
                    //                     //     child: Stack(
                    //                     //   children: <Widget>[
                    //                     FadeInImage.assetNetwork(
                    //                   placeholder:
                    //                       AppImages.loader_gif_removeBG,
                    //                   image: item,
                    //                   fit: BoxFit.cover,
                    //                   height: 300,
                    //                   width:
                    //                       ScreenSize().screenWidth(context),
                    //                 ),
                    //                 //   ],
                    //                 // )),
                    //               ),
                    //             ))
                    //         .toList(),
                    //     options: CarouselOptions(
                    //         // height: height,
                    //         // enlargeCenterPage: false,
                    //         // reverse: true,
                    //         autoPlay: true,
                    //         autoPlayInterval: Duration(seconds: 5),
                    //         autoPlayAnimationDuration:
                    //             Duration(milliseconds: 1500),
                    //         autoPlayCurve: Curves.ease,
                    //         aspectRatio: 1.0,
                    //         viewportFraction: 1.0,
                    //         onPageChanged: (index, season) {
                    //           // _current = index;
                    //           profile.setCurrentIndex(index);
                    //         }),
                    //   )
                    Image.asset(
                  AppImages.photo3,
                  fit: BoxFit.cover,
                ),
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
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Image.asset(
                        AppImages.ic_back_filled,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverStickyHeader(
              header: Column(
                children: [
                  GlobalView().sizedBoxView(20),
                  GlobalView().textViewWithCenterAlign(
                      // profile.profileResponse.user.businessName.length > 1
                      //     ? profile.profileResponse.user.businessName
                      //     : "ChoxBlast Cafe",
                      "ChoxBlast Cafe",
                      AppTextStyle.inter_font_family,
                      AppTextStyle.bold_font_weight,
                      BaseColor.black_color,
                      20),
                  GlobalView().sizedBoxView(5),
                  GlobalView().textViewWithCenterAlign(
                      // profile.profileResponse.user.feed.isNotEmpty &&
                      //         profile.profileResponse.user.feed[0].category.name
                      //                 .length >
                      //             1
                      //     ? profile.profileResponse.user.feed[0].category.name
                      //     : "Restaurant",
                      "Restaurant",
                      AppTextStyle.inter_font_family,
                      AppTextStyle.medium_font_weight,
                      BaseColor.forgot_pass_txt_color,
                      12),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GlobalView().sizedBoxView(10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GlobalView().textViewWithCenterAlign(
                                // profile.profileResponse.user.totalViews
                                //             .toString() !=
                                //         null
                                //     ? profile.profileResponse.user.totalViews
                                //         .toString()
                                //     : "0",
                                "0",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.bold_font_weight,
                                BaseColor.black_color,
                                20),
                            GlobalView().sizedBoxView(5),
                            GlobalView().textViewWithCenterAlign(
                                AppMessages.followers_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.selected_tab_color,
                                12),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GlobalView().textViewWithCenterAlign(
                                // profile.profileResponse.user.totalLikes
                                //             .toString() !=
                                //         null
                                //     ? profile.profileResponse.user.totalLikes
                                //         .toString()
                                //     : "0",
                                "0",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.bold_font_weight,
                                BaseColor.black_color,
                                20),
                            GlobalView().sizedBoxView(5),
                            GlobalView().textViewWithCenterAlign(
                                AppMessages.likes_text,
                                AppTextStyle.inter_font_family,
                                AppTextStyle.medium_font_weight,
                                BaseColor.selected_tab_color,
                                12),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GlobalView().sizedBoxView(15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: GlobalView().buttonFilled(
                        context, AppMessages.follow_text.substring(1)),
                  ),
                  GlobalView().sizedBoxView(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          AppMessages.about_text,
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
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          // profile.profileResponse.user.desc
                          //               .toString() !=
                          //           null
                          //       ? profile.profileResponse.user.totalLikes
                          //           .toString()
                          //       : "0",
                          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut… See more",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.medium_font_weight,
                          BaseColor.black_color,
                          12),
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
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
                  GlobalView().sizedBoxView(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          // profile.profileResponse.user.businessPhone
                          //             .toString() !=
                          //         null
                          //     ? profile
                          //         .profileResponse.user.businessPhone
                          //         .toString()
                          //     : "0",
                          "0",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.medium_font_weight,
                          BaseColor.black_color,
                          14),
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: DeviceSize().deviceWidth(context) - 250,
                        // padding: const EdgeInsets.only(right)
                        child: GlobalView().wrappedButtonFilledView(
                            context, AppMessages.call_now_text),
                      ),
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          AppMessages.hint_business_address,
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
                      alignment: Alignment.centerLeft,
                      child: GlobalView().textViewWithStartAlign(
                          // profile.profileResponse.user.businessPhone
                          //             .toString() !=
                          //         null
                          //     ? profile
                          //         .profileResponse.user.businessPhone
                          //         .toString()
                          //     : "0",
                          "Abix Street, Main Road, San Fransisco, California, US",
                          AppTextStyle.inter_font_family,
                          AppTextStyle.medium_font_weight,
                          BaseColor.black_color,
                          14),
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: DeviceSize().deviceWidth(context) - 220,
                        // padding: const EdgeInsets.only(right)
                        child: GlobalView().wrappedButtonFilledView(
                            context, AppMessages.get_direction_text),
                      ),
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
                  // Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     child: businessCheckInsView()),

                  // myCheckInsView(profile),
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
        ),
      ),
    );
  }

  Widget businessCheckInsView() => Row(
        children: [
          Expanded(
            child: Row(
              children: [
                GlobalView().textViewWithStartAlign(
                    AppMessages.business_checkins_title + " (" + "0" + ")",
                    AppTextStyle.inter_font_family,
                    AppTextStyle.bold_font_weight,
                    BaseColor.black_color,
                    18),
                GlobalView().textViewWithStartAlign(
                    // user.profileResponse.user.totalFeed == null
                    //     ? " (" + "0" + ")"
                    //     : " (" +
                    //         user.profileResponse.user.totalFeed
                    //             .toString() +
                    //         ")",
                    " (" + "0" + ")",
                    AppTextStyle.inter_font_family,
                    AppTextStyle.bold_font_weight,
                    BaseColor.count_color,
                    12),
              ],
            ),
          ),
          GlobalView().textViewWithStartAlign(
              AppMessages.see_all_text,
              AppTextStyle.inter_font_family,
              AppTextStyle.medium_font_weight,
              BaseColor.forgot_pass_txt_color,
              14),
        ],
      );
  // Widget myCheckInsView(
  //   ProfileProvider user,
  // ) =>
  //     Consumer<ProfileProvider>(builder: (_, profile, child) {
  //       return profile.profileResponse.user.feed.isNotEmpty
  //           ? Column(
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: Row(
  //                           children: [
  //                             GlobalView().textViewWithStartAlign(
  //                                 AppMessages.myCheckIns,
  //                                 AppTextStyle.interFontFamily,
  //                                 AppTextStyle.boldFontWeight,
  //                                 BaseColor.blackColor,
  //                                 18),
  //                             GlobalView().textViewWithStartAlign(
  //                                 user.profileResponse.user.totalFeed
  //                                             .toString()
  //                                             .isNotEmpty &&
  //                                         user.profileResponse.user.totalFeed
  //                                                 .toString() !=
  //                                             null
  //                                     ? " (" +
  //                                         user.profileResponse.user.totalFeed
  //                                             .toString() +
  //                                         ")"
  //                                     : "0",
  //                                 AppTextStyle.interFontFamily,
  //                                 AppTextStyle.boldFontWeight,
  //                                 BaseColor.countColor,
  //                                 12),
  //                           ],
  //                         ),
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           Navigator.pushNamed(
  //                               context, AppRoutes.myAllCheckInsRouteName);
  //                         },
  //                         child: Container(
  //                           child: GlobalView().textViewWithStartAlign(
  //                               AppMessages.seeAllText,
  //                               AppTextStyle.interFontFamily,
  //                               AppTextStyle.mediumFontWeight,
  //                               BaseColor.forgotPassTxtColor,
  //                               12),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 GlobalView().sizedBoxView(15),
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 20),
  //                   child: Card(
  //                       elevation: 2,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: Padding(
  //                         padding: EdgeInsets.symmetric(vertical: 10),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 10),
  //                               child: Row(
  //                                 children: [
  //                                   Container(
  //                                     height: 32,
  //                                     width: 32,
  //                                     decoration: BoxDecoration(
  //                                       shape: BoxShape.circle,
  //                                       color: Colors.grey,
  //                                       image: DecorationImage(
  //                                           image: user.profileResponse.user
  //                                                       .avatar !=
  //                                                   ""
  //                                               ? NetworkImage(user
  //                                                   .profileResponse
  //                                                   .user
  //                                                   .avatar)
  //                                               : AssetImage(AppImages
  //                                                   .default_profile_Pic),
  //                                           fit: BoxFit.cover),
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                     child: Padding(
  //                                       padding: EdgeInsets.symmetric(
  //                                           horizontal: 10),
  //                                       child: Container(
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           children: [
  //                                             GlobalView().textViewWithStartAlign(
  //                                                 user.profileResponse.user
  //                                                                 .firstName ==
  //                                                             null &&
  //                                                         user
  //                                                                 .profileResponse
  //                                                                 .user
  //                                                                 .lastName ==
  //                                                             null
  //                                                     ? "John Doe"
  //                                                     : user.profileResponse
  //                                                             .user.firstName +
  //                                                         " " +
  //                                                         user.profileResponse
  //                                                             .user.lastName,
  //                                                 AppTextStyle
  //                                                     .metropolisFontFamily,
  //                                                 AppTextStyle
  //                                                     .semiBoldFontWeight,
  //                                                 BaseColor.blackColor,
  //                                                 12),
  //                                             GlobalView()
  //                                                 .textViewWithStartAlign(
  //                                                     "15 min ago",
  //                                                     AppTextStyle
  //                                                         .metropolisFontFamily,
  //                                                     AppTextStyle
  //                                                         .mediumFontWeight,
  //                                                     BaseColor.blackColor,
  //                                                     10),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                       height: 24,
  //                                       width: 24,
  //                                       child: GestureDetector(
  //                                         onTap: () {
  //                                           // user.changeIsVisibleValue();
  //                                         },
  //                                         child:
  //                                             //  Text(
  //                                             //   user.isVisible.toString(),
  //                                             // ),
  //                                             Image.asset(AppImages.ic_menu),
  //                                       ))
  //                                 ],
  //                               ),
  //                             ),
  //                             GlobalView().sizedBoxView(10),
  //                             Divider(
  //                               color: BaseColor.homeDividerColor,
  //                               height: 2,
  //                               thickness: 1,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.only(
  //                                   top: 10, left: 10, right: 10),
  //                               child: GlobalView().textViewWithStartAlign(
  //                                   user.profileResponse.user != null &&
  //                                           user.profileResponse.user.feed !=
  //                                               null &&
  //                                           user.profileResponse.user.feed[0]
  //                                                   .category.name !=
  //                                               null
  //                                       ? user.profileResponse.user.feed[0]
  //                                           .category.name
  //                                       : "Cafe",
  //                                   AppTextStyle.metropolisFontFamily,
  //                                   AppTextStyle.semiBoldFontWeight,
  //                                   BaseColor.forgotPassTxtColor,
  //                                   10),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 10),
  //                               child: GlobalView().textViewWithStartAlign(
  //                                   user.profileResponse.user != null &&
  //                                           user.profileResponse.user.feed !=
  //                                               null &&
  //                                           user.profileResponse.user
  //                                                   .businessName ==
  //                                               null
  //                                       ? "ChoxBlast Cafe"
  //                                       : user
  //                                           .profileResponse.user.businessName,
  //                                   AppTextStyle.metropolisFontFamily,
  //                                   AppTextStyle.boldFontWeight,
  //                                   BaseColor.blackColor,
  //                                   16),
  //                             ),
  //                             GlobalView().sizedBoxView(5),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 10),
  //                               child: Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: [
  //                                   Container(
  //                                     height: 16,
  //                                     width: 16,
  //                                     child: Image.asset(
  //                                       AppImages.ic_location_black,
  //                                       color: Colors.grey,
  //                                     ),
  //                                   ),
  //                                   Expanded(
  //                                     child: Container(
  //                                       padding:
  //                                           EdgeInsets.only(left: 7, top: 2),
  //                                       alignment: Alignment.centerLeft,
  //                                       child: GlobalView().textViewWithStartAlign(
  //                                           user.profileResponse.user != null &&
  //                                                   user.profileResponse.user
  //                                                           .feed !=
  //                                                       null &&
  //                                                   user.profileResponse.user
  //                                                           .businessAddress ==
  //                                                       null
  //                                               ? "Abix Street, Main Road, San Fransisco, California"
  //                                               : user.profileResponse.user
  //                                                   .businessAddress,
  //                                           AppTextStyle.metropolisFontFamily,
  //                                           AppTextStyle.mediumFontWeight,
  //                                           BaseColor.blackColor
  //                                               .withOpacity(0.6),
  //                                           12),
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                             GlobalView().sizedBoxView(15),
  //                             Padding(
  //                               padding: EdgeInsets.only(left: 10, right: 10),
  //                               child: Container(
  //                                 alignment: Alignment.centerLeft,
  //                                 child: GlobalView().textViewWithStartAlign(
  //                                     user.profileResponse.user != null &&
  //                                             user.profileResponse.user.feed !=
  //                                                 null &&
  //                                             user.profileResponse.user.feed[0]
  //                                                     .description !=
  //                                                 null
  //                                         ? user.profileResponse.user.feed[0]
  //                                             .description
  //                                         : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut…",
  //                                     AppTextStyle.interFontFamily,
  //                                     AppTextStyle.mediumFontWeight,
  //                                     BaseColor.blackColor,
  //                                     12),
  //                               ),
  //                             ),
  //                             // Padding(
  //                             //   padding: EdgeInsets.only(left: 10, right: 10),
  //                             //   child: Container(
  //                             //       alignment: Alignment.centerLeft,
  //                             //       child: Text(
  //                             //         "See more",
  //                             //         style: TextStyle(
  //                             //           decoration: TextDecoration.underline,
  //                             //           fontFamily: AppTextStyle.interFontFamily,
  //                             //           fontWeight: FontWeight.w600,
  //                             //           fontSize: 12,
  //                             //           color: BaseColor.blackColor.withOpacity(0.5),
  //                             //         ),
  //                             //       )),
  //                             // ),
  //                             Padding(
  //                               padding: EdgeInsets.only(
  //                                   left: 16, right: 16, top: 10),
  //                               child: Container(
  //                                 child: Row(
  //                                   children: [
  //                                     GestureDetector(
  //                                       onTap: () {
  //                                         print(
  //                                             "LIKED>> ${user.profileResponse.user.feed[0].isLiked}");
  //                                         print(
  //                                             "TOTAL LIKES>> ${user.profileResponse.user.feed[0].totalLikes}");
  //                                         print(
  //                                             "User Response===-->> ${user.profileResponse.user.feed[0].toJson()}");

  //                                         profile.checkIns_like_dislike(
  //                                             context,
  //                                             user.profileResponse.user.feed[0]
  //                                                 .id
  //                                                 .toString(),
  //                                             "like",
  //                                             user.profileResponse.user.feed[0]
  //                                                         .isLiked ==
  //                                                     1
  //                                                 ? "0"
  //                                                 : "1",
  //                                             "0",
  //                                             0);
  //                                         print(
  //                                             "LIKED=-=-=>> ${user.profileResponse.user.feed[0].isLiked}");
  //                                       },
  //                                       child: Image.asset(
  //                                         user.profileResponse.user.feed[0]
  //                                                     .isLiked ==
  //                                                 1
  //                                             ? AppImages.thumbs_up_filled
  //                                             : AppImages.thumbs_up,
  //                                         height: 24,
  //                                         width: 24,
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                       child: Container(
  //                                         child: GlobalView()
  //                                             .textViewWithCenterAlign(
  //                                                 user.profileResponse.user !=
  //                                                             null &&
  //                                                         user.profileResponse
  //                                                                 .user.feed !=
  //                                                             null &&
  //                                                         user
  //                                                                 .profileResponse
  //                                                                 .user
  //                                                                 .feed[0]
  //                                                                 .totalLikes
  //                                                                 .toString() ==
  //                                                             null
  //                                                     ? "0"
  //                                                     : user
  //                                                         .profileResponse
  //                                                         .user
  //                                                         .feed[0]
  //                                                         .totalLikes
  //                                                         .toString(),
  //                                                 AppTextStyle
  //                                                     .metropolisFontFamily,
  //                                                 AppTextStyle.mediumFontWeight,
  //                                                 BaseColor.blackColor
  //                                                     .withOpacity(0.5),
  //                                                 12),
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       width: 30,
  //                                     ),
  //                                     GestureDetector(
  //                                       onTap: () {
  //                                         print(
  //                                             "DIS LIKED>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                                         print(
  //                                             "TOTAL DIS LIKES>> ${user.profileResponse.user.feed[0].totalDislikes}");
  //                                         // home.feed_detail_like_dislike(
  //                                         //   context,
  //                                         //   user.profileResponse.user.feed[0].id
  //                                         //       .toString(),
  //                                         // "0",
  //                                         // user.profileResponse.user.feed[0]
  //                                         //             .isDisliked ==
  //                                         //         1
  //                                         //     ? "0"
  //                                         //     : "1",
  //                                         //   // user.profileResponse.user.feed[0],
  //                                         //   "dislike",
  //                                         // );
  //                                         profile.checkIns_like_dislike(
  //                                             context,
  //                                             user.profileResponse.user.feed[0]
  //                                                 .id
  //                                                 .toString(),
  //                                             "dislike",
  //                                             "0",
  //                                             user.profileResponse.user.feed[0]
  //                                                         .isDisliked ==
  //                                                     1
  //                                                 ? "0"
  //                                                 : "1",
  //                                             0);
  //                                         print(
  //                                             "DIS LIKED=-=-=>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                                       },
  //                                       child: Image.asset(
  //                                         user.profileResponse.user.feed[0]
  //                                                     .isDisliked ==
  //                                                 1
  //                                             ? AppImages.thumbs_down_filled
  //                                             : AppImages.thumbs_down,
  //                                         height: 24,
  //                                         width: 24,
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                       child: Container(
  //                                         child: GlobalView()
  //                                             .textViewWithCenterAlign(
  //                                                 user.profileResponse.user ==
  //                                                             null &&
  //                                                         user.profileResponse
  //                                                                 .user.feed ==
  //                                                             null &&
  //                                                         user
  //                                                                 .profileResponse
  //                                                                 .user
  //                                                                 .feed[0]
  //                                                                 .totalDislikes
  //                                                                 .toString() ==
  //                                                             null
  //                                                     ? "0"
  //                                                     : user
  //                                                         .profileResponse
  //                                                         .user
  //                                                         .feed[0]
  //                                                         .totalDislikes
  //                                                         .toString(),
  //                                                 AppTextStyle
  //                                                     .metropolisFontFamily,
  //                                                 AppTextStyle.mediumFontWeight,
  //                                                 BaseColor.blackColor
  //                                                     .withOpacity(0.5),
  //                                                 12),
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       width: 30,
  //                                     ),
  //                                     Image.asset(
  //                                       AppImages.ic_comments,
  //                                       height: 24,
  //                                       width: 24,
  //                                     ),
  //                                     Expanded(
  //                                       child: Container(
  //                                         child: GlobalView()
  //                                             .textViewWithCenterAlign(
  //                                                 user.profileResponse.user !=
  //                                                             null &&
  //                                                         user.profileResponse
  //                                                                 .user.feed !=
  //                                                             null &&
  //                                                         user
  //                                                                 .profileResponse
  //                                                                 .user
  //                                                                 .feed[0]
  //                                                                 .totalComments
  //                                                                 .toString() !=
  //                                                             null
  //                                                     ? user
  //                                                         .profileResponse
  //                                                         .user
  //                                                         .feed[0]
  //                                                         .totalComments
  //                                                         .toString()
  //                                                     : "0",
  //                                                 AppTextStyle
  //                                                     .metropolisFontFamily,
  //                                                 AppTextStyle.mediumFontWeight,
  //                                                 BaseColor.blackColor
  //                                                     .withOpacity(0.5),
  //                                                 12),
  //                                       ),
  //                                     ),
  //                                     SizedBox(
  //                                       width: 30,
  //                                     ),
  //                                     Image.asset(
  //                                       AppImages.ic_share,
  //                                       height: 24,
  //                                       width: 24,
  //                                     ),
  //                                     Expanded(
  //                                       child: Container(
  //                                         child: GlobalView()
  //                                             .textViewWithCenterAlign(
  //                                                 user.profileResponse.user !=
  //                                                             null &&
  //                                                         user.profileResponse
  //                                                                 .user.feed !=
  //                                                             null &&
  //                                                         user
  //                                                                 .profileResponse
  //                                                                 .user
  //                                                                 .feed[0]
  //                                                                 .totalShares
  //                                                                 .toString() !=
  //                                                             null
  //                                                     ? user
  //                                                         .profileResponse
  //                                                         .user
  //                                                         .feed[0]
  //                                                         .totalShares
  //                                                         .toString()
  //                                                     : "0",
  //                                                 AppTextStyle
  //                                                     .metropolisFontFamily,
  //                                                 AppTextStyle.mediumFontWeight,
  //                                                 BaseColor.blackColor
  //                                                     .withOpacity(0.5),
  //                                                 12),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       )),
  //                 ),
  //               ],
  //             )
  //           : Container();
  //     });

}

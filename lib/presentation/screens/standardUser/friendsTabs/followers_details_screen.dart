import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';

class FollowersDetailsScreen extends StatelessWidget {
  const FollowersDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.pure_white_color,
      body: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(AppImages.background_image1))),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: BaseColor.pure_white_color,
              expandedHeight: 170,
              // expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: 160,
                      width: DeviceSize().deviceWidth(context),
                      child: Image.asset(
                        AppImages.bg_profile,
                        fit: BoxFit.cover,
                        // height: 120,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Container(
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
                                image: AssetImage(AppImages.photo3),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(
                  //         context, AppRoutes.editProfileRouteName)
                  //     .then((value) => onCallBack);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Container(
                    child: Image.asset(AppImages.ic_back_filled),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GlobalView().sizedBoxView(25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GlobalView().textViewWithCenterAlign(
                        // Provider.of<ProfileProvider>(context)
                        //             .profileResponse
                        //             .user
                        //             .username ==
                        //         null
                        //     ? "Test User"
                        //     : Provider.of<ProfileProvider>(context)
                        //         .profileResponse
                        //         .user
                        //         .username,
                        "John Doe",
                        AppTextStyle.inter_font_family,
                        AppTextStyle.bold_font_weight,
                        BaseColor.black_color,
                        20),
                  ),
                  GlobalView().sizedBoxView(15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                GlobalView().textViewWithCenterAlign(
                                    "325",
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.bold_font_weight,
                                    BaseColor.black_color,
                                    20),
                                GlobalView().textViewWithCenterAlign(
                                    AppMessages.business_friends_sub_title,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.medium_font_weight,
                                    BaseColor.selected_tab_color,
                                    12),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                GlobalView().textViewWithCenterAlign(
                                    "84",
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.bold_font_weight,
                                    BaseColor.black_color,
                                    20),
                                GlobalView().textViewWithCenterAlign(
                                    AppMessages.friends_title,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.medium_font_weight,
                                    BaseColor.selected_tab_color,
                                    12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GlobalView().sizedBoxView(20),
                  GlobalView().buttonFilled(context, AppMessages.add_friend_text),
                  GlobalView().sizedBoxView(20),
                  myCheckInsView(context),

                  // GlobalView().sizedBoxView(20),
                  // myFriendsView(),
                  // GlobalView().sizedBoxView(20),
                  // myBusinessFriendsView(),
                  // GlobalView().sizedBoxView(20),
                  // mediaView(),
                  GlobalView().sizedBoxView(30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myCheckInsView(BuildContext context) => Column(
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

                          // user.profileResponse.user.totalFeeds == null
                          //     ? " (" + "0" + ")"
                          //     : " (" +
                          //         user.profileResponse.user.totalFeeds
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
                GestureDetector(
                  onTap: () {
                    // print(
                    //     "TOTAL FEED ${user.profileResponse.user.totalFeed}");
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
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            // Container(
                            //   height: 32,
                            //   width: 32,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     color: Colors.grey,
                            //     image: DecorationImage(
                            //         image: user.profileResponse.user
                            //                     .avatar !=
                            //                 ""
                            //             ? NetworkImage(user
                            //                 .profileResponse
                            //                 .user
                            //                 .avatar)
                            //             : AssetImage(AppImages
                            //                 .default_profile_Pic),
                            //         fit: BoxFit.cover),
                            //   ),
                            // ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GlobalView().textViewWithStartAlign(
                                          // user.profileResponse.user.firstName ==
                                          //             null &&
                                          //         user.profileResponse.user
                                          //                 .lastName ==
                                          //             null
                                          //     ? "John Doe"
                                          //     : user.profileResponse.user
                                          //             .firstName +
                                          //         " " +
                                          //         user.profileResponse.user
                                          //             .lastName,
                                          "John Doe",
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
                            // user.profileResponse.user != null &&
                            //         user.profileResponse.user.feed != null &&
                            //         user.profileResponse.user.feed[0].category
                            //                 .name !=
                            //             null
                            //     ? user
                            //         .profileResponse.user.feed[0].category.name
                            //     : "Cafe",
                            "Cafe",
                            AppTextStyle.metropolis_font_family,
                            AppTextStyle.semi_bold_font_weight,
                            BaseColor.forgot_pass_txt_color,
                            10),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GlobalView().textViewWithStartAlign(
                            // user.profileResponse.user != null &&
                            //         user.profileResponse.user.feed != null &&
                            //         user.profileResponse.user.businessName ==
                            //             null
                            //     ? "ChoxBlast Cafe"
                            //     : user.profileResponse.user.businessName,
                            "ChoxBlast Cafe",
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
                                    // user.profileResponse.user != null &&
                                    //         user.profileResponse.user.feed !=
                                    //             null &&
                                    //         user.profileResponse.user
                                    //                 .businessAddress ==
                                    //             null
                                    //     ? "Abix Street, Main Road, San Fransisco, California"
                                    //     : user.profileResponse.user
                                    //         .businessAddress,
                                    "Abix Street, Main Road, San Fransisco, California",
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
                              // user.profileResponse.user != null &&
                              //         user.profileResponse.user.feed != null &&
                              //         user.profileResponse.user.feed[0]
                              //                 .description !=
                              //             null
                              //     ? user
                              //         .profileResponse.user.feed[0].description
                              //     : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut…",
                              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr",
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
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                // onTap: () {
                                //   print(
                                //       "LIKED>> ${user.profileResponse.user.feed[0].isLiked}");
                                //   print(
                                //       "TOTAL LIKES>> ${user.profileResponse.user.feed[0].totalLikes}");
                                //   print(
                                //       "User Response===-->> ${user.profileResponse.user.feed[0].toJson()}");

                                //   profile.checkIns_like(
                                //       context,
                                //       user.profileResponse.user.feed[0].id
                                //           .toString(),
                                //       user.profileResponse.user.feed[0]
                                //                   .isLiked ==
                                //               1
                                //           ? "0"
                                //           : "1",
                                //       0);
                                //   print(
                                //       "LIKED=-=-=>> ${user.profileResponse.user.feed[0].isLiked}");
                                // },
                                child: Image.asset(
                                  // user.profileResponse.user.feed[0].isLiked == 1
                                  //     ? AppImages.thumbs_up_filled
                                  //     : AppImages.thumbs_up,
                                  AppImages.thumbs_up_filled,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: GlobalView().textViewWithStartAlign(
                                      // user.profileResponse.user != null &&
                                      //         user.profileResponse.user.feed !=
                                      //             null &&
                                      //         user.profileResponse.user.feed[0]
                                      //                 .totalLikes
                                      //                 .toString() ==
                                      //             null
                                      //     ? "0"
                                      //     : user.profileResponse.user.feed[0]
                                      //         .totalLikes
                                      //         .toString(),
                                      "0",
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
                                      // user.profileResponse.user != null &&
                                      //         user.profileResponse.user.feed !=
                                      //             null &&
                                      //         user.profileResponse.user.feed[0]
                                      //                 .totalComments
                                      //                 .toString() !=
                                      //             null
                                      //     ? user.profileResponse.user.feed[0]
                                      //         .totalComments
                                      //         .toString()
                                      //     : "0",
                                      "0",
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
      );
}

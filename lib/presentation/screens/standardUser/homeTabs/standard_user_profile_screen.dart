import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/check_ins_item_view.dart';
import 'package:trendoapp/presentation/screens/common/account_settings_screen.dart';
import 'package:trendoapp/presentation/screens/common/my_all_check_ins_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/simple_user_registration_screen.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class StandardUserProfileScreen extends StatefulWidget {
  @override
  _StandardUserProfileScreenState createState() => _StandardUserProfileScreenState();
}

class _StandardUserProfileScreenState extends State<StandardUserProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeFeedResponseProvider>(context, listen: false).getProfile(context);
    // Future.delayed(Duration.zero, () {
    //   Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
    // });
  }

  FutureOr onCallBack(var value) {
    Provider.of<HomeFeedResponseProvider>(context, listen: false).getProfile(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Token-->> ${StorageUtils.readStringValue(StorageUtils.keyToken)}");
    // return ListenableProvider(
    //     create: (context) => ProfileProvider(),
    //     builder: (context, child) {
    return Stack(
      children: [
        Consumer2<HomeFeedResponseProvider, BaseResponseProvider>(builder: (_, user, baseresponse, child) {
          return !Provider.of<HomeFeedResponseProvider>(context).isLoading
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: BaseColor.home_bg_color,
                      // expandedHeight: 170,
                      expandedHeight: 120,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: DeviceSize().deviceWidth(context),
                              child: Image.asset(
                                AppImages.bg_profile,
                                fit: BoxFit.cover,
                                height: 120,
                              ),
                            ),
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(bottom: 5),
                            // child: Container(
                            //   height: 100,
                            //   width: 100,
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     border: Border.all(
                            //         color: BaseColor.pure_white_color,
                            //         width: 5),
                            //     boxShadow: [
                            //       BoxShadow(
                            //           color: BaseColor.shadow_color,
                            //           blurRadius: 5)
                            //     ],
                            //     image: DecorationImage(
                            //         image:
                            //             Provider.of<HomeFeedResponseProvider>(
                            //                             context)
                            //                         .profileResponse
                            //                         .user
                            //                         .avatar ==
                            //                     null
                            //                 ? AssetImage(AppImages
                            //                     .default_profile_Pic)
                            //                 : NetworkImage(
                            //                     Provider.of<HomeFeedResponseProvider>(
                            //                             context)
                            //                         .profileResponse
                            //                         .user
                            //                         .avatar,
                            //                   ),
                            //         fit: BoxFit.cover),
                            //   ),
                            // ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // leading: GestureDetector(
                      //   onTap: () {
                      //     // Navigator.pushNamed(
                      //     //         context, AppRoutes.editProfileRouteName)
                      //     //     .then((value) => onCallBack);
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleUserRegistrationScreen(true))).then(onCallBack);
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.only(left: 10, top: 10),
                      //     child: Container(
                      //       child: Image.asset(AppImages.ic_edit_filled),
                      //     ),
                      //   ),
                      // ),
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
                          // GlobalView().sizedBoxView(25),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 20),
                          //   child: GlobalView().textViewWithCenterAlign(
                          //       Provider.of<HomeFeedResponseProvider>(context)
                          //                   .profileResponse
                          //                   .user
                          //                   .username ==
                          //               null
                          //           ? "Test User"
                          //           : Provider.of<HomeFeedResponseProvider>(
                          //                   context)
                          //               .profileResponse
                          //               .user
                          //               .username,
                          //       AppTextStyle.inter_font_family,
                          //       AppTextStyle.bold_font_weight,
                          //       BaseColor.black_color,
                          //       20),
                          // ),
                          // GlobalView().sizedBoxView(15),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 20),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Container(
                          //           child: Column(
                          //             children: [
                          //               GlobalView().textViewWithCenterAlign(
                          //                   "325",
                          //                   AppTextStyle.interFontFamily,
                          //                   AppTextStyle.boldFontWeight,
                          //                   BaseColor.blackColor,
                          //                   20),
                          //               GlobalView().textViewWithCenterAlign(
                          //                   AppMessages.businessFriendsSubTitle,
                          //                   AppTextStyle.interFontFamily,
                          //                   AppTextStyle.mediumFontWeight,
                          //                   BaseColor.selectedTabColor,
                          //                   12),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Container(
                          //           child: Column(
                          //             children: [
                          //               GlobalView().textViewWithCenterAlign(
                          //                   "84",
                          //                   AppTextStyle.interFontFamily,
                          //                   AppTextStyle.boldFontWeight,
                          //                   BaseColor.blackColor,
                          //                   20),
                          //               GlobalView().textViewWithCenterAlign(
                          //                   AppMessages.friendsTitle,
                          //                   AppTextStyle.interFontFamily,
                          //                   AppTextStyle.mediumFontWeight,
                          //                   BaseColor.selectedTabColor,
                          //                   12),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          GlobalView().sizedBoxView(10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: BaseColor.selected_tab_color,
                            ),
                          ),
                          GlobalView().sizedBoxView(14),
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
                                              profileResponse: user.profileResponse,
                                              businessUserProfileResponse: null,
                                              userType: 1,
                                            )));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                      child: GlobalView().textViewWithStartAlign(AppMessages.account_settings_title, AppTextStyle.inter_font_family,
                                          AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 14)),
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
                          GlobalView().sizedBoxView(14),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: BaseColor.selected_tab_color,
                            ),
                          ),
                          Column(
                            children: [
                              GlobalView().sizedBoxView(15),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.changePasscode);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GlobalView().textViewWithStartAlign(AppMessages.changePasscodeTitle, AppTextStyle.inter_font_family,
                                            AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 14),
                                      ),
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
                            ],
                          ),

                          Visibility(
                            visible: false,
                            child: Column(
                              children: [
                                GlobalView().sizedBoxView(15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.resetPassword);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GlobalView().textViewWithStartAlign(AppMessages.reset_password_title, AppTextStyle.inter_font_family,
                                              AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 14),
                                        ),
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
                              ],
                            ),
                          ),
                          // Divider(
                          //   color: BaseColor.selectedTabColor,
                          // ),
                          GlobalView().sizedBoxView(20),
                          Visibility(
                              visible: user.profileResponse != null &&
                                      user.profileResponse!.user != null &&
                                      user.profileResponse!.user!.feed != null &&
                                      user.profileResponse!.user!.feed!.isNotEmpty
                                  ? true
                                  : false,
                              child: myCheckInsView(user)),
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
                )
              : Container(
                  // color: BaseColor.loader_bg_color,
                  child: GlobalView().loaderView(),
                );
        }),
      ],
    );
    // });
  }

  Widget myCheckInsView(
    HomeFeedResponseProvider provider,
  ) =>
      Consumer<HomeFeedResponseProvider>(builder: (_, profile, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GlobalView().textViewWithStartAlign(
                            AppMessages.my_checkins, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                        GlobalView().textViewWithStartAlign(
                            // user.profileResponse.user.totalFeed
                            //             .toString() !=
                            //         null &&  user.profileResponse.user.totalFeed!=0
                            //     ? " (" +
                            //         user.profileResponse.user.totalFeed
                            //             .toString() +
                            //         ")"
                            //     : "0",
                            provider.profileResponse!.user!.totalFeeds == null
                                ? " (" + "0" + ")"
                                : " (" + provider.profileResponse!.user!.totalFeeds.toString() + ")",
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
                      // Navigator.pushNamed(
                      //     context, AppRoutes.my_all_check_ins_route_name);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyAllCheckInsScreen())).then(onCallBack);
                    },
                    child: Container(
                      child: GlobalView().textViewWithStartAlign(AppMessages.see_all_text, AppTextStyle.inter_font_family,
                          AppTextStyle.medium_font_weight, BaseColor.forgot_pass_txt_color, 12),
                    ),
                  ),
                ],
              ),
            ),
            GlobalView().sizedBoxView(15),
            provider.listFeedInfo.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CheckInsItemView(
                        verifiedUserResponse: provider.profileResponse!.user,
                        feedResponse: provider.listFeedInfo[0],
                        isVisibleDeleteIcon: true,
                        isVisibleLikePanel: true,
                        onClickDelete: () {
                          print("listFeedInfo[0] JSON-> ${provider.listFeedInfo[0].toJson()}");
                          provider.deleteMycheckIns(context, provider.listFeedInfo[0].id, 0, "profile");
                        }),
                  )
                : SizedBox(),
            //  // ),
          ],
        );
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
                          AppMessages.my_friends, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                      GlobalView().textViewWithStartAlign(
                          " (" + 84.toString() + ")", AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.count_color, 12),
                    ],
                  ),
                ),
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.see_all_text, AppTextStyle.inter_font_family, AppTextStyle.medium_font_weight, BaseColor.forgot_pass_txt_color, 12),
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
                                  "John Doe", AppTextStyle.inter_font_family, AppTextStyle.medium_font_weight, BaseColor.black_color, 11)
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
                          AppMessages.my_business_friends, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                      GlobalView().textViewWithStartAlign(
                          " (" + 84.toString() + ")", AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.count_color, 12),
                    ],
                  ),
                ),
                Container(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.see_all_text, AppTextStyle.inter_font_family, AppTextStyle.medium_font_weight, BaseColor.forgot_pass_txt_color, 12),
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
                              "ChoxBlast \n Cafe", AppTextStyle.inter_font_family, AppTextStyle.medium_font_weight, BaseColor.black_color, 11)
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

  Widget mediaView() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GlobalView().textViewWithStartAlign(
                      AppMessages.media_text, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.media_route_name);
                  },
                  child: Container(
                    child: GlobalView().textViewWithStartAlign(AppMessages.see_all_text, AppTextStyle.inter_font_family,
                        AppTextStyle.medium_font_weight, BaseColor.forgot_pass_txt_color, 12),
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
                  padding: EdgeInsets.only(top: 7, left: 10, right: 10, bottom: 7),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.95, mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
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



  // Card(
  //                 elevation: 2,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 10),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Padding(
  //                         // padding: EdgeInsets.symmetric(horizontal: 10),
  //                         padding: EdgeInsets.only(right: 10),
  //                         child: Row(
  //                           children: [
  //                             // Container(
  //                             //   height: 32,
  //                             //   width: 32,
  //                             //   decoration: BoxDecoration(
  //                             //     shape: BoxShape.circle,
  //                             //     color: Colors.grey,
  //                             //     image: DecorationImage(
  //                             //         image: user.profileResponse.user
  //                             //                     .avatar !=
  //                             //                 ""
  //                             //             ? NetworkImage(user
  //                             //                 .profileResponse
  //                             //                 .user
  //                             //                 .avatar)
  //                             //             : AssetImage(AppImages
  //                             //                 .default_profile_Pic),
  //                             //         fit: BoxFit.cover),
  //                             //   ),
  //                             // ),
  //                             Expanded(
  //                               child: Padding(
  //                                 padding: EdgeInsets.symmetric(horizontal: 10),
  //                                 child: Container(
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.start,
  //                                     children: [
  //                                       GlobalView().textViewWithStartAlign(
  //                                           user.profileResponse.user
  //                                                           .firstName ==
  //                                                       null &&
  //                                                   user.profileResponse.user
  //                                                           .lastName ==
  //                                                       null
  //                                               ? "John Doe"
  //                                               : user.profileResponse.user
  //                                                       .firstName +
  //                                                   " " +
  //                                                   user.profileResponse.user
  //                                                       .lastName,
  //                                           AppTextStyle.metropolis_font_family,
  //                                           AppTextStyle.semi_bold_font_weight,
  //                                           BaseColor.black_color,
  //                                           12),
  //                                       GlobalView().textViewWithStartAlign(
  //                                           "15 min ago",
  //                                           AppTextStyle.metropolis_font_family,
  //                                           AppTextStyle.medium_font_weight,
  //                                           BaseColor.black_color,
  //                                           10),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             Container(
  //                                 height: 24,
  //                                 width: 24,
  //                                 child: GestureDetector(
  //                                   onTap: () {
  //                                     // user.changeIsVisibleValue();
  //                                   },
  //                                   child:
  //                                       //  Text(
  //                                       //   user.isVisible.toString(),
  //                                       // ),
  //                                       Image.asset(AppImages.ic_menu),
  //                                 ))
  //                           ],
  //                         ),
  //                       ),
  //                       GlobalView().sizedBoxView(10),
  //                       Divider(
  //                         color: BaseColor.home_divider_color,
  //                         height: 2,
  //                         thickness: 1,
  //                       ),
  //                       Padding(
  //                         padding:
  //                             EdgeInsets.only(top: 10, left: 10, right: 10),
  //                         child: GlobalView().textViewWithStartAlign(
  //                             user.profileResponse.user != null &&
  //                                     user.profileResponse.user.feed != null &&
  //                                     user.profileResponse.user.feed[0].category
  //                                             .name !=
  //                                         null
  //                                 ? user.profileResponse.user.feed[0].category
  //                                     .name
  //                                 : "Cafe",
  //                             AppTextStyle.metropolis_font_family,
  //                             AppTextStyle.semi_bold_font_weight,
  //                             BaseColor.forgot_pass_txt_color,
  //                             10),
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 10),
  //                         child: GlobalView().textViewWithStartAlign(
  //                             user.profileResponse.user != null &&
  //                                     user.profileResponse.user.feed != null &&
  //                                     user.profileResponse.user.feed[0]
  //                                             .businessUser.businessName !=
  //                                         null
  //                                 ? user.profileResponse.user.feed[0]
  //                                     .businessUser.businessName
  //                                 : "ChoxBlast Cafe",
  //                             AppTextStyle.metropolis_font_family,
  //                             AppTextStyle.bold_font_weight,
  //                             BaseColor.black_color,
  //                             16),
  //                       ),
  //                       GlobalView().sizedBoxView(5),
  //                       Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 10),
  //                         child: Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(top: 0),
  //                               child: Container(
  //                                 height: 16,
  //                                 width: 16,
  //                                 child: Image.asset(
  //                                   AppImages.ic_location_black,
  //                                   color: Colors.grey,
  //                                 ),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Container(
  //                                 padding: EdgeInsets.only(left: 7, top: 2),
  //                                 alignment: Alignment.topLeft,
  //                                 child: GlobalView().textViewWithStartAlign(
  //                                     user.profileResponse.user != null &&
  //                                             user.profileResponse.user.feed !=
  //                                                 null &&
  //                                             user
  //                                                     .profileResponse
  //                                                     .user
  //                                                     .feed[0]
  //                                                     .businessUser
  //                                                     .businessAddress !=
  //                                                 null
  //                                         ? user.profileResponse.user.feed[0]
  //                                             .businessUser.businessAddress
  //                                         : "Abix Street, Main Road, San Fransisco, California",
  //                                     // "Abix Street, Main Road, San Fransisco, California Abix Street, Main Road, San Fransisco, California",
  //                                     AppTextStyle.metropolis_font_family,
  //                                     AppTextStyle.medium_font_weight,
  //                                     BaseColor.black_color.withOpacity(0.6),
  //                                     12),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                       GlobalView().sizedBoxView(5),
  //                       Visibility(
  //                         visible:
  //                             user.profileResponse.user.feed[0].description ==
  //                                     ""
  //                                 ? false
  //                                 : true,
  //                         child: Padding(
  //                           padding: EdgeInsets.only(left: 10, right: 10),
  //                           child: Container(
  //                             alignment: Alignment.centerLeft,
  //                             child: GlobalView().textViewWithStartAlign(
  //                                 user.profileResponse.user != null &&
  //                                         user.profileResponse.user.feed !=
  //                                             null &&
  //                                         user.profileResponse.user.feed[0]
  //                                                 .description !=
  //                                             null
  //                                     ? user.profileResponse.user.feed[0]
  //                                         .description
  //                                     : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut…",
  //                                 AppTextStyle.inter_font_family,
  //                                 AppTextStyle.medium_font_weight,
  //                                 BaseColor.black_color,
  //                                 12),
  //                           ),
  //                         ),
  //                       ),
  //                       // Padding(
  //                       //   padding: EdgeInsets.only(left: 10, right: 10),
  //                       //   child: Container(
  //                       //       alignment: Alignment.centerLeft,
  //                       //       child: Text(
  //                       //         "See more",
  //                       //         style: TextStyle(
  //                       //           decoration: TextDecoration.underline,
  //                       //           fontFamily: AppTextStyle.interFontFamily,
  //                       //           fontWeight: FontWeight.w600,
  //                       //           fontSize: 12,
  //                       //           color: BaseColor.blackColor.withOpacity(0.5),
  //                       //         ),
  //                       //       )),
  //                       // ),
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 16, right: 16, top: 5),
  //                         child: Container(
  //                           child: Row(
  //                             children: [
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   print(
  //                                       "LIKED>> ${user.profileResponse.user.feed[0].isLiked}");
  //                                   print(
  //                                       "TOTAL LIKES>> ${user.profileResponse.user.feed[0].totalLikes}");
  //                                   print(
  //                                       "User Response===-->> ${user.profileResponse.user.feed[0].toJson()}");

  //                                   profile.checkInsLike(
  //                                       context,
  //                                       user.profileResponse.user.feed[0].id
  //                                           ,
  //                                       user.profileResponse.user.feed[0]
  //                                                   .isLiked ==
  //                                               1
  //                                           ? 0
  //                                           : 1,
  //                                       0);
  //                                   print(
  //                                       "LIKED=-=-=>> ${user.profileResponse.user.feed[0].isLiked}");
  //                                 },
  //                                 child: Image.asset(
  //                                   user.profileResponse.user.feed[0].isLiked ==
  //                                           1
  //                                       ? AppImages.thumbs_up_filled
  //                                       : AppImages.thumbs_up,
  //                                   height: 24,
  //                                   width: 24,
  //                                 ),
  //                               ),
  //                               Expanded(
  //                                 child: Container(
  //                                   margin: EdgeInsets.only(left: 10),
  //                                   child: GlobalView().textViewWithStartAlign(
  //                                       user.profileResponse.user != null &&
  //                                               user.profileResponse.user
  //                                                       .feed !=
  //                                                   null &&
  //                                               user.profileResponse.user
  //                                                       .feed[0].totalLikes
  //                                                       .toString() ==
  //                                                   null
  //                                           ? "0"
  //                                           : user.profileResponse.user.feed[0]
  //                                               .totalLikes
  //                                               .toString(),
  //                                       AppTextStyle.metropolis_font_family,
  //                                       AppTextStyle.medium_font_weight,
  //                                       BaseColor.black_color.withOpacity(0.5),
  //                                       12),
  //                                 ),
  //                               ),
  //                               // SizedBox(
  //                               //   width: 30,
  //                               // ),
  //                               // GestureDetector(
  //                               //   onTap: () {
  //                               //     print(
  //                               //         "DIS LIKED>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                               //     print(
  //                               //         "TOTAL DIS LIKES>> ${user.profileResponse.user.feed[0].totalDislikes}");
  //                               //     // home.feed_detail_like_dislike(
  //                               //     //   context,
  //                               //     //   user.profileResponse.user.feed[0].id
  //                               //     //       .toString(),
  //                               //     // "0",
  //                               //     // user.profileResponse.user.feed[0]
  //                               //     //             .isDisliked ==
  //                               //     //         1
  //                               //     //     ? "0"
  //                               //     //     : "1",
  //                               //     //   // user.profileResponse.user.feed[0],
  //                               //     //   "dislike",
  //                               //     // );
  //                               //     // profile.checkIns_like_dislike(
  //                               //     //     context,
  //                               //     //     user.profileResponse.user.feed[0]
  //                               //     //         .id
  //                               //     //         .toString(),
  //                               //     //     "dislike",
  //                               //     //     "0",
  //                               //     //     user.profileResponse.user.feed[0]
  //                               //     //                 .isDisliked ==
  //                               //     //             1
  //                               //     //         ? "0"
  //                               //     //         : "1",
  //                               //     //     0);
  //                               //     print(
  //                               //         "DIS LIKED=-=-=>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                               //   },
  //                               //   child: Image.asset(
  //                               //     user.profileResponse.user.feed[0]
  //                               //                 .isDisliked ==
  //                               //             1
  //                               //         ? AppImages.thumbs_down_filled
  //                               //         : AppImages.thumbs_down,
  //                               //     height: 24,
  //                               //     width: 24,
  //                               //   ),
  //                               // ),
  //                               // Expanded(
  //                               //   child: Container(
  //                               //     margin: EdgeInsets.only(left: 10),
  //                               //     child: GlobalView()
  //                               //         .textViewWithStartAlign(
  //                               //             user.profileResponse.user ==
  //                               //                         null &&
  //                               //                     user.profileResponse
  //                               //                             .user.feed ==
  //                               //                         null &&
  //                               //                     user
  //                               //                             .profileResponse
  //                               //                             .user
  //                               //                             .feed[0]
  //                               //                             .totalDislikes
  //                               //                             .toString() ==
  //                               //                         null
  //                               //                 ? "0"
  //                               //                 : user
  //                               //                     .profileResponse
  //                               //                     .user
  //                               //                     .feed[0]
  //                               //                     .totalDislikes
  //                               //                     .toString(),
  //                               //             AppTextStyle
  //                               //                 .metropolisFontFamily,
  //                               //             AppTextStyle.mediumFontWeight,
  //                               //             BaseColor.blackColor
  //                               //                 .withOpacity(0.5),
  //                               //             12),
  //                               //   ),
  //                               // ),
  //                               SizedBox(
  //                                 width: 30,
  //                               ),
  //                               Image.asset(
  //                                 AppImages.ic_comments,
  //                                 height: 24,
  //                                 width: 24,
  //                               ),
  //                               Expanded(
  //                                 child: Container(
  //                                   margin: EdgeInsets.only(left: 10),
  //                                   child: GlobalView().textViewWithStartAlign(
  //                                       user.profileResponse.user != null &&
  //                                               user.profileResponse.user
  //                                                       .feed !=
  //                                                   null &&
  //                                               user.profileResponse.user
  //                                                       .feed[0].totalComments
  //                                                       .toString() !=
  //                                                   null
  //                                           ? user.profileResponse.user.feed[0]
  //                                               .totalComments
  //                                               .toString()
  //                                           : "0",
  //                                       AppTextStyle.metropolis_font_family,
  //                                       AppTextStyle.medium_font_weight,
  //                                       BaseColor.black_color.withOpacity(0.5),
  //                                       12),
  //                                 ),
  //                               ),
  //                               SizedBox(
  //                                 width: 30,
  //                               ),
  //                               // Image.asset(
  //                               //   AppImages.ic_share,
  //                               //   height: 24,
  //                               //   width: 24,
  //                               // ),
  //                               // Expanded(
  //                               //   child: Container(
  //                               //  margin: EdgeInsets.only(left: 10),
  //                               //     child: GlobalView()
  //                               //         .textViewWithStartAlign(
  //                               //             user.profileResponse.user !=
  //                               //                         null &&
  //                               //                     user.profileResponse
  //                               //                             .user.feed !=
  //                               //                         null &&
  //                               //                     user
  //                               //                             .profileResponse
  //                               //                             .user
  //                               //                             .feed[0]
  //                               //                             .totalShares
  //                               //                             .toString() !=
  //                               //                         null
  //                               //                 ? user
  //                               //                     .profileResponse
  //                               //                     .user
  //                               //                     .feed[0]
  //                               //                     .totalShares
  //                               //                     .toString()
  //                               //                 : "0",
  //                               //             AppTextStyle
  //                               //                 .metropolisFontFamily,
  //                               //             AppTextStyle.mediumFontWeight,
  //                               //             BaseColor.blackColor
  //                               //                 .withOpacity(0.5),
  //                               //             12),
  //                               //   ),
  //                               // ),
  //                               GestureDetector(
  //                                 onTap: () {
  //                                   print("delete called");
  //                                   Provider.of<ProfileProvider>(context,
  //                                           listen: false)
  //                                       .deleteMycheckIns(
  //                                           context,
  //                                           user.profileResponse.user.feed[0]
  //                                               .id);
  //                                 },
  //                                 child: Image.asset(
  //                                   AppImages.icon_finder_delete,
  //                                   height: 24,
  //                                   width: 24,
  //                                   color: BaseColor.icon_color,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )),
           
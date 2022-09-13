import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/home_feed_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/check_ins_item_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';

class MyAllCheckInsPage extends StatefulWidget {
  const MyAllCheckInsPage({Key? key}) : super(key: key);

  @override
  _MyAllCheckInsPageState createState() => _MyAllCheckInsPageState();
}

class _MyAllCheckInsPageState extends State<MyAllCheckInsPage> {
  ScrollController scrollController = new ScrollController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .listFeedInfo
          .clear();
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .getMyCheckInsList(context, page);
      // Provider.of<CategoriesListProvider>(context, listen: false)
      //     .getHomeCategories();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreMyCheckInsData();
      }
    });
  }

  void getMoreMyCheckInsData() {
    HomeFeedResponse homeFeedResponse =
        Provider.of<HomeFeedResponseProvider>(context, listen: false)
            .homeFeedResponse!;
    print("nextPageUrl-->> ${homeFeedResponse.data!.nextPageUrl}");
    if (homeFeedResponse != null) {
      if (homeFeedResponse.data!.nextPageUrl != null) {
        page++;
        Provider.of<HomeFeedResponseProvider>(context, listen: false)
            .getMyCheckInsList(context, page);
        // Provider.of<HomeFeedResponseProvider>(context, listen: false)
        //     .listFeedInfo
        //     .addAll(homeFeedResponse.data.data);
        print("page-->> $page");
      }
    } else {
      GlobalView()
          .showToast(AppMessages.no_feeds_available_with_filters_message);
    }
  }

  FutureOr onCallBack(var value) {
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .listFeedInfo
        .clear();
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .getMyCheckInsList(context, page);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.home_bg_color,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BaseColor.home_bg_color,
          body: Consumer<HomeFeedResponseProvider>(
              builder: (_, myCheckIns, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Center(
                        child: GlobalView().textViewWithCenterAlign(
                            AppMessages.my_checkins_title,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.semi_bold_font_weight,
                            BaseColor.black_color,
                            18),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: listCheckInsView(myCheckIns),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
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
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget listCheckInsView(HomeFeedResponseProvider myCheckIns) => Stack(
        children: [
          Container(
            child: myCheckIns.listFeedInfo.isNotEmpty
                ? ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: myCheckIns.listFeedInfo.length,
                    controller: scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, itemIndex) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, AppRoutes.checkInDetailsRouteName);
                            myCheckIns.setFeedResponse(itemIndex);
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BusinessDetailsScreen(businessId: myCheckIns.listFeedInfo[itemIndex].businessUserId,)))
                                // .then(onCallBack)
                                ;
                          },
                          child: CheckInsItemView(
                            verifiedUserResponse: null,
                            feedResponse: myCheckIns.listFeedInfo[itemIndex],
                            isVisibleDeleteIcon: true,
                            isVisibleLikePanel: true,
                            onClickDelete: () {
                              myCheckIns.deleteMycheckIns(
                                  context,
                                  myCheckIns.listFeedInfo[itemIndex].id,
                                  itemIndex,
                                  "");
                            },
                          ),
                        ),
                      );
                    })
                : Center(
                    child: GlobalView().textViewWithCenterAlign(
                        AppMessages.no_feeds_available_message,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.semi_bold_font_weight,
                        BaseColor.black_color,
                        18),
                  ),
          ),
          Positioned(
            child: Visibility(
              visible:
                  Provider.of<HomeFeedResponseProvider>(context, listen: false)
                      .isLoading,
              child: Container(
                color: BaseColor.home_bg_color,
                child: GlobalView().loaderView(),
              ),
            ),
          ),
        ],
      );
}

// Widget listCheckInsView(HomeFeedResponseProvider myCheckInsProvider) =>
  //  Stack(
  //       children: [
  //         Container(
  //           child: myCheckInsProvider.listFeedInfo.isNotEmpty
  //               ? ListView.builder(
  //                   physics: AlwaysScrollableScrollPhysics(),
  //                   itemCount: myCheckInsProvider.listFeedInfo.length,
  //                   controller: scrollController,
  //                   shrinkWrap: true,
  //                   itemBuilder: (homeListContext, itemIndex) {
  //                     return Padding(
  //                       padding: EdgeInsets.only(bottom: 8),
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           // Navigator.pushNamed(
  //                           //     context, AppRoutes.checkInDetailsRouteName);
  //                           myCheckInsProvider.setFeedResponse(itemIndex);
  //                           Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (_) => CheckInDetailsScreen()))
  //                               .then(onCallBack);
  //                         },
  //                         child: Card(
  //                             elevation: 2,
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(8)),
  //                             child: Padding(
  //                               padding: EdgeInsets.symmetric(vertical: 10),
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   Padding(
  //                                     // padding: EdgeInsets.symmetric(horizontal: 10),
  //                                     padding: EdgeInsets.only(right: 10),
  //                                     child: Row(
  //                                       children: [
  //                                         // Container(
  //                                         //   height: 32,
  //                                         //   width: 32,
  //                                         //   decoration: BoxDecoration(
  //                                         //     shape: BoxShape.circle,
  //                                         //     color: Colors.grey,
  //                                         //     image: DecorationImage(
  //                                         //         image: myCheckInsProvider
  //                                         //                     .listFeedInfo[
  //                                         //                         itemIndex]
  //                                         //                     .user
  //                                         //                     .avatar !=
  //                                         //                 null
  //                                         //             ? NetworkImage(
  //                                         //                 myCheckInsProvider
  //                                         //                     .listFeedInfo[
  //                                         //                         itemIndex]
  //                                         //                     .user
  //                                         //                     .avatar)
  //                                         //             : AssetImage(AppImages
  //                                         //                 .default_profile_Pic),
  //                                         //         fit: BoxFit.cover),
  //                                         //   ),
  //                                         // ),
  //                                         Expanded(
  //                                           child: Padding(
  //                                             padding: EdgeInsets.symmetric(
  //                                                 horizontal: 10),
  //                                             child: Container(
  //                                               child: Column(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.start,
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.start,
  //                                                 children: [
  //                                                   GlobalView().textViewWithStartAlign(
  //                                                       myCheckInsProvider
  //                                                                       .listFeedInfo[
  //                                                                           itemIndex]
  //                                                                       .user
  //                                                                       .firstName ==
  //                                                                   null &&
  //                                                               myCheckInsProvider
  //                                                                       .listFeedInfo[
  //                                                                           itemIndex]
  //                                                                       .user
  //                                                                       .lastName ==
  //                                                                   null
  //                                                           ? "John Doe"
  //                                                           : myCheckInsProvider
  //                                                                   .listFeedInfo[
  //                                                                       itemIndex]
  //                                                                   .user
  //                                                                   .firstName +
  //                                                               " " +
  //                                                               myCheckInsProvider
  //                                                                   .listFeedInfo[
  //                                                                       itemIndex]
  //                                                                   .user
  //                                                                   .lastName,
  //                                                       AppTextStyle
  //                                                           .metropolis_font_family,
  //                                                       AppTextStyle
  //                                                           .semi_bold_font_weight,
  //                                                       BaseColor.black_color,
  //                                                       12),
  //                                                   GlobalView()
  //                                                       .textViewWithStartAlign(
  //                                                           // "15 min ago",
  //                                                           TimeAgoUtils().convertToAgo(
  //                                                               myCheckInsProvider
  //                                                                   .listFeedInfo[
  //                                                                       itemIndex]
  //                                                                   .createdAt),
  //                                                           AppTextStyle
  //                                                               .metropolis_font_family,
  //                                                           AppTextStyle
  //                                                               .medium_font_weight,
  //                                                           BaseColor
  //                                                               .black_color,
  //                                                           10),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Container(
  //                                           height: 24,
  //                                           width: 24,
  //                                           child:
  //                                               Image.asset(AppImages.ic_menu),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   GlobalView().sizedBoxView(10),
  //                                   Divider(
  //                                     color: BaseColor.home_divider_color,
  //                                     height: 2,
  //                                     thickness: 1,
  //                                   ),
  //                                   Padding(
  //                                     padding: EdgeInsets.only(
  //                                         top: 10, left: 10, right: 10),
  //                                     child: GlobalView()
  //                                         .textViewWithStartAlign(
  //                                             myCheckInsProvider
  //                                                         .listFeedInfo[
  //                                                             itemIndex]
  //                                                         .category
  //                                                         .name ==
  //                                                     null
  //                                                 ? "Cafe"
  //                                                 : myCheckInsProvider
  //                                                     .listFeedInfo[itemIndex]
  //                                                     .category
  //                                                     .name,
  //                                             AppTextStyle
  //                                                 .metropolis_font_family,
  //                                             AppTextStyle
  //                                                 .semi_bold_font_weight,
  //                                             BaseColor.forgot_pass_txt_color,
  //                                             10),
  //                                   ),
  //                                   Padding(
  //                                     padding:
  //                                         EdgeInsets.symmetric(horizontal: 10),
  //                                     child: GlobalView()
  //                                         .textViewWithStartAlign(
  //                                             myCheckInsProvider
  //                                                         .listFeedInfo[
  //                                                             itemIndex]
  //                                                         .businessUser
  //                                                         .businessName ==
  //                                                     null
  //                                                 ? "ChoxBlast Cafe"
  //                                                 : myCheckInsProvider
  //                                                     .listFeedInfo[itemIndex]
  //                                                     .businessUser
  //                                                     .businessName,
  //                                             AppTextStyle
  //                                                 .metropolis_font_family,
  //                                             AppTextStyle.bold_font_weight,
  //                                             BaseColor.black_color,
  //                                             16),
  //                                   ),
  //                                   GlobalView().sizedBoxView(5),
  //                                   Padding(
  //                                     padding:
  //                                         EdgeInsets.symmetric(horizontal: 10),
  //                                     child: Row(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.start,
  //                                       children: [
  //                                         Container(
  //                                           height: 16,
  //                                           width: 16,
  //                                           child: Image.asset(
  //                                             AppImages.ic_location_black,
  //                                             color: Colors.grey,
  //                                           ),
  //                                         ),
  //                                         Expanded(
  //                                           child: Container(
  //                                             padding: EdgeInsets.only(
  //                                                 left: 7, top: 2),
  //                                             alignment: Alignment.centerLeft,
  //                                             child: GlobalView().textViewWithStartAlign(
  //                                                 myCheckInsProvider
  //                                                             .listFeedInfo[
  //                                                                 itemIndex]
  //                                                             .businessUser
  //                                                             .businessAddress ==
  //                                                         null
  //                                                     ? "Abix Street, Main Road, San Fransisco, California"
  //                                                     : myCheckInsProvider
  //                                                         .listFeedInfo[
  //                                                             itemIndex]
  //                                                         .businessUser
  //                                                         .businessAddress,
  //                                                 AppTextStyle
  //                                                     .metropolis_font_family,
  //                                                 AppTextStyle
  //                                                     .medium_font_weight,
  //                                                 BaseColor.black_color
  //                                                     .withOpacity(0.6),
  //                                                 12),
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   GlobalView().sizedBoxView(5),
  //                                   Visibility(
  //                                     visible: myCheckInsProvider
  //                                                 .listFeedInfo[itemIndex]
  //                                                 .description ==
  //                                             ""
  //                                         ? false
  //                                         : true,
  //                                     child: Padding(
  //                                       padding: EdgeInsets.only(
  //                                           left: 10, right: 10),
  //                                       child: Container(
  //                                         alignment: Alignment.centerLeft,
  //                                         child: GlobalView()
  //                                             .textViewWithStartAlign(
  //                                                 myCheckInsProvider
  //                                                             .listFeedInfo[
  //                                                                 itemIndex]
  //                                                             .description ==
  //                                                         null
  //                                                     ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
  //                                                     : myCheckInsProvider
  //                                                         .listFeedInfo[
  //                                                             itemIndex]
  //                                                         .description,
  //                                                 AppTextStyle
  //                                                     .inter_font_family,
  //                                                 AppTextStyle
  //                                                     .medium_font_weight,
  //                                                 BaseColor.black_color,
  //                                                 12),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // Padding(
  //                                   //   padding: EdgeInsets.only(left: 10, right: 10),
  //                                   //   child: Container(
  //                                   //       alignment: Alignment.centerLeft,
  //                                   //       child: Text(
  //                                   //         "See more",
  //                                   //         style: TextStyle(
  //                                   //           decoration: TextDecoration.underline,
  //                                   //           fontFamily: AppTextStyle.interFontFamily,
  //                                   //           fontWeight: FontWeight.w600,
  //                                   //           fontSize: 12,
  //                                   //           color:
  //                                   //               BaseColor.blackColor.withOpacity(0.5),
  //                                   //         ),
  //                                   //       )),
  //                                   // ),
  //                                   Padding(
  //                                     padding: EdgeInsets.only(
  //                                         left: 16, right: 16, top: 5),
  //                                     child: Container(
  //                                       child: Row(
  //                                         children: [
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               myCheckInsProvider.homeFeedLike(
  //                                                   context,
  //                                                   myCheckInsProvider
  //                                                       .listFeedInfo[itemIndex]
  //                                                       .id,
  //                                                   myCheckInsProvider
  //                                                               .listFeedInfo[
  //                                                                   itemIndex]
  //                                                               .isLiked ==
  //                                                           1
  //                                                       ? 0
  //                                                       : 1,
  //                                                   itemIndex);
  //                                             },
  //                                             child: Image.asset(
  //                                               myCheckInsProvider
  //                                                           .listFeedInfo[
  //                                                               itemIndex]
  //                                                           .isLiked ==
  //                                                       1
  //                                                   ? AppImages.thumbs_up_filled
  //                                                   : AppImages.thumbs_up,
  //                                               height: 24,
  //                                               width: 24,
  //                                             ),
  //                                           ),
  //                                           Expanded(
  //                                             child: Container(
  //                                               margin:
  //                                                   EdgeInsets.only(left: 10),
  //                                               child: GlobalView()
  //                                                   .textViewWithStartAlign(
  //                                                       myCheckInsProvider
  //                                                                   .listFeedInfo[
  //                                                                       itemIndex]
  //                                                                   .totalLikes
  //                                                                   .toString() ==
  //                                                               null
  //                                                           ? "0"
  //                                                           : myCheckInsProvider
  //                                                               .listFeedInfo[
  //                                                                   itemIndex]
  //                                                               .totalLikes
  //                                                               .toString(),
  //                                                       AppTextStyle
  //                                                           .metropolis_font_family,
  //                                                       AppTextStyle
  //                                                           .medium_font_weight,
  //                                                       BaseColor.black_color
  //                                                           .withOpacity(0.5),
  //                                                       12),
  //                                             ),
  //                                           ),
  //                                           // SizedBox(
  //                                           //   width: 30,
  //                                           // ),
  //                                           // GestureDetector(
  //                                           //   // onTap: () {
  //                                           //   //   // homeFeed.changeDislikeValue(itemIndex);
  //                                           //   //   myCheckInsProvider
  //                                           //   //       .home_feed_like_dislike(
  //                                           //   //           context,
  //                                           //   //           myCheckInsProvider
  //                                           //   //               .listFeedInfo[itemIndex]
  //                                           //   //               .id
  //                                           //   //               .toString(),
  //                                           //   //           "dislike",
  //                                           //   //           "0",
  //                                           //   //           myCheckInsProvider
  //                                           //   //                       .listFeedInfo[
  //                                           //   //                           itemIndex]
  //                                           //   //                       .isDisliked ==
  //                                           //   //                   1
  //                                           //   //               ? "0"
  //                                           //   //               : "1",
  //                                           //   //           itemIndex);
  //                                           //   // },
  //                                           //   child: Image.asset(
  //                                           //     myCheckInsProvider
  //                                           //                 .listFeedInfo[itemIndex]
  //                                           //                 .isDisliked ==
  //                                           //             1
  //                                           //         ? AppImages.thumbs_down_filled
  //                                           //         : AppImages.thumbs_down,
  //                                           //     height: 24,
  //                                           //     width: 24,
  //                                           //   ),
  //                                           // ),
  //                                           // Expanded(
  //                                           //   child: Container(
  //                                           //     margin: EdgeInsets.only(left: 10),
  //                                           //     child: GlobalView()
  //                                           //         .textViewWithStartAlign(
  //                                           //             myCheckInsProvider
  //                                           //                         .listFeedInfo[
  //                                           //                             itemIndex]
  //                                           //                         .totalDislikes
  //                                           //                         .toString() ==
  //                                           //                     null
  //                                           //                 ? "0"
  //                                           //                 : myCheckInsProvider
  //                                           //                     .listFeedInfo[
  //                                           //                         itemIndex]
  //                                           //                     .totalDislikes
  //                                           //                     .toString(),
  //                                           //             AppTextStyle
  //                                           //                 .metropolisFontFamily,
  //                                           //             AppTextStyle
  //                                           //                 .mediumFontWeight,
  //                                           //             BaseColor.blackColor
  //                                           //                 .withOpacity(0.5),
  //                                           //             12),
  //                                           //   ),
  //                                           // ),
  //                                           SizedBox(
  //                                             width: 30,
  //                                           ),
  //                                           Image.asset(
  //                                             AppImages.ic_comments,
  //                                             height: 24,
  //                                             width: 24,
  //                                           ),
  //                                           Expanded(
  //                                             child: Container(
  //                                               margin:
  //                                                   EdgeInsets.only(left: 10),
  //                                               child: GlobalView().textViewWithStartAlign(
  //                                                   myCheckInsProvider
  //                                                               .listFeedInfo[
  //                                                                   itemIndex]
  //                                                               .totalComments
  //                                                               .toString() ==
  //                                                           null
  //                                                       ? "5.2k"
  //                                                       : myCheckInsProvider
  //                                                           .listFeedInfo[
  //                                                               itemIndex]
  //                                                           .totalComments
  //                                                           .toString(),
  //                                                   AppTextStyle
  //                                                       .metropolis_font_family,
  //                                                   AppTextStyle
  //                                                       .medium_font_weight,
  //                                                   BaseColor.black_color
  //                                                       .withOpacity(0.5),
  //                                                   12),
  //                                             ),
  //                                           ),
  //                                           SizedBox(
  //                                             width: 30,
  //                                           ),
  //                                           // Image.asset(
  //                                           //   AppImages.ic_share,
  //                                           //   height: 24,
  //                                           //   width: 24,
  //                                           // ),
  //                                           // Expanded(
  //                                           //   child: Container(
  //                                           //      margin: EdgeInsets.only(left: 10),
  //                                           //     child: GlobalView()
  //                                           //         .textViewWithStartAlign(
  //                                           //             myCheckInsProvider
  //                                           //                         .listFeedInfo[
  //                                           //                             itemIndex]
  //                                           //                         .totalShares
  //                                           //                         .toString() ==
  //                                           //                     null
  //                                           //                 ? "150"
  //                                           //                 : myCheckInsProvider
  //                                           //                     .listFeedInfo[
  //                                           //                         itemIndex]
  //                                           //                     .totalShares
  //                                           //                     .toString(),
  //                                           //             AppTextStyle
  //                                           //                 .metropolisFontFamily,
  //                                           //             AppTextStyle
  //                                           //                 .mediumFontWeight,
  //                                           //             BaseColor.blackColor
  //                                           //                 .withOpacity(0.5),
  //                                           //             12),
  //                                           //   ),
  //                                           // ),
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               print("delete called");
  //                                               myCheckInsProvider
  //                                                   .deleteMycheckIns(
  //                                                       context,
  //                                                       myCheckInsProvider
  //                                                           .listFeedInfo[
  //                                                               itemIndex]
  //                                                           .id,
  //                                                       itemIndex);
  //                                             },
  //                                             child: Image.asset(
  //                                               AppImages.icon_finder_delete,
  //                                               height: 24,
  //                                               width: 24,
  //                                               color: BaseColor.icon_color,
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             )),
  //                       ),
  //                     );
  //                   })
  //               : Center(
  //                   child: GlobalView().textViewWithCenterAlign(
  //                       AppMessages.no_feeds_available_message,
  //                       AppTextStyle.inter_font_family,
  //                       AppTextStyle.semi_bold_font_weight,
  //                       BaseColor.black_color,
  //                       18),
  //                 ),
  //         ),
  //         Positioned(
  //           child: Visibility(
  //             visible:
  //                 Provider.of<HomeFeedResponseProvider>(context, listen: false)
  //                     .isLoading,
  //             child: Container(
  //               color: BaseColor.home_bg_color,
  //               child: GlobalView().loaderView(),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );



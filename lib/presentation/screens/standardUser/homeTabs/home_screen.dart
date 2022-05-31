import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/global/home_list_data.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/global/view/category_view.dart';
import 'package:trendoapp/global/view/check_ins_item_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/header_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/connection/connection_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  FeedResponse feedResponse = new FeedResponse();
  // String selectedCategory = "All";
  // String categoryId = "0";
  // int page = 1;
  ScrollController scrollController = new ScrollController();
  double value = 40.0;
  AutoScrollController controller = new AutoScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("init Called");
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    HomeListData().initHome(context);
    print(
        "Connection Status ====---> ${Provider.of<ConnectionProvider>(context, listen: false).isInternetConnection}");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // scrollToIndex();
        final provider =
            Provider.of<HomeFeedResponseProvider>(context, listen: false);
        if (provider.homeFeedResponse.data.currentPage <
            provider.homeFeedResponse.data.lastPage) {
          provider.getHomeFeedList(
            context,
            Provider.of<CategoriesListProvider>(context, listen: false)
                .selectedCategoryResponse.id
                .toString(),
            StorageUtils.readStringValue(StorageUtils.keyLatitude),
            StorageUtils.readStringValue(StorageUtils.keyLongitude),
            Provider.of<FilterProvider>(context, listen: false).distanceRadius,
            Provider.of<FilterProvider>(context, listen: false)
                .selectedMetropolitanCityInfo,
          );
        } else {
          // GlobalView().showToast(AppMessages.no_more_data_text);
        }
        // getMoreHomeFeedData();
      }
    });
  }

  Future scrollToIndex() async {
    await controller.scrollToIndex(11,
        preferPosition: AutoScrollPosition.begin);
    // controller.highlight(5);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state=-=-=> $state");
    if (state == AppLifecycleState.resumed) {
      print("didChangeAppLifecycleState Called");
      HomeListData().initHome(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        "IS INTERNET->${Provider.of<ConnectionProvider>(context).isInternetConnection} ");
    print("BUILD CALLED");
    // Provider.of<HomeFeedResponseProvider>(context)
    //     .get_home_feed_list(context, "", "0");
    return SafeArea(
      child: Scaffold(
        backgroundColor: BaseColor.home_bg_color,
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, left: 16, right: 16, bottom: 0),
                    child: HeaderView(AppMessages.trend_text, "home"),
                  ),
                  GlobalView().sizedBoxView(15),
                  CategoryView("home"),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 20, left: 16, right: 16, bottom: 0),
                      child: listHomeView(),
                    ),
                  ),
                ],
              ),
              // : Provider<HomeFeedResponseProvider>(
              //     create: (_) => HomeFeedResponseProvider(),
              //     child: Container(
              //       color: BaseColor.home_bg_color,
              //       child: GlobalView().loaderView(),
              //     ),
              //   );
            ),
            Positioned(
              child: Visibility(
                visible:
                    Provider.of<HomeFeedResponseProvider>(context).isLoading,
                child: Container(
                  // color: BaseColor.loader_bg_color,
                  child: GlobalView().loaderView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listHomeView() {
    // print(
    //     "ISAVAILABLE DATA-> ${Provider.of<HomeFeedResponseProvider>(context).isAvailableHomeData}");
    return
        // Visibility(
        //   visible:
        //       Provider.of<HomeFeedResponseProvider>(context).isAvailableHomeData,
        //   child:
        Consumer<HomeFeedResponseProvider>(
      builder: (_, homeFeedResponseProvider, child) {
        if (homeFeedResponseProvider.listFeedInfo.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              print(
                  "RADIUS->${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
              // Provider.of<FilterProvider>(context, listen: false).setDistanceRadius("5");

              Provider.of<HomeFeedResponseProvider>(context, listen: false)
                  .listFeedInfo
                  .clear();
              Provider.of<HomeFeedResponseProvider>(context, listen: false)
                  .homeFeedResponse = null;
              Provider.of<HomeFeedResponseProvider>(context, listen: false)
                  .getHomeFeedList(
                context,
                Provider.of<CategoriesListProvider>(context, listen: false)
                    .selectedCategoryResponse
                    .id
                    .toString(),
                StorageUtils.readStringValue(StorageUtils.keyLatitude),
                StorageUtils.readStringValue(StorageUtils.keyLongitude),
                Provider.of<FilterProvider>(context, listen: false)
                    .distanceRadius,
                Provider.of<FilterProvider>(context, listen: false)
                    .selectedMetropolitanCityInfo,
              );
            },
            color: BaseColor.btn_gradient_end_color1,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: homeFeedResponseProvider.listFeedInfo.length,
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (homeListContext, itemIndex) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      // homeFeedResponseProvider.setFeedResponse(itemIndex);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BusinessDetailsScreen(
                              businessId: homeFeedResponseProvider
                                  .listFeedInfo[itemIndex].businessUserId),
                        ),
                      );
                    },
                    child: CheckInsItemView(
                      verifiedUserResponse: null,
                      feedResponse:
                          homeFeedResponseProvider.listFeedInfo[itemIndex],
                      isVisibleDeleteIcon: false,
                      isVisibleLikePanel: true,
                      onClickDelete: () {
                        homeFeedResponseProvider.deleteMycheckIns(
                            context,
                            homeFeedResponseProvider.listFeedInfo[itemIndex].id,
                            itemIndex,
                            "");
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Visibility(
            visible: homeFeedResponseProvider.isAvailableHomeData,
            child: Center(
              child: GlobalView().textViewWithCenterAlign(
                  AppMessages.no_feeds_available_with_filters_message,
                  AppTextStyle.inter_font_family,
                  AppTextStyle.semi_bold_font_weight,
                  BaseColor.black_color,
                  18),
            ),
          );
        }
      },
      // ),
    );
  }
}

//Widget listHomeView(
//         // HomeFeedResponseProvider homeFeedResponseProvider,
//         ) =>
//     Consumer<HomeFeedResponseProvider>(
//         builder: (_, homeFeedResponseProvider, child) {
//       return Stack(
//         children: [
//           Container(
//             child: homeFeedResponseProvider.listFeedInfo.isNotEmpty
//                 ? ListView.builder(
//                     physics: AlwaysScrollableScrollPhysics(),
//                     itemCount: homeFeedResponseProvider.listFeedInfo.length,
//                     controller: scrollController,
//                     shrinkWrap: true,
//                     itemBuilder: (homeListContext, itemIndex) {
//                       return Padding(
//                         padding: EdgeInsets.only(bottom: 8),
//                         child: GestureDetector(
//                           onTap: () {
//                             // Navigator.pushNamed(
//                             //     context, AppRoutes.checkInDetailsRouteName);
//                             homeFeedResponseProvider
//                                 .setFeedResponse(itemIndex);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => CheckInDetailsScreen()));
//                           },
//                           child: Card(
//                               elevation: 2,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: Row(
//                                         children: [
//                                           // Container(
//                                           //   height: 32,
//                                           //   width: 32,
//                                           //   decoration: BoxDecoration(
//                                           //     shape: BoxShape.circle,
//                                           //     color: Colors.grey,
//                                           //     image: DecorationImage(
//                                           //         image: homeFeedResponseProvider
//                                           //                     .listFeedInfo[
//                                           //                         itemIndex]
//                                           //                     .user
//                                           //                     .avatar !=
//                                           //                 ""
//                                           //             ? NetworkImage(
//                                           //                 homeFeedResponseProvider
//                                           //                     .listFeedInfo[
//                                           //                         itemIndex]
//                                           //                     .user
//                                           //                     .avatar)
//                                           //             : AssetImage(AppImages
//                                           //                 .default_profile_Pic),
//                                           //         fit: BoxFit.cover),
//                                           //   ),
//                                           // ),
//                                           Expanded(
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 0),
//                                               child: Container(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     GlobalView().textViewWithStartAlign(
//                                                         homeFeedResponseProvider
//                                                                         .listFeedInfo[
//                                                                             itemIndex]
//                                                                         .user
//                                                                         .firstName ==
//                                                                     null &&
//                                                                 homeFeedResponseProvider
//                                                                         .listFeedInfo[
//                                                                             itemIndex]
//                                                                         .user
//                                                                         .lastName ==
//                                                                     null
//                                                             ? "John Doe"
//                                                             : homeFeedResponseProvider
//                                                                     .listFeedInfo[
//                                                                         itemIndex]
//                                                                     .user
//                                                                     .firstName +
//                                                                 " " +
//                                                                 homeFeedResponseProvider
//                                                                     .listFeedInfo[
//                                                                         itemIndex]
//                                                                     .user
//                                                                     .lastName,
//                                                         AppTextStyle
//                                                             .metropolis_font_family,
//                                                         AppTextStyle
//                                                             .semi_bold_font_weight,
//                                                         BaseColor.black_color,
//                                                         12),
//                                                     GlobalView().textViewWithStartAlign(
//                                                         "15 min ago",
//                                                         AppTextStyle
//                                                             .metropolis_font_family,
//                                                         AppTextStyle
//                                                             .medium_font_weight,
//                                                         BaseColor.black_color,
//                                                         10),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 24,
//                                             width: 24,
//                                             child: Image.asset(
//                                                 AppImages.ic_menu),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     GlobalView().sizedBoxView(10),
//                                     Divider(
//                                       color: BaseColor.home_divider_color,
//                                       height: 2,
//                                       thickness: 1,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           top: 10, left: 10, right: 10),
//                                       child: GlobalView()
//                                           .textViewWithStartAlign(
//                                               homeFeedResponseProvider
//                                                           .listFeedInfo[
//                                                               itemIndex]
//                                                           .category
//                                                           .name ==
//                                                       null
//                                                   ? "Cafe"
//                                                   : homeFeedResponseProvider
//                                                       .listFeedInfo[itemIndex]
//                                                       .category
//                                                       .name,
//                                               AppTextStyle
//                                                   .metropolis_font_family,
//                                               AppTextStyle
//                                                   .semi_bold_font_weight,
//                                               BaseColor.forgot_pass_txt_color,
//                                               10),
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: GlobalView()
//                                           .textViewWithStartAlign(
//                                               homeFeedResponseProvider
//                                                           .listFeedInfo[
//                                                               itemIndex]
//                                                           .businessUser
//                                                           .businessName ==
//                                                       null
//                                                   ? "ChoxBlast Cafe"
//                                                   : homeFeedResponseProvider
//                                                       .listFeedInfo[itemIndex]
//                                                       .businessUser
//                                                       .businessName,
//                                               AppTextStyle
//                                                   .metropolis_font_family,
//                                               AppTextStyle.bold_font_weight,
//                                               BaseColor.black_color,
//                                               16),
//                                     ),
//                                     GlobalView().sizedBoxView(5),
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             height: 16,
//                                             width: 16,
//                                             child: Image.asset(
//                                               AppImages.ic_location_black,
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               padding: EdgeInsets.only(
//                                                   left: 7, top: 2),
//                                               alignment: Alignment.centerLeft,
//                                               child: GlobalView().textViewWithStartAlign(
//                                                   homeFeedResponseProvider
//                                                               .listFeedInfo[
//                                                                   itemIndex]
//                                                               .businessUser
//                                                               .businessAddress ==
//                                                           null
//                                                       ? "Abix Street, Main Road, San Fransisco, California"
//                                                       : homeFeedResponseProvider
//                                                           .listFeedInfo[
//                                                               itemIndex]
//                                                           .businessUser
//                                                           .businessAddress,
//                                                   AppTextStyle
//                                                       .metropolis_font_family,
//                                                   AppTextStyle
//                                                       .medium_font_weight,
//                                                   BaseColor.black_color
//                                                       .withOpacity(0.6),
//                                                   12),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     GlobalView().sizedBoxView(5),
//                                     Visibility(
//                                       visible: homeFeedResponseProvider
//                                                   .listFeedInfo[itemIndex]
//                                                   .description ==
//                                               ""
//                                           ? false
//                                           : true,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         child: Container(
//                                           alignment: Alignment.centerLeft,
//                                           child: GlobalView()
//                                               .textViewWithStartAlign(
//                                                   homeFeedResponseProvider
//                                                               .listFeedInfo[
//                                                                   itemIndex]
//                                                               .description ==
//                                                           null
//                                                       ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
//                                                       : homeFeedResponseProvider
//                                                           .listFeedInfo[
//                                                               itemIndex]
//                                                           .description,
//                                                   AppTextStyle
//                                                       .inter_font_family,
//                                                   AppTextStyle
//                                                       .medium_font_weight,
//                                                   BaseColor.black_color,
//                                                   12),
//                                         ),
//                                       ),
//                                     ),
//                                     // Padding(
//                                     //   padding: EdgeInsets.only(left: 10, right: 10),
//                                     //   child: Container(
//                                     //       alignment: Alignment.centerLeft,
//                                     //       child: Text(
//                                     //         "See more",
//                                     //         style: TextStyle(
//                                     //           decoration: TextDecoration.underline,
//                                     //           fontFamily: AppTextStyle.interFontFamily,
//                                     //           fontWeight: FontWeight.w600,
//                                     //           fontSize: 12,
//                                     //           color:
//                                     //               BaseColor.blackColor.withOpacity(0.5),
//                                     //         ),
//                                     //       )),
//                                     // ),
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: 16, right: 16, top: 5),
//                                       child: Container(
//                                         child: Row(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () {
//                                                 homeFeedResponseProvider.homeFeedLike(
//                                                     context,
//                                                     homeFeedResponseProvider
//                                                         .listFeedInfo[
//                                                             itemIndex]
//                                                         .id
//                                                         ,
//                                                     homeFeedResponseProvider
//                                                                 .listFeedInfo[
//                                                                     itemIndex]
//                                                                 .isLiked ==
//                                                             1
//                                                         ? 0
//                                                         : 1,
//                                                     itemIndex);
//                                               },
//                                               child: Image.asset(
//                                                 homeFeedResponseProvider
//                                                             .listFeedInfo[
//                                                                 itemIndex]
//                                                             .isLiked ==
//                                                         1
//                                                     ? AppImages
//                                                         .thumbs_up_filled
//                                                     : AppImages.thumbs_up,
//                                                 height: 24,
//                                                 width: 24,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 margin:
//                                                     EdgeInsets.only(left: 10),
//                                                 child: GlobalView().textViewWithStartAlign(
//                                                     homeFeedResponseProvider
//                                                                 .listFeedInfo[
//                                                                     itemIndex]
//                                                                 .totalLikes
//                                                                 .toString() ==
//                                                             null
//                                                         ? "0"
//                                                         : homeFeedResponseProvider
//                                                             .listFeedInfo[
//                                                                 itemIndex]
//                                                             .totalLikes
//                                                             .toString(),
//                                                     AppTextStyle
//                                                         .metropolis_font_family,
//                                                     AppTextStyle
//                                                         .medium_font_weight,
//                                                     BaseColor.black_color
//                                                         .withOpacity(0.5),
//                                                     12),
//                                               ),
//                                             ),
//                                             // SizedBox(
//                                             //   width: 30,
//                                             // ),
//                                             // GestureDetector(
//                                             //   onTap: () {
//                                             //     // homeFeed.changeDislikeValue(itemIndex);
//                                             //     homeFeedResponseProvider
//                                             //         .home_feed_like(
//                                             //             context,
//                                             //             homeFeedResponseProvider
//                                             //                 .listFeedInfo[itemIndex]
//                                             //                 .id
//                                             //                 .toString(),
//                                             //             homeFeedResponseProvider
//                                             //                         .listFeedInfo[
//                                             //                             itemIndex]
//                                             //                         .isDisliked ==
//                                             //                     1
//                                             //                 ? "0"
//                                             //                 : "1",
//                                             //             itemIndex);
//                                             //   },
//                                             //   child: Image.asset(
//                                             //     homeFeedResponseProvider
//                                             //                 .listFeedInfo[itemIndex]
//                                             //                 .isDisliked ==
//                                             //             1
//                                             //         ? AppImages.thumbs_down_filled
//                                             //         : AppImages.thumbs_down,
//                                             //     height: 24,
//                                             //     width: 24,
//                                             //   ),
//                                             // ),
//                                             // Expanded(
//                                             //   child: Container(
//                                             //     margin: EdgeInsets.only(left: 10),
//                                             //     child: GlobalView()
//                                             //         .textViewWithStartAlign(
//                                             //             homeFeedResponseProvider
//                                             //                         .listFeedInfo[
//                                             //                             itemIndex]
//                                             //                         .totalDislikes
//                                             //                         .toString() ==
//                                             //                     null
//                                             //                 ? "0"
//                                             //                 : homeFeedResponseProvider
//                                             //                     .listFeedInfo[
//                                             //                         itemIndex]
//                                             //                     .totalDislikes
//                                             //                     .toString(),
//                                             //             AppTextStyle
//                                             //                 .metropolisFontFamily,
//                                             //             AppTextStyle
//                                             //                 .mediumFontWeight,
//                                             //             BaseColor.blackColor
//                                             //                 .withOpacity(0.5),
//                                             //             12),
//                                             //   ),
//                                             // ),
//                                             SizedBox(
//                                               width: 30,
//                                             ),
//                                             Image.asset(
//                                               AppImages.ic_comments,
//                                               height: 24,
//                                               width: 24,
//                                             ),

//                                             Expanded(
//                                               child: Container(
//                                                 margin:
//                                                     EdgeInsets.only(left: 10),
//                                                 child: GlobalView().textViewWithStartAlign(
//                                                     homeFeedResponseProvider
//                                                                 .listFeedInfo[
//                                                                     itemIndex]
//                                                                 .totalComments
//                                                                 .toString() ==
//                                                             null
//                                                         ? "5.2k"
//                                                         : homeFeedResponseProvider
//                                                             .listFeedInfo[
//                                                                 itemIndex]
//                                                             .totalComments
//                                                             .toString(),
//                                                     AppTextStyle
//                                                         .metropolis_font_family,
//                                                     AppTextStyle
//                                                         .medium_font_weight,
//                                                     BaseColor.black_color
//                                                         .withOpacity(0.5),
//                                                     12),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 30,
//                                             ),
//                                             // Image.asset(
//                                             //   AppImages.ic_share,
//                                             //   height: 24,
//                                             //   width: 24,
//                                             // ),
//                                             // Expanded(
//                                             //   child: Container(
//                                             //      margin: EdgeInsets.only(left: 10),
//                                             //     child: GlobalView()
//                                             //         .textViewWithStartAlign(
//                                             //             homeFeedResponseProvider
//                                             //                         .listFeedInfo[
//                                             //                             itemIndex]
//                                             //                         .totalShares
//                                             //                         .toString() ==
//                                             //                     null
//                                             //                 ? "150"
//                                             //                 : homeFeedResponseProvider
//                                             //                     .listFeedInfo[
//                                             //                         itemIndex]
//                                             //                     .totalShares
//                                             //                     .toString(),
//                                             //             AppTextStyle
//                                             //                 .metropolisFontFamily,
//                                             //             AppTextStyle
//                                             //                 .mediumFontWeight,
//                                             //             BaseColor.blackColor
//                                             //                 .withOpacity(0.5),
//                                             //             12),
//                                             //   ),
//                                             // ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         ),
//                       );
//                     })
//                 : Center(
//                     child: GlobalView().textViewWithCenterAlign(
//                         AppMessages.no_feeds_available_with_filters_message,
//                         AppTextStyle.inter_font_family,
//                         AppTextStyle.semi_bold_font_weight,
//                         BaseColor.black_color,
//                         18),
//                   ),
//           ),
//           Positioned(
//             child: Visibility(
//               visible: Provider.of<HomeFeedResponseProvider>(context,
//                       listen: false)
//                   .isLoading,
//               child: Container(
//                 color: BaseColor.home_bg_color,
//                 child: GlobalView().loaderView(),
//               ),
//             ),
//           ),
//         ],
//       );
//     });

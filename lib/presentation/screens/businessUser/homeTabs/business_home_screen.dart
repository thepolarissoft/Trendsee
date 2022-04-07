import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/business_user_response.dart';
import 'package:trendoapp/data/models/home_feed_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/common/checkIn_details_screen.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

class BusinessHomeScreen extends StatefulWidget {
  @override
  _BusinessHomeScreenState createState() => _BusinessHomeScreenState();
}

class _BusinessHomeScreenState extends State<BusinessHomeScreen> {
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  int page = 1;
  ScrollController scrollController = new ScrollController();
  BusinessUserResponse businessUserResponse;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      Provider.of<BusinessUserProvider>(context, listen: false)
          .setViewsLikesClicksValue(AppMessages.view_text);
      Provider.of<BusinessUserProvider>(context, listen: false).isViews = true;
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .homeFeedResponse = null;
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .listFeedInfo
          .clear();
      getBusinessProfileData();
      Provider.of<HomeFeedResponseProvider>(context, listen: false)
          .getHomeFeedList(context, "0", "", "", "", "");
      // if (Provider.of<HomeFeedResponseProvider>(context, listen: false)
      //     .listFeedInfo
      //     .isNotEmpty) {
      Provider.of<BusinessUserProvider>(context, listen: false)
          .listBusinessKeywords
          .clear();
      // }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreHomeFeedData();
      }
    });
  }

  void getBusinessProfileData() {
    String profile = PreferenceUtils.getStringValue(
        PreferenceUtils.keyBusinessUserProfileObject);
    print("Profile-> $profile");
    // businessUserResponse =
    //     new BusinessUserResponse.fromJson(json.decode(profile));
    // // profileResponse = ProfileResponse.fromJson(json.decode(model));
    // print(
    //     "businessUserProfileResponse-> ${businessUserResponse.toJson()}");
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);
    provider.graphView(
        context,
        PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
        getGraphRange(provider.selectedDropDownValue));
  }

  FutureOr onCallBack(dynamic value) {
    var provider = Provider.of<BusinessUserProvider>(context, listen: false);

    provider.setViewsLikesClicksValue(AppMessages.view_text);
    provider.graphView(
        context,
        PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
        getGraphRange(provider.selectedDropDownValue));
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .listFeedInfo
        .clear();
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .getHomeFeedList(context, "0", "", "", "", "");
  }

  void getMoreHomeFeedData() {
    HomeFeedResponse homeFeedResponse =
        Provider.of<HomeFeedResponseProvider>(context, listen: false)
            .homeFeedResponse;
    print("nextPageUrl-->> ${homeFeedResponse.data.nextPageUrl}");
    if (homeFeedResponse != null) {
      if (homeFeedResponse.data.nextPageUrl != null) {
        page++;
        Provider.of<HomeFeedResponseProvider>(context, listen: false)
            .getHomeFeedList(context, "0", "", "", "", "");
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

  void onChangedGropDownValue(BusinessUserProvider provider, String value) {
    print("VALUE=-=> $value");
    provider.setSelectedDropDownValue(value);
    getGraphRange(value);
    if (provider.isViews) {
      provider.graphView(
          context,
          PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
          getGraphRange(value));
    } else if (provider.isLikes) {
      provider.graphLike(
          context,
          PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
          getGraphRange(value));
    } else {
      provider.graphClick(
          context,
          PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
          getGraphRange(value));
    }
  }

  int getTotalValue(int i, HomeFeedResponseProvider homeFeed) {
    if (homeFeed.homeFeedResponse == null) {
      return 0;
    }
    switch (i) {
      case 1:
        if (homeFeed.homeFeedResponse.totalViews != null) {
          return homeFeed.homeFeedResponse.totalViews;
        } else {
          return 0;
        }
        break;
      case 2:
        if (homeFeed.homeFeedResponse.totalLikes != null) {
          return homeFeed.homeFeedResponse.totalLikes;
        } else {
          return 0;
        }
        break;
      case 3:
        if (homeFeed.homeFeedResponse.totalClick != null) {
          return homeFeed.homeFeedResponse.totalClick;
        } else {
          return 0;
        }
        break;
      default:
        return 0;
    }
  }

  String getGraphRange(String value) {
    switch (value) {
      case "By Day":
        return "day";
        break;
      case "By Month":
        return "month";
        break;
      case "By Year":
        return "year";
        break;
      default:
        return "day";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.home_bg_color,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BaseColor.home_bg_color,
          body:
              Consumer<HomeFeedResponseProvider>(builder: (_, homeFeed, child) {
            return Stack(
              children: [
                // !homeFeed.isLoading
                //     ?
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: topView(),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        color: BaseColor.btn_gradient_end_color1,
                        onRefresh: () async {
                          Provider.of<HomeFeedResponseProvider>(context,
                                  listen: false)
                              .homeFeedResponse = null;
                          // Provider.of<HomeFeedResponseProvider>(context, listen: false)
                          //     .listFeedInfo
                          //     .clear();
                          Provider.of<HomeFeedResponseProvider>(context,
                                  listen: false)
                              .getHomeFeedList(context, "0", "", "", "", "");
                        },
                        child: CustomScrollView(
                          controller: scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  GlobalView().sizedBoxView(20),
                                  likesViewUI(homeFeed),
                                  GlobalView().sizedBoxView(15),
                                  Consumer<BusinessUserProvider>(
                                      builder: (_, provider, child) {
                                    if (provider.listGraphLikeData.length > 0) {
                                      return Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                child: dropDownView(provider),
                                              )),
                                          GlobalView().sizedBoxView(10),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: SfCartesianChart(
                                              primaryXAxis: CategoryAxis(
                                                axisLine: AxisLine(width: 0),
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                              ),
                                              // primaryYAxis: CategoryAxis(
                                              // axisLine: AxisLine(width: 0),
                                              // // majorGridLines: MajorGridLines(width: 0),
                                              // ),
                                              backgroundColor:
                                                  BaseColor.home_bg_color,
                                              enableSideBySideSeriesPlacement:
                                                  false,
                                              tooltipBehavior: _tooltipBehavior,
                                              series: <ChartSeries>[
                                                // Renders fast line chart
                                                FastLineSeries<GraphData,
                                                    String>(
                                                  dataSource: provider
                                                      .listGraphLikeData,
                                                  color: BaseColor
                                                      .forgot_pass_txt_color,
                                                  xValueMapper:
                                                      (GraphData sales, _) =>
                                                          sales.month,
                                                  yValueMapper:
                                                      (GraphData sales, _) =>
                                                          sales.value,
                                                  // dataLabelSettings: DataLabelSettings(isVisible: true),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                ],
                              ),
                            ),
                            SliverPadding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, itemIndex) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(
                                      //     context, AppRoutes.checkInDetailsRouteName);
                                      homeFeed.setFeedResponse(itemIndex);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CheckInDetailsScreen(),
                                        ),
                                      ).then(onCallBack);
                                    },
                                    child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    // Container(
                                                    //   height: 32,
                                                    //   width: 32,
                                                    //   decoration: BoxDecoration(
                                                    //     shape: BoxShape.circle,
                                                    //     color: Colors.grey,
                                                    //     image: DecorationImage(
                                                    //         image: homeFeed
                                                    //                     .listFeedInfo[
                                                    //                         itemIndex]
                                                    //                     .user
                                                    //                     .avatar !=
                                                    //                 ""
                                                    //             ? NetworkImage(
                                                    //                 homeFeed
                                                    //                     .listFeedInfo[
                                                    //                         itemIndex]
                                                    //                     .user
                                                    //                     .avatar)
                                                    //             : AssetImage(AppImages
                                                    //                 .default_profile_Pic),
                                                    //         fit: BoxFit.cover),
                                                    //   ),
                                                    // ),
                                                    Expanded(
                                                      child: Padding(
                                                        // padding: EdgeInsets.symmetric(
                                                        //     horizontal: 10),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GlobalView()
                                                                  .textViewWithStartAlign(
                                                                      homeFeed.listFeedInfo[itemIndex].user.username ==
                                                                              null
                                                                          ? "John Doe"
                                                                          : homeFeed
                                                                              .listFeedInfo[
                                                                                  itemIndex]
                                                                              .user
                                                                              .username,

                                                                      // "John Doe",
                                                                      AppTextStyle
                                                                          .metropolis_font_family,
                                                                      AppTextStyle
                                                                          .semi_bold_font_weight,
                                                                      BaseColor
                                                                          .black_color,
                                                                      12),
                                                              GlobalView().textViewWithStartAlign(
                                                                  DayTimeUtils().convertToAgo(homeFeed
                                                                      .listFeedInfo[
                                                                          itemIndex]
                                                                      .createdAt),
                                                                  AppTextStyle
                                                                      .metropolis_font_family,
                                                                  AppTextStyle
                                                                      .medium_font_weight,
                                                                  BaseColor
                                                                      .black_color,
                                                                  10),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 24,
                                                      width: 24,
                                                      child: Image.asset(
                                                          AppImages.ic_menu),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GlobalView().sizedBoxView(10),
                                              Divider(
                                                color: BaseColor
                                                    .home_divider_color,
                                                height: 2,
                                                thickness: 1,
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: DeviceSize()
                                                              .deviceWidth(
                                                                  context) *
                                                          0.2,
                                                      width: DeviceSize()
                                                              .deviceWidth(
                                                                  context) *
                                                          0.2,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: homeFeed
                                                                        .listFeedInfo[
                                                                            itemIndex]
                                                                        .businessUser
                                                                        .avatar !=
                                                                    ""
                                                                ? NetworkImage(homeFeed
                                                                    .listFeedInfo[
                                                                        itemIndex]
                                                                    .businessUser
                                                                    .avatar)
                                                                : AssetImage(
                                                                    AppImages
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: GlobalView()
                                                                .textViewWithStartAlign(
                                                                    homeFeed.listFeedInfo[itemIndex].businessUser.businessName ==
                                                                            null
                                                                        ? "ChoxBlast Cafe"
                                                                        : homeFeed
                                                                            .listFeedInfo[
                                                                                itemIndex]
                                                                            .businessUser
                                                                            .businessName,
                                                                    // "ChoxBlast Cafe",
                                                                    AppTextStyle
                                                                        .metropolis_font_family,
                                                                    AppTextStyle
                                                                        .bold_font_weight,
                                                                    BaseColor
                                                                        .black_color,
                                                                    18),
                                                          ),
                                                          GlobalView()
                                                              .sizedBoxView(2),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 0,
                                                                    left: 0,
                                                                    right: 0),
                                                            child: GlobalView()
                                                                .textViewWithStartAlign(
                                                                    homeFeed
                                                                            .listFeedInfo[
                                                                                itemIndex]
                                                                            .categories
                                                                            .isEmpty
                                                                        ? "Cafe"
                                                                        : CategoryUtils().getCategoryName(homeFeed
                                                                            .listFeedInfo[
                                                                                itemIndex]
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
                                                          GlobalView()
                                                              .sizedBoxView(2),
                                                          Visibility(
                                                            visible: homeFeed
                                                                            .listFeedInfo[
                                                                                itemIndex]
                                                                            .locationName ==
                                                                        null ||
                                                                    homeFeed.listFeedInfo[itemIndex]
                                                                            .locationName ==
                                                                        ""
                                                                ? false
                                                                : true,
                                                            child: Container(
                                                              child: GlobalView()
                                                                  .textViewWithStartAlign(
                                                                      homeFeed.listFeedInfo[itemIndex].locationName ==
                                                                              null
                                                                          ? "Cafe"
                                                                          : homeFeed
                                                                              .listFeedInfo[
                                                                                  itemIndex]
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 16,
                                                      width: 16,
                                                      child: Image.asset(
                                                        AppImages
                                                            .ic_location_black,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 7,
                                                                top: 2),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: GlobalView()
                                                            .textViewWithStartAlign(
                                                                homeFeed
                                                                            .listFeedInfo[
                                                                                itemIndex]
                                                                            .businessUser
                                                                            .isMobile ==
                                                                        1
                                                                    ? AppMessages
                                                                        .mobile_business_text
                                                                    : homeFeed.listFeedInfo[itemIndex].businessUser.isOnline ==
                                                                            0
                                                                        ? homeFeed.listFeedInfo[itemIndex].businessUser.businessAddress ==
                                                                                null
                                                                            ? "Abix Street, Main Road, San Fransisco, California"
                                                                            : homeFeed
                                                                                .listFeedInfo[
                                                                                    itemIndex]
                                                                                .businessUser
                                                                                .businessAddress
                                                                        : AppMessages
                                                                            .online_business_text,
                                                                // "Abix Street",
                                                                AppTextStyle
                                                                    .metropolis_font_family,
                                                                AppTextStyle
                                                                    .medium_font_weight,
                                                                BaseColor
                                                                    .black_color
                                                                    .withOpacity(
                                                                        0.6),
                                                                12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GlobalView().sizedBoxView(5),
                                              Visibility(
                                                visible: homeFeed
                                                            .listFeedInfo[
                                                                itemIndex]
                                                            .description ==
                                                        ""
                                                    ? false
                                                    : true,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: GlobalView()
                                                        .textViewWithStartAlign(
                                                            homeFeed
                                                                        .listFeedInfo[
                                                                            itemIndex]
                                                                        .description ==
                                                                    null
                                                                ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
                                                                : homeFeed
                                                                    .listFeedInfo[
                                                                        itemIndex]
                                                                    .description,
                                                            // "Lorem ipsum dolor sit amet",
                                                            AppTextStyle
                                                                .inter_font_family,
                                                            AppTextStyle
                                                                .medium_font_weight,
                                                            BaseColor
                                                                .black_color,
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
                                              //           color:
                                              //               BaseColor.blackColor.withOpacity(0.5),
                                              //         ),
                                              //       )),
                                              // ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 5),
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     homeFeed.homeFeedLike(
                                                      //         context,
                                                      //         homeFeed
                                                      //             .listFeedInfo[
                                                      //                 itemIndex]
                                                      //             .id,
                                                      //         homeFeed
                                                      //                     .listFeedInfo[
                                                      //                         itemIndex]
                                                      //                     .isLiked ==
                                                      //                 1
                                                      //             ? 0
                                                      //             : 1,
                                                      //         itemIndex);
                                                      //   },
                                                      //   child: Image.asset(
                                                      //     homeFeed
                                                      //                 .listFeedInfo[
                                                      //                     itemIndex]
                                                      //                 .isLiked ==
                                                      //             1
                                                      //         ? AppImages
                                                      //             .thumbs_up_filled
                                                      //         : AppImages.thumbs_up,
                                                      //     height: 24,
                                                      //     width: 24,
                                                      //   ),
                                                      // ),
                                                      // Expanded(
                                                      //   child: Container(
                                                      //     margin:
                                                      //         EdgeInsets.only(left: 10),
                                                      //     child: GlobalView()
                                                      //         .textViewWithStartAlign(
                                                      //             homeFeed
                                                      //                         .listFeedInfo[
                                                      //                             itemIndex]
                                                      //                         .totalLikes
                                                      //                         .toString() ==
                                                      //                     null
                                                      //                 ? "0"
                                                      //                 : homeFeed
                                                      //                     .listFeedInfo[
                                                      //                         itemIndex]
                                                      //                     .totalLikes
                                                      //                     .toString(),
                                                      //             // "0",
                                                      //             AppTextStyle
                                                      //                 .metropolis_font_family,
                                                      //             AppTextStyle
                                                      //                 .medium_font_weight,
                                                      //             BaseColor.black_color
                                                      //                 .withOpacity(0.5),
                                                      //             12),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(
                                                      //   width: 30,
                                                      // ),
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     // homeFeed.changeDislikeValue(itemIndex);
                                                      //     // homeFeedResponseProvider
                                                      //     //     .home_feed_like_dislike(
                                                      //     //         context,
                                                      //     //         homeFeedResponseProvider
                                                      //     //             .listFeedInfo[
                                                      //     //                 itemIndex]
                                                      //     //             .id
                                                      //     //             .toString(),
                                                      //     //         "dislike",
                                                      //     //         "0",
                                                      //     //         homeFeedResponseProvider
                                                      //     //                     .listFeedInfo[
                                                      //     //                         itemIndex]
                                                      //     //                     .isDisliked ==
                                                      //     //                 1
                                                      //     //             ? "0"
                                                      //     //             : "1",
                                                      //     //         itemIndex);
                                                      //   },
                                                      //   child: Image.asset(
                                                      //     businessHomeFeedProvider
                                                      //                 .listFeedInfo[
                                                      //                     itemIndex]
                                                      //                 .isDisliked ==
                                                      //             1
                                                      //         ? AppImages
                                                      //             .thumbs_down_filled
                                                      //         : AppImages
                                                      //             .thumbs_down,
                                                      //     height: 24,
                                                      //     width: 24,
                                                      //   ),
                                                      // ),
                                                      // Expanded(
                                                      //   child: Container(
                                                      //      margin: EdgeInsets.only(
                                                      //         left: 10),
                                                      //     child: GlobalView()
                                                      //         .textViewWithStartAlign(
                                                      //             businessHomeFeedProvider
                                                      //                         .listFeedInfo[
                                                      //                             itemIndex]
                                                      //                         .totalDislikes
                                                      //                         .toString() ==
                                                      //                     null
                                                      //                 ? "0"
                                                      //                 : businessHomeFeedProvider
                                                      //                     .listFeedInfo[
                                                      //                         itemIndex]
                                                      //                     .totalDislikes
                                                      //                     .toString(),
                                                      //             // "0",
                                                      //             AppTextStyle
                                                      //                 .metropolisFontFamily,
                                                      //             AppTextStyle
                                                      //                 .mediumFontWeight,
                                                      //             BaseColor
                                                      //                 .blackColor
                                                      //                 .withOpacity(
                                                      //                     0.5),
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
                                                      //     margin:
                                                      //         EdgeInsets.only(left: 10),
                                                      //     child: GlobalView()
                                                      //         .textViewWithStartAlign(
                                                      //             homeFeed
                                                      //                         .listFeedInfo[
                                                      //                             itemIndex]
                                                      //                         .totalComments
                                                      //                         .toString() ==
                                                      //                     null
                                                      //                 ? "5.2k"
                                                      //                 : homeFeed
                                                      //                     .listFeedInfo[
                                                      //                         itemIndex]
                                                      //                     .totalComments
                                                      //                     .toString(),
                                                      //             // "0",
                                                      //             AppTextStyle
                                                      //                 .metropolis_font_family,
                                                      //             AppTextStyle
                                                      //                 .medium_font_weight,
                                                      //             BaseColor.black_color
                                                      //                 .withOpacity(0.5),
                                                      //             12),
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
                                                      //             businessHomeFeedProvider
                                                      //                         .listFeedInfo[
                                                      //                             itemIndex]
                                                      //                         .totalShares
                                                      //                         .toString() ==
                                                      //                     null
                                                      //                 ? "150"
                                                      //                 : businessHomeFeedProvider
                                                      //                     .listFeedInfo[
                                                      //                         itemIndex]
                                                      //                     .totalShares
                                                      //                     .toString(),
                                                      //             // "0",
                                                      //             AppTextStyle
                                                      //                 .metropolisFontFamily,
                                                      //             AppTextStyle
                                                      //                 .mediumFontWeight,
                                                      //             BaseColor
                                                      //                 .blackColor
                                                      //                 .withOpacity(
                                                      //                     0.5),
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
                                );
                              }, childCount: homeFeed.listFeedInfo.length)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // : Container(
                //     color: BaseColor.loader_bg_color,
                //     child: GlobalView().loaderView(),
                //   ),
                Positioned(
                  child: Visibility(
                    visible: Provider.of<HomeFeedResponseProvider>(context,
                            listen: false)
                        .isLoading,
                    child: Container(
                      // color: BaseColor.pure_white_color,
                      child: GlobalView().loaderView(),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        //  GlobalView().assetImageView(AppImages.trendsee),
                        GlobalView().textViewWithStartAlign(
                            AppMessages.trend_text,
                            AppTextStyle.alphapipe_font_family,
                            AppTextStyle.bold_font_weight,
                            BaseColor.forgot_pass_txt_color,
                            36),
                  ),
                  // Expanded(
                  //   child: GlobalView().textViewWithStartAlign(
                  //       AppMessages.homeSubTitle,
                  //       AppTextStyle.metropolisFontFamily,
                  //       AppTextStyle.normalFontWeight,
                  //       BaseColor.blackColor.withOpacity(0.5),
                  //       12),
                  // ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 40,
          //   width: 40,
          //   child: Image.asset(
          //     AppImages.ic_sort,
          //     height: 40,
          //     width: 40,
          //   ),
          // ),

          // Container(
          //     height: 40,
          //     width: 40,
          //     // color: Colors.redAccent,
          //     child: Image.asset(
          //       AppImages.ic_bell_filled,
          //       height: 40,
          //       width: 40,
          //     )
          //     //  GlobalView().assetImageView(AppImages.ic_bell_filled),
          //     ),
        ],
      ),
    );
  }

  Widget likesViewUI(HomeFeedResponseProvider homeFeed) {
    print("likesView Called");
    // print(
    //     "homeFeed.homeFeedResponse.totalViews-> ${homeFeed.homeFeedResponse.totalViews ?? 0}");
    return Consumer<BusinessUserProvider>(builder: (_, provider, child) {
      return Container(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    provider.setViewsLikesClicksValue(AppMessages.view_text);
                    // GlobalView().showToast(AppMessages.working_progress_text);
                    provider.graphView(
                        context,
                        PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
                        getGraphRange(provider.selectedDropDownValue));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Container(
                      decoration: GlobalView().gradientDecorationView(
                          provider.isViews
                              ? BaseColor.btn_gradient_start_color1
                              : BaseColor.btn_gradient_start_color2,
                          provider.isViews
                              ? BaseColor.btn_gradient_end_color1
                              : BaseColor.btn_gradient_end_color2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: GlobalView().textViewWithCenterAlign(
                                  getTotalValue(1, homeFeed).toString(),
                                  // homeFeed.homeFeedResponse.totalViews.toString() ??
                                  //     0,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.pure_white_color,
                                  20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: GlobalView().textViewWithCenterAlign(
                                  AppMessages.views_text,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.medium_font_weight,
                                  BaseColor.pure_white_color,
                                  12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    provider.setViewsLikesClicksValue(AppMessages.like_text);
                    Provider.of<BusinessUserProvider>(context, listen: false)
                        .graphLike(
                            context,
                            PreferenceUtils.getIntValue(
                                PreferenceUtils.keyUserId),
                            getGraphRange(provider.selectedDropDownValue));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Container(
                      decoration: GlobalView().gradientDecorationView(
                          provider.isLikes
                              ? BaseColor.btn_gradient_start_color1
                              : BaseColor.btn_gradient_start_color2,
                          provider.isLikes
                              ? BaseColor.btn_gradient_end_color1
                              : BaseColor.btn_gradient_end_color2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: GlobalView().textViewWithCenterAlign(
                                  getTotalValue(2, homeFeed).toString(),
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.pure_white_color,
                                  20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: GlobalView().textViewWithCenterAlign(
                                  AppMessages.likes_text,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.medium_font_weight,
                                  BaseColor.pure_white_color,
                                  12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // GlobalView().showToast(AppMessages.working_progress_text);
                    provider.setViewsLikesClicksValue(AppMessages.click_text);
                    provider.graphClick(
                        context,
                        PreferenceUtils.getIntValue(PreferenceUtils.keyUserId),
                        getGraphRange(provider.selectedDropDownValue));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: Container(
                      decoration: GlobalView().gradientDecorationView(
                          provider.isClicks
                              ? BaseColor.btn_gradient_start_color1
                              : BaseColor.btn_gradient_start_color2,
                          provider.isClicks
                              ? BaseColor.btn_gradient_end_color1
                              : BaseColor.btn_gradient_end_color2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              alignment: Alignment.center,
                              child: GlobalView().textViewWithCenterAlign(
                                  getTotalValue(3, homeFeed).toString(),
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.pure_white_color,
                                  20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: GlobalView().textViewWithCenterAlign(
                                  AppMessages.clicks_text,
                                  AppTextStyle.inter_font_family,
                                  AppTextStyle.medium_font_weight,
                                  BaseColor.pure_white_color,
                                  12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }

  Widget dropDownView(BusinessUserProvider provider) {
    return Padding(
      padding: EdgeInsets.only(right: DeviceSize().deviceWidth(context) * 0.03),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: BaseColor.grey_color),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            // menuMaxHeight: DeviceSize().deviceHeight(context) * .15,
            isDense: true,
            value: provider.selectedDropDownValue,
            iconSize: 25,
            icon: Icon(Icons.arrow_drop_down),
            items: provider.dropDownItems
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: GlobalView().textViewWithCenterAlign(
                    value,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.medium_font_weight,
                    BaseColor.black_color,
                    16),
              );
            }).toList(),
            onChanged: (String value) {
              onChangedGropDownValue(provider, value);
            },
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

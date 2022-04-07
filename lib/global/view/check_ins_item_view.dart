import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/data/models/verified_user_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

// ignore: must_be_immutable
class CheckInsItemView extends StatelessWidget {
  // const ListItemView({Key key}) : super(key: key);
  VerifiedUserResponse verifiedUserResponse;
  FeedResponse feedResponse;
  bool isVisibleDeleteIcon;
  bool isVisibleLikePanel;
  VoidCallback onClickDelete;
  CheckInsItemView({
    @required this.verifiedUserResponse,
    @required this.feedResponse,
    @required this.isVisibleDeleteIcon,
    @required this.isVisibleLikePanel,
    @required this.onClickDelete,
  });

  void onClickLike(BuildContext context, int feedId) {
    Provider.of<HomeFeedResponseProvider>(context, listen: false).checkInsLike(
      context,
      feedResponse,
      feedResponse.isLiked == 1 ? 0 : 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    // log("FEED RESPONSE==-=--> ${feedResponse.toJson()}");
    // if (verifiedUserResponse != null) {
    //   log("VERIFIED USER RESPONSE==-=--> ${verifiedUserResponse.toJson()}");
    // }

    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GlobalView().textViewWithStartAlign(
                                  verifiedUserResponse == null
                                      ? feedResponse.user.username == null
                                          ? "John Doe"
                                          : feedResponse.user.username
                                      : verifiedUserResponse.username == null
                                          ? "John Doe"
                                          : verifiedUserResponse.username,
                                  // "John Doe",
                                  AppTextStyle.metropolis_font_family,
                                  AppTextStyle.semi_bold_font_weight,
                                  BaseColor.black_color,
                                  12),
                              GlobalView().textViewWithStartAlign(
                                  // "15 min ago",
                                  DayTimeUtils()
                                      .convertToAgo(feedResponse.createdAt),
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
                      child: Image.asset(AppImages.ic_menu),
                    )
                  ],
                ),
              ),
              GlobalView().sizedBoxView(10),
              Divider(
                color: BaseColor.home_divider_color,
                height: 2,
                thickness: 1,
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              //   child: GlobalView().textViewWithStartAlign(
              //       feedResponse.category.name == null
              //           ? "Cafe"
              //           : feedResponse.category.name,
              //       // "Cafe",
              //       AppTextStyle.metropolis_font_family,
              //       AppTextStyle.semi_bold_font_weight,
              //       BaseColor.forgot_pass_txt_color,
              //       10),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Row(
                  children: [
                    Container(
                      height: DeviceSize().deviceWidth(context) * 0.2,
                      width: DeviceSize().deviceWidth(context) * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                            image: feedResponse.businessUser.avatar != ""
                                ? NetworkImage(feedResponse.businessUser.avatar)
                                : AssetImage(AppImages.default_profile_Pic),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Wrap(
                          //     runSpacing: 5,
                          //     children: List.generate(
                          //         feedResponse.categories.length, (index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.only(right: 5),
                          //         child: Container(
                          //           decoration: BoxDecoration(
                          //               color: BaseColor.forgot_pass_txt_color,
                          //               borderRadius: BorderRadius.circular(20),
                          //               border: Border.all(
                          //                   color: BaseColor
                          //                       .forgot_pass_txt_color)),
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: 10, vertical: 6),
                          //           child: GlobalView().textViewWithStartAlign(
                          //               feedResponse.categories == null
                          //                   ? "Cafe"
                          //                   : feedResponse
                          //                       .categories[index].name,
                          //               // "Cafe",
                          //               AppTextStyle.metropolis_font_family,
                          //               AppTextStyle.bold_font_weight,
                          //               BaseColor.pure_white_color,
                          //               12),
                          //         ),
                          //       );
                          //     })),
                          // GlobalView().sizedBoxView(2),
                          GlobalView().textViewWithStartAlign(
                              // verifiedUserResponse == null
                              //     ? feedResponse.businessUser.businessName == null
                              //         ?  "ChoxBlast Cafe"
                              //         : feedResponse.businessUser.businessName
                              //     : verifiedUserResponse.businessName == null
                              //         ? "ChoxBlast Cafe"
                              //         : verifiedUserResponse.businessName,
                              feedResponse.businessUser.businessName == null
                                  ? "ChoxBlast Cafe"
                                  : feedResponse.businessUser.businessName,
                              // "ChoxBlast Cafe",
                              AppTextStyle.metropolis_font_family,
                              AppTextStyle.bold_font_weight,
                              BaseColor.black_color,
                              18),
                          GlobalView().sizedBoxView(2),
                          Container(
                            child: GlobalView().textViewWithStartAlign(
                                feedResponse.categories == null
                                    ? "Cafe"
                                    : CategoryUtils().getCategoryName(
                                        feedResponse.categories),
                                // "Cafe",
                                AppTextStyle.metropolis_font_family,
                                AppTextStyle.bold_font_weight,
                                BaseColor.forgot_pass_txt_color,
                                12),
                          ),
                          GlobalView().sizedBoxView(2),
                          Visibility(
                            visible: feedResponse.locationName == null ||
                                    feedResponse.locationName == ""
                                ? false
                                : true,
                            child: Container(
                              child: GlobalView().textViewWithStartAlign(
                                  feedResponse.locationName == null
                                      ? "Cafe"
                                      : feedResponse.locationName,
                                  // "Cafe",
                                  AppTextStyle.metropolis_font_family,
                                  AppTextStyle.bold_font_weight,
                                  BaseColor.forgot_pass_txt_color,
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
                        padding: EdgeInsets.only(left: 7, top: 2),
                        alignment: Alignment.centerLeft,
                        child: GlobalView().textViewWithStartAlign(
                            feedResponse.businessUser.isMobile == 1
                                ? AppMessages.mobile_business_text
                                : feedResponse.businessUser.isOnline == 0
                                    ? feedResponse
                                                .businessUser.businessAddress ==
                                            null
                                        ? "ChoxBlast Cafe"
                                        : feedResponse
                                            .businessUser.businessAddress
                                    : AppMessages.online_business_text,
                            // "Abix Street",
                            AppTextStyle.metropolis_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.black_color.withOpacity(0.6),
                            12),
                      ),
                    )
                  ],
                ),
              ),
              GlobalView().sizedBoxView(5),
              Visibility(
                visible: feedResponse.description == "" ? false : true,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: GlobalView().textViewWithStartAlign(
                        feedResponse.description == null
                            ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
                            : feedResponse.description,
                        // "Lorem ipsum dolor sit amet",
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
              //           color:
              //               BaseColor.blackColor.withOpacity(0.5),
              //         ),
              //       )),
              // ),

              Visibility(
                visible: isVisibleLikePanel,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                  child: Container(
                    child: Row(
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     print("LIKE CALLED1");
                        //     this.onClickLike(context, feedResponse.id);
                        //     print("LIKE CALLED2");
                        //   },
                        //   child: Image.asset(
                        //     feedResponse.isLiked == 1
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
                        //         feedResponse.totalLikes.toString() == null
                        //             ? "0"
                        //             : feedResponse.totalLikes.toString(),
                        //         // "0",
                        //         AppTextStyle.metropolis_font_family,
                        //         AppTextStyle.medium_font_weight,
                        //         BaseColor.black_color.withOpacity(0.5),
                        //         12),
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
                        //         feedResponse.totalComments.toString() == null
                        //             ? "5.2k"
                        //             : feedResponse.totalComments.toString(),
                        //         // "0",
                        //         AppTextStyle.metropolis_font_family,
                        //         AppTextStyle.medium_font_weight,
                        //         BaseColor.black_color.withOpacity(0.5),
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
                        Visibility(
                          visible: isVisibleDeleteIcon,
                          child: GestureDetector(
                            onTap: () {
                              print("delete called");
                              onClickDelete();
                            },
                            child: Image.asset(
                              AppImages.icon_finder_delete,
                              height: 24,
                              width: 24,
                              color: BaseColor.icon_color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:trendoapp/constants/app_images.dart';
// import 'package:trendoapp/constants/app_textStyle.dart';
// import 'package:trendoapp/constants/base_color.dart';
// import 'package:trendoapp/global/view/global_view.dart';

// // ignore: must_be_immutable
// class ListItemView extends StatelessWidget {
//   // const ListItemView({Key key}) : super(key: key);

//   dynamic list;
//   int itemIndex;
//   VoidCallback onClickLike;
//   ListItemView(
//       {@required this.list,
//       @required this.itemIndex,
//       @required this.onClickLike});
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children: [
//                     // Container(
//                     //   height: 32,
//                     //   width: 32,
//                     //   decoration: BoxDecoration(
//                     //     shape: BoxShape.circle,
//                     //     color: Colors.grey,
//                     //     image: DecorationImage(
//                     //         image: homeFeed
//                     //                     .listFeedInfo[
//                     //                         itemIndex]
//                     //                     .user
//                     //                     .avatar !=
//                     //                 ""
//                     //             ? NetworkImage(
//                     //                 homeFeed
//                     //                     .listFeedInfo[
//                     //                         itemIndex]
//                     //                     .user
//                     //                     .avatar)
//                     //             : AssetImage(AppImages
//                     //                 .default_profile_Pic),
//                     //         fit: BoxFit.cover),
//                     //   ),
//                     // ),
//                     Expanded(
//                       child: Padding(
//                         // padding: EdgeInsets.symmetric(
//                         //     horizontal: 10),
//                         padding: EdgeInsets.only(right: 10),
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               GlobalView().textViewWithStartAlign(
//                                   list[itemIndex].user.firstName == null &&
//                                           list[itemIndex].user.lastName == null
//                                       ? "John Doe"
//                                       : list[itemIndex].user.firstName +
//                                           " " +
//                                           list[itemIndex].user.lastName,
//                                   // "John Doe",
//                                   AppTextStyle.metropolis_font_family,
//                                   AppTextStyle.semi_bold_font_weight,
//                                   BaseColor.black_color,
//                                   12),
//                               GlobalView().textViewWithStartAlign(
//                                   "15 min ago",
//                                   AppTextStyle.metropolis_font_family,
//                                   AppTextStyle.medium_font_weight,
//                                   BaseColor.black_color,
//                                   10),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 24,
//                       width: 24,
//                       child: Image.asset(AppImages.ic_menu),
//                     )
//                   ],
//                 ),
//               ),
//               GlobalView().sizedBoxView(10),
//               Divider(
//                 color: BaseColor.home_divider_color,
//                 height: 2,
//                 thickness: 1,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10, left: 10, right: 10),
//                 child: GlobalView().textViewWithStartAlign(
//                     list[itemIndex].category.name == null
//                         ? "Cafe"
//                         : list[itemIndex].category.name,
//                     // "Cafe",
//                     AppTextStyle.metropolis_font_family,
//                     AppTextStyle.semi_bold_font_weight,
//                     BaseColor.forgot_pass_txt_color,
//                     10),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: GlobalView().textViewWithStartAlign(
//                     list[itemIndex].businessUser.businessName == null
//                         ? "ChoxBlast Cafe"
//                         : list[itemIndex].businessUser.businessName,
//                     // "ChoxBlast Cafe",
//                     AppTextStyle.metropolis_font_family,
//                     AppTextStyle.bold_font_weight,
//                     BaseColor.black_color,
//                     16),
//               ),
//               GlobalView().sizedBoxView(5),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 16,
//                       width: 16,
//                       child: Image.asset(
//                         AppImages.ic_location_black,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.only(left: 7, top: 2),
//                         alignment: Alignment.centerLeft,
//                         child: GlobalView().textViewWithStartAlign(
//                             list[itemIndex].businessUser.businessAddress == null
//                                 ? "Abix Street, Main Road, San Fransisco, California"
//                                 : list[itemIndex].businessUser.businessAddress,
//                             // "Abix Street",
//                             AppTextStyle.metropolis_font_family,
//                             AppTextStyle.medium_font_weight,
//                             BaseColor.black_color.withOpacity(0.6),
//                             12),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               GlobalView().sizedBoxView(5),
//               Visibility(
//                 visible: list[itemIndex].description == "" ? false : true,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Container(
//                     alignment: Alignment.centerLeft,
//                     child: GlobalView().textViewWithStartAlign(
//                         list[itemIndex].description == null
//                             ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut"
//                             : list[itemIndex].description,
//                         // "Lorem ipsum dolor sit amet",
//                         AppTextStyle.inter_font_family,
//                         AppTextStyle.medium_font_weight,
//                         BaseColor.black_color,
//                         12),
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 10, right: 10),
//               //   child: Container(
//               //       alignment: Alignment.centerLeft,
//               //       child: Text(
//               //         "See more",
//               //         style: TextStyle(
//               //           decoration: TextDecoration.underline,
//               //           fontFamily: AppTextStyle.interFontFamily,
//               //           fontWeight: FontWeight.w600,
//               //           fontSize: 12,
//               //           color:
//               //               BaseColor.blackColor.withOpacity(0.5),
//               //         ),
//               //       )),
//               // ),
//               Padding(
//                 padding: EdgeInsets.only(left: 16, right: 16, top: 5),
//                 child: Container(
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           print("LIKE CALLED1");
//                           this.onClickLike();
//                           print("LIKE CALLED2");
//                         },
//                         child: Image.asset(
//                           list[itemIndex].isLiked == 1
//                               ? AppImages.thumbs_up_filled
//                               : AppImages.thumbs_up,
//                           height: 24,
//                           width: 24,
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(left: 10),
//                           child: GlobalView().textViewWithStartAlign(
//                               list[itemIndex].totalLikes.toString() == null
//                                   ? "0"
//                                   : list[itemIndex].totalLikes.toString(),
//                               // "0",
//                               AppTextStyle.metropolis_font_family,
//                               AppTextStyle.medium_font_weight,
//                               BaseColor.black_color.withOpacity(0.5),
//                               12),
//                         ),
//                       ),
//                       // SizedBox(
//                       //   width: 30,
//                       // ),
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     // homeFeed.changeDislikeValue(itemIndex);
//                       //     // homeFeedResponseProvider
//                       //     //     .home_feed_like_dislike(
//                       //     //         context,
//                       //     //         homeFeedResponseProvider
//                       //     //             .listFeedInfo[
//                       //     //                 itemIndex]
//                       //     //             .id
//                       //     //             .toString(),
//                       //     //         "dislike",
//                       //     //         "0",
//                       //     //         homeFeedResponseProvider
//                       //     //                     .listFeedInfo[
//                       //     //                         itemIndex]
//                       //     //                     .isDisliked ==
//                       //     //                 1
//                       //     //             ? "0"
//                       //     //             : "1",
//                       //     //         itemIndex);
//                       //   },
//                       //   child: Image.asset(
//                       //     businessHomeFeedProvider
//                       //                 .listFeedInfo[
//                       //                     itemIndex]
//                       //                 .isDisliked ==
//                       //             1
//                       //         ? AppImages
//                       //             .thumbs_down_filled
//                       //         : AppImages
//                       //             .thumbs_down,
//                       //     height: 24,
//                       //     width: 24,
//                       //   ),
//                       // ),
//                       // Expanded(
//                       //   child: Container(
//                       //      margin: EdgeInsets.only(
//                       //         left: 10),
//                       //     child: GlobalView()
//                       //         .textViewWithStartAlign(
//                       //             businessHomeFeedProvider
//                       //                         .listFeedInfo[
//                       //                             itemIndex]
//                       //                         .totalDislikes
//                       //                         .toString() ==
//                       //                     null
//                       //                 ? "0"
//                       //                 : businessHomeFeedProvider
//                       //                     .listFeedInfo[
//                       //                         itemIndex]
//                       //                     .totalDislikes
//                       //                     .toString(),
//                       //             // "0",
//                       //             AppTextStyle
//                       //                 .metropolisFontFamily,
//                       //             AppTextStyle
//                       //                 .mediumFontWeight,
//                       //             BaseColor
//                       //                 .blackColor
//                       //                 .withOpacity(
//                       //                     0.5),
//                       //             12),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       Image.asset(
//                         AppImages.ic_comments,
//                         height: 24,
//                         width: 24,
//                       ),
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(left: 10),
//                           child: GlobalView().textViewWithStartAlign(
//                               list[itemIndex].totalComments.toString() == null
//                                   ? "5.2k"
//                                   : list[itemIndex].totalComments.toString(),
//                               // "0",
//                               AppTextStyle.metropolis_font_family,
//                               AppTextStyle.medium_font_weight,
//                               BaseColor.black_color.withOpacity(0.5),
//                               12),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 30,
//                       ),
//                       // Image.asset(
//                       //   AppImages.ic_share,
//                       //   height: 24,
//                       //   width: 24,
//                       // ),
//                       // Expanded(
//                       //   child: Container(
//                       //  margin: EdgeInsets.only(left: 10),
//                       //     child: GlobalView()
//                       //         .textViewWithStartAlign(
//                       //             businessHomeFeedProvider
//                       //                         .listFeedInfo[
//                       //                             itemIndex]
//                       //                         .totalShares
//                       //                         .toString() ==
//                       //                     null
//                       //                 ? "150"
//                       //                 : businessHomeFeedProvider
//                       //                     .listFeedInfo[
//                       //                         itemIndex]
//                       //                     .totalShares
//                       //                     .toString(),
//                       //             // "0",
//                       //             AppTextStyle
//                       //                 .metropolisFontFamily,
//                       //             AppTextStyle
//                       //                 .mediumFontWeight,
//                       //             BaseColor
//                       //                 .blackColor
//                       //                 .withOpacity(
//                       //                     0.5),
//                       //             12),
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

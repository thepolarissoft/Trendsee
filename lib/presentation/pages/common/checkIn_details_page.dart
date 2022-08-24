import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/data/models/feed_response.dart';
import 'package:trendoapp/global/view/comments_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/providers/base_response_provider.dart';
import 'package:trendoapp/providers/comment_response_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

// ignore: must_be_immutable
class CheckInDetailsPage extends StatelessWidget {
  FeedResponse feedResponse = new FeedResponse();
  // CheckInDetailsPage(this.feedResponse);
  TextEditingController commentTextEditingController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      feedResponse =
          Provider.of<HomeFeedResponseProvider>(context, listen: false)
              .feedResponse;
      Provider.of<BaseResponseProvider>(context, listen: false)
          .viewFeed(feedResponse.id.toString(), context);
      Provider.of<CommentResponseProvider>(context, listen: false)
          .getCommentList(context, feedResponse.id);
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: AssetImage(AppImages.background_image1),
                    fit: BoxFit.cover),
              ),
              child: Consumer<HomeFeedResponseProvider>(
                  builder: (_, homeFeed, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // GlobalView().sizedBoxView(20),
                    appBarView(context, homeFeed),
                    GlobalView().sizedBoxView(10),
                    Divider(
                      color: BaseColor.home_divider_color,
                      height: 2,
                      thickness: 1,
                    ),
                    GlobalView().sizedBoxView(10),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // alignment: Alignment.center,
                            height: DeviceSize().deviceWidth(context) * 0.14,
                            width: DeviceSize().deviceWidth(context) * 0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: (homeFeed.feedResponse.businessUser!
                                              .avatar !=
                                          ""
                                      ? NetworkImage(homeFeed
                                          .feedResponse.businessUser!.avatar!)
                                      : AssetImage(
                                          AppImages.default_profile_Pic)) as ImageProvider<Object>,
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
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 0),
                                  child: Container(
                                    // alignment: Alignment.center,
                                    child: GlobalView().textViewWithStartAlign(
                                        homeFeed.feedResponse == null &&
                                                homeFeed.feedResponse
                                                        .businessUser ==
                                                    null &&
                                                homeFeed
                                                        .feedResponse
                                                        .businessUser!
                                                        .businessName ==
                                                    null
                                            ? "ChoxBlast Cafe"
                                            : homeFeed.feedResponse.businessUser!
                                                .businessName!,
                                        AppTextStyle.metropolis_font_family,
                                        AppTextStyle.bold_font_weight,
                                        BaseColor.black_color,
                                        16),
                                  ),
                                ),
                                GlobalView().sizedBoxView(2),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0, left: 0, right: 0),
                                  child: Container(
                                    // alignment: Alignment.center,
                                    child: GlobalView().textViewWithStartAlign(
                                        homeFeed.feedResponse == null &&
                                                homeFeed.feedResponse
                                                        .categories ==
                                                    null
                                            ? "Cafe"
                                            : CategoryUtils().getCategoryName(
                                                homeFeed
                                                    .feedResponse.categories!),
                                        AppTextStyle.metropolis_font_family,
                                        AppTextStyle.semi_bold_font_weight,
                                        BaseColor.forgot_pass_txt_color,
                                        10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    GlobalView().sizedBoxView(5),
                    Visibility(
                      visible: homeFeed.feedResponse.businessUser!.isOnline == 0
                          ? false
                          : true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          alignment: Alignment.center,
                          // color: Colors.red,
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                height: 16,
                                width: 16,
                                child: Image.asset(
                                  AppImages.ic_location_black,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                homeFeed.feedResponse.businessUser!.isOnline == 0
                                    ? homeFeed.feedResponse == null &&
                                            homeFeed.feedResponse
                                                    .businessUser ==
                                                null &&
                                            homeFeed.feedResponse.businessUser!
                                                    .businessAddress ==
                                                null
                                        ? "Abix Street, Main Road, San Fransisco, California"
                                        : homeFeed.feedResponse.businessUser!
                                            .businessAddress!
                                    : AppMessages.online_business_text,
                                // "Abix Street, Main Road, San Fransisco, California Abix Street",
                                // textAlign: TextAlign.justify,
                                // textDirection: TextDirection.rtl,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily:
                                      AppTextStyle.metropolis_font_family,
                                  fontWeight: AppTextStyle.medium_font_weight,
                                  color: BaseColor.black_color.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GlobalView().sizedBoxView(5),
                    Visibility(
                      visible: homeFeed.feedResponse.description == ""
                          ? false
                          : true,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          alignment: Alignment.center,
                          child: GlobalView().textViewWithCenterAlign(
                              homeFeed.feedResponse == null &&
                                      homeFeed.feedResponse.description == null
                                  ? "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt"
                                  : homeFeed.feedResponse.description!,
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.black_color,
                              12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Container(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<BaseResponseProvider>(context,
                                        listen: false)
                                    .clickFeed(
                                        feedResponse.id.toString(), context);
                                homeFeed.checkInDetailsLike(
                                  context,
                                  homeFeed.feedResponse.id,
                                  homeFeed.feedResponse.isLiked == 1 ? 0 : 1,
                                );
                              },
                              child: Image.asset(
                                homeFeed.feedResponse.isLiked == 1
                                    ? AppImages.thumbs_up_filled
                                    : AppImages.thumbs_up,
                                height: 24,
                                width: 24,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: GlobalView().textViewWithStartAlign(
                                    homeFeed.feedResponse == null &&
                                            homeFeed.feedResponse.totalLikes ==
                                                null
                                        ? "10.5k"
                                        : homeFeed.feedResponse.totalLikes
                                            .toString(),
                                    AppTextStyle.metropolis_font_family,
                                    AppTextStyle.medium_font_weight,
                                    BaseColor.black_color.withOpacity(0.5),
                                    12),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     homeFeed.feed_detail_like_dislike(
                            //         context,
                            //         homeFeed.feedResponse.id.toString(),
                            //         "0",
                            //         homeFeed.feedResponse.isDisliked == 1
                            //             ? "0"
                            //             : "1",
                            //         // homeFeed.feedResponse,
                            //         "dislike");
                            //   },
                            //   child: Image.asset(
                            //     homeFeed.feedResponse.isDisliked == 1
                            //         ? AppImages.thumbs_down_filled
                            //         : AppImages.thumbs_down,
                            //     height: 24,
                            //     width: 24,
                            //   ),
                            // ),
                            // Expanded(
                            //   child: Container(
                            //      margin: EdgeInsets.only(left: 10),
                            //     child: GlobalView().textViewWithStartAlign(
                            //         homeFeed.feedResponse == null &&
                            //                 homeFeed.feedResponse
                            //                         .totalDislikes ==
                            //                     null
                            //             ? "10.5k"
                            //             : homeFeed.feedResponse.totalDislikes
                            //                 .toString(),
                            //         AppTextStyle.metropolisFontFamily,
                            //         AppTextStyle.mediumFontWeight,
                            //         BaseColor.blackColor.withOpacity(0.5),
                            //         12),
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
                                child: Consumer<CommentResponseProvider>(
                                    builder: (_, p, child) {
                                  return GlobalView().textViewWithStartAlign(
                                      homeFeed.feedResponse == null &&
                                              homeFeed.feedResponse
                                                      .totalComments ==
                                                  null
                                          ? "10.5k"
                                          : homeFeed.feedResponse.totalComments
                                              .toString(),
                                      AppTextStyle.metropolis_font_family,
                                      AppTextStyle.medium_font_weight,
                                      BaseColor.black_color.withOpacity(0.5),
                                      12);
                                }),
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
                            //     child: GlobalView().textViewWithStartAlign(
                            //         homeFeed.feedResponse == null &&
                            //                 homeFeed.feedResponse.totalShares ==
                            //                     null
                            //             ? "10.5k"
                            //             : homeFeed.feedResponse.totalShares
                            //                 .toString(),
                            //         AppTextStyle.metropolisFontFamily,
                            //         AppTextStyle.mediumFontWeight,
                            //         BaseColor.blackColor.withOpacity(0.5),
                            //         12),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    GlobalView().sizedBoxView(10),
                    Divider(
                      color: BaseColor.home_divider_color,
                      height: 2,
                      thickness: 1,
                    ),
                    // followBusinessView(context,homeFeed),
                    // Visibility(
                    //   visible:
                    //       StorageUtils.readIntValue(StorageUtils.keyUserType) ==
                    //               1
                    //           ? true
                    //           : false,
                    //   child: Padding(
                    //     padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                    //     child: GlobalView().textViewWithStartAlign(
                    //         "Comments",
                    //         AppTextStyle.lato_font_family,
                    //         AppTextStyle.semi_bold_font_weight,
                    //         BaseColor.black_color,
                    //         18),
                    //   ),
                    // ),
                    // GlobalView().sizedBoxView(10),
                    // Visibility(
                    //   visible:
                    //       StorageUtils.readIntValue(StorageUtils.keyUserType) ==
                    //               1
                    //           ? true
                    //           : false,
                    //   child: commentListView(),
                    // ),
                    GlobalView().sizedBoxView(10),
                  ],
                );
              }),
            ),
          ),
          // Visibility(
          //     visible: StorageUtils.readIntValue(StorageUtils.keyUserType) == 1
          //         ? true
          //         : false,
          //     child: commentTextFieldView(context)),
        ],
      ),
    );
  }

  Widget appBarView(BuildContext context, HomeFeedResponseProvider homeFeed) =>
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 5,
                right: 10,
                top: 2,
                bottom: 2,
              ),
              // color: Colors.red,
              height: 40,
              width: 40,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: GlobalView().assetImageView(AppImages.ic_back)),
            ),
            // SizedBox(
            //   width: 16,
            // ),
            // Container(
            //     height: 32,
            //     width: 32,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.grey,
            //       image: DecorationImage(
            //         image: homeFeed.feedResponse.user.avatar != null
            //             ? NetworkImage(homeFeed.feedResponse.user.avatar)
            //             : AssetImage(AppImages.default_profile_Pic),
            //         fit: BoxFit.cover,
            //       ),
            //     )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GlobalView().textViewWithStartAlign(
                          homeFeed.feedResponse == null &&
                                  homeFeed.feedResponse.user == null &&
                                  homeFeed.feedResponse.user!.username == null
                              //      &&
                              // homeFeed.feedResponse.user.lastName == null
                              ? "John Doe"
                              : homeFeed.feedResponse.user!.username!
                          // +
                          //     " " +
                          //     homeFeed.feedResponse.user.lastName
                          ,
                          AppTextStyle.metropolis_font_family,
                          AppTextStyle.semi_bold_font_weight,
                          BaseColor.black_color,
                          12),
                      GlobalView().textViewWithStartAlign(
                          // "15 min ago",
                          DayTimeUtils()
                              .convertToAgo(homeFeed.feedResponse.createdAt!),
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
            ),
          ],
        ),
      );

  Widget followBusinessView(
      BuildContext context, HomeFeedResponseProvider homeFeed) {
    return Consumer<SearchByBusinessProvider>(builder: (_, provider, child) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Provider.of<BaseResponseProvider>(context, listen: false)
                      .clickFeed(feedResponse.id.toString(), context);
                  if (provider.listBusiness.isNotEmpty) {
                    // provider.selectedBusinessItem(homeFeed.feedResponse);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BusinessDetailsScreen(
                        businessId: feedResponse.businessUserId,
                      ),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    child: GlobalView().wrappedButtonFilledView(
                        context, AppMessages.view_business_text),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     margin: const EdgeInsets.only(left: 10, right: 20),
            //     // child:
            //     //     GlobalView().buttonFilled(context, AppMessages.follow_text),
            //   ),
            // ),
          ],
        ),
      );
    });
  }

  Widget commentListView() =>
      Consumer<CommentResponseProvider>(builder: (_, commentProvider, child) {
        return !commentProvider.isLoading
            ? Container(
                child: Expanded(
                  child: Container(
                    // color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          itemCount: commentProvider.listComments.length,
                          // shrinkWrap: true,
                          itemBuilder: (context, itemIndex) {
                            return CommentsView(
                              commentResponse:
                                  commentProvider.listComments[itemIndex],
                            );
                          }),
                    ),
                  ),
                ),
              )
            : Center(
                child: Container(
                  // color: BaseColor.loader_bg_color,
                  child: GlobalView().loaderView(),
                ),
              );
      });

  Widget commentTextFieldView(BuildContext context) =>
      Consumer<CommentResponseProvider>(builder: (_, commentProvider, child) {
        return Material(
          shadowColor: BaseColor.shadow_color,
          // elevation: 4,
          // decoration: BoxDecoration(
          //   boxShadow: [BoxShadow(color: BaseColor.shadowColor, blurRadius: 5)],
          // ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Container(
              alignment: Alignment.bottomCenter,
              // color: Colors.red,
              child: TextField(
                cursorColor: BaseColor.black_color,
                controller: commentTextEditingController,
                decoration: InputDecoration(
                  focusColor: BaseColor.pure_white_color,
                  contentPadding: EdgeInsets.only(left: 20, right: 15),
                  // prefixIcon: prefixIconView(image),
                  //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Provider.of<BaseResponseProvider>(context, listen: false)
                          .clickFeed(feedResponse.id.toString(), context);
                      print('object');
                      if (commentTextEditingController.text.isNotEmpty) {
                        Provider.of<CommentResponseProvider>(context,
                                listen: false)
                            .createComment(context, feedResponse.id,
                                commentTextEditingController.text);
                        commentTextEditingController.text = "";
                      } else {
                        GlobalView()
                            .showToast(AppToastMessages.empty_comment_message);
                      }
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            gradient: LinearGradient(colors: [
                              BaseColor.btn_gradient_start_color1,
                              BaseColor.btn_gradient_end_color1
                            ]),
                            boxShadow: [
                              BoxShadow(
                                  color: BaseColor.shadow_color, blurRadius: 5)
                            ]
                            // image: DecorationImage(
                            //     image: AssetImage(AppImages.ic_sort), fit: BoxFit.fill)
                            ),
                        child: Icon(
                          Icons.send,
                          color: BaseColor.pure_white_color,
                          size: 20,
                        )),
                  ),
                  // suffixIconView(
                  //     context, commentTextEditingController.text),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(color: BaseColor.border_txtfield_color),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: BaseColor.border_txtfield_color)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: BaseColor.border_txtfield_color)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: BaseColor.border_txtfield_color)),
                  hintText: "Post comment",
                  hintStyle: TextStyle(
                    color: BaseColor.hint_color.withOpacity(0.6),
                    fontFamily: AppTextStyle.inter_font_family,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      });

  // Widget suffixIconView(BuildContext context, String comment) =>
  //     GestureDetector(
  //       onTap: () {
  //         print('object');
  //         Provider.of<BaseResponseProvider>(context, listen: false)
  //             .clickFeed(feedResponse.id.toString(), context);
  //         if (comment.isNotEmpty) {
  //           Provider.of<CommentResponseProvider>(context, listen: false)
  //               .createComment(context, feedResponse.id, comment);
  //         } else {
  //           GlobalView().showToast(AppToastMessages.empty_comment_message);
  //         }
  //       },
  //       child: Container(
  //           height: 40,
  //           width: 40,
  //           decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: Colors.green,
  //               gradient: LinearGradient(colors: [
  //                 BaseColor.btn_gradient_start_color1,
  //                 BaseColor.btn_gradient_end_color1
  //               ]),
  //               boxShadow: [
  //                 BoxShadow(color: BaseColor.shadow_color, blurRadius: 5)
  //               ]
  //               // image: DecorationImage(
  //               //     image: AssetImage(AppImages.ic_sort), fit: BoxFit.fill)
  //               ),
  //           child: Icon(
  //             Icons.send,
  //             color: BaseColor.pure_white_color,
  //             size: 20,
  //           )),
  //     );
}

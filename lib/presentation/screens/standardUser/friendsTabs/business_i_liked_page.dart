import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/business_liked_list_response.dart';
import 'package:trendoapp/global/view/business_item_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/header_view.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/business_details_screen.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/dialog_utils.dart';

// ignore: must_be_immutable
class BusinessLikedPage extends StatefulWidget {
  @override
  _BusinessLikedPageState createState() => _BusinessLikedPageState();
}

class _BusinessLikedPageState extends State<BusinessLikedPage> {
  int page = 1;
  ScrollController scrollController = new ScrollController();
  TextEditingController reasonEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<SearchByBusinessProvider>(context, listen: false)
          .getBusinessLikedList(context, page);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreLikedData();
      }
    });
  }

  FutureOr onCallBack(var value) {
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .listBusiness
        .clear();
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .getBusinessLikedList(context, page);
    print(
      "Length" +
          Provider.of<SearchByBusinessProvider>(context, listen: false)
              .listBusiness
              .length
              .toString(),
    );
  }

  void getMoreLikedData() {
    BusinessLikedListResponse businessLikedListResponse =
        Provider.of<SearchByBusinessProvider>(context, listen: false)
            .businessLikedListResponse;
    print("businessLikedListResponse-> $businessLikedListResponse");
    if (businessLikedListResponse != null &&
        businessLikedListResponse.place != null &&
        businessLikedListResponse.place.nextPageUrl != null) {
      page++;
      Provider.of<SearchByBusinessProvider>(context, listen: false)
          .getBusinessLikedList(context, page);
    } else {
      GlobalView().showToast("No more data available!");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<CategoriesListProvider>(context, listen: false)
    //     .selectedCategoryData
    //     .name = "All";
    return
        // padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child:
              HeaderView(AppMessages.businesses_i_like_title, "businesslikes"),
        ),
        // GlobalView().sizedBoxView(5),
        // CategoryView(page,"businesslikes"),
        GlobalView().sizedBoxView(10),
        Expanded(
          child: Container(
            child: likedBusinessListView(context),
          ),
        ),
      ],
    );
  }

  Widget likedBusinessListView(BuildContext context) =>
      Consumer<SearchByBusinessProvider>(builder: (_, provider, child) {
        return Stack(
          children: [
            provider.listBusiness.isNotEmpty
                ? MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: provider.listBusiness.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (provider.listBusiness.isNotEmpty) {
                                  // provider.selectedBusinessItem(
                                  //     provider.listBusiness[index]);
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessDetailsScreen(
                                              businessId: provider
                                                  .listBusiness[index].id,
                                            ))).then(onCallBack);
                              },
                              child: BusinessItemView(
                                verifiedUserResponse:
                                    provider.listBusiness[index],
                                onClickLikeButton: () {
                                  if (provider.listBusiness[index].isLiked ==
                                      1) {
                                    // DialogUtils().onClickLikedBusiness(
                                    //     context,
                                    //     provider,
                                    //     index,
                                    //     "businessilike",
                                    //     provider.listBusiness[index].id);
                                    DialogUtils.displayDislikeDialog(
                                      context,
                                      reasonEditingController,
                                      () {
                                         if (reasonEditingController
                                                    .text.isNotEmpty) {
                                        provider.dislikeBusiness(
                                            context,
                                            provider.listBusiness[index],
                                            reasonEditingController.text,
                                            1,
                                            "businessilike");
                                            } else if (reasonEditingController
                                            .text.isEmpty) {
                                          GlobalView().showToast(
                                              AppToastMessages
                                                  .valid_reason_message);
                                        }
                                      },
                                    );
                                  }
                                },
                              ));
                        },
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: GlobalView().textViewWithCenterAlign(
                          AppMessages.no_business_liked_text,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.bold_font_weight,
                          BaseColor.black_color,
                          18),
                    ),
                  ),
            Visibility(
              visible:
                  Provider.of<SearchByBusinessProvider>(context, listen: false)
                      .isLoading,
              child: Container(
                color: BaseColor.home_bg_color,
                child: GlobalView().loaderView(),
              ),
            ),
          ],
        );
      });
}



 //    Card(
                          //     elevation: 2,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(12),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(
                          //           left: 8, right: 8, top: 8, bottom: 8),
                          //       child: Row(
                          //         children: [
                          //           Expanded(
                          //             flex: 1,
                          //             child: Container(
                          //               height: 74,
                          //               // width: 75,
                          //               decoration: BoxDecoration(
                          //                 // color: Colors.red,
                          //                 borderRadius:
                          //                     BorderRadius.circular(8),
                          //                 // image: DecorationImage(
                          //                 //     image: AssetImage(
                          //                 //       AppImages.photo3,
                          //                 //     ),
                          //                 //     fit: BoxFit.cover),
                          //               ),
                          //               child: ClipRRect(
                          //                 borderRadius:
                          //                     BorderRadius.circular(8),
                          //                 child: provider.listBusiness[index]
                          //                             .businessMedia[0].media !=
                          //                         null
                          //                     ? FadeInImage.assetNetwork(
                          //                         placeholder: AppImages
                          //                             .loader_gif_removeBG,
                          //                         image: provider
                          //                             .listBusiness[index]
                          //                             .businessMedia[0]
                          //                             .media,
                          //                         fit: BoxFit.cover)
                          //                     : Image.asset(AppImages.photo3,
                          //                         fit: BoxFit.cover),
                          //               ),
                          //             ),
                          //           ),
                          //           Expanded(
                          //             flex: 3,
                          //             child: Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 15, right: 15),
                          //               child: Container(
                          //                 // color: Colors.red,
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Row(
                          //                       children: [
                          //                         Expanded(
                          //                           child: GlobalView()
                          //                               .textViewWithStartAlign(
                          //                                   // "ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe ChoxBlast Cafe",
                          //                                   provider
                          //                                               .listBusiness[
                          //                                                   index]
                          //                                               .businessName !=
                          //                                           null
                          //                                       ? provider
                          //                                           .listBusiness[
                          //                                               index]
                          //                                           .businessName
                          //                                       : "ChoxBlast Cafe",
                          //                                   AppTextStyle
                          //                                       .inter_font_family,
                          //                                   AppTextStyle
                          //                                       .semi_bold_font_weight,
                          //                                   BaseColor
                          //                                       .divider_color,
                          //                                   14),
                          //                         ),
                          //                         GestureDetector(
                          //                           onTap: () {
                          //                             if (provider
                          //                                     .listBusiness[
                          //                                         index]
                          //                                     .isLiked ==
                          //                                 1) {
                          //                               DialogUtils()
                          //                                   .onClickLikedBusiness(
                          //                                       context,
                          //                                       provider,
                          //                                       index,
                          //                                       "businessilike",
                          //                                       provider
                          //                                           .listBusiness[
                          //                                               index]
                          //                                           .id);
                          //                             }
                          //                           },
                          //                           child: Container(
                          //                             padding:
                          //                                 EdgeInsets.symmetric(
                          //                                     horizontal: 12,
                          //                                     vertical: 5),
                          //                             decoration: GlobalView()
                          //                                 .gradientDecorationView(
                          //                                     BaseColor
                          //                                         .forgot_pass_txt_color,
                          //                                     BaseColor
                          //                                         .forgot_pass_txt_color),
                          //                             child: GlobalView().textViewWithStartAlign(
                          //                                 provider
                          //                                             .listBusiness[
                          //                                                 index]
                          //                                             .isLiked ==
                          //                                         1
                          //                                     ? AppMessages
                          //                                         .liked_text
                          //                                     : AppMessages
                          //                                         .like_text,
                          //                                 AppTextStyle
                          //                                     .inter_font_family,
                          //                                 AppTextStyle
                          //                                     .normal_font_weight,
                          //                                 BaseColor
                          //                                     .pure_white_color,
                          //                                 10),
                          //                           ),
                          //                         )
                          //                       ],
                          //                     ),
                          //                     GlobalView().sizedBoxView(3),
                          //                     GlobalView()
                          //                         .textViewWithStartAlign(
                          //                             provider
                          //                                         .listBusiness[
                          //                                             index]
                          //                                         .category
                          //                                         .name !=
                          //                                     null
                          //                                 ? provider
                          //                                     .listBusiness[
                          //                                         index]
                          //                                     .category
                          //                                     .name
                          //                                 : "Reastaurant",
                          //                             AppTextStyle
                          //                                 .inter_font_family,
                          //                             AppTextStyle
                          //                                 .medium_font_weight,
                          //                             BaseColor
                          //                                 .forgot_pass_txt_color,
                          //                             12),
                          //                     GlobalView().sizedBoxView(5),
                          //                     Row(
                          //                       children: [
                          //                         Image.asset(
                          //                           AppImages.ic_location_black,
                          //                           height: 16,
                          //                           width: 12,
                          //                         ),
                          //                         Expanded(
                          //                           child: GlobalView().textViewWithStartAlign(
                          //                               provider
                          //                                           .listBusiness[
                          //                                               index]
                          //                                           .businessAddress !=
                          //                                       null
                          //                                   ? provider
                          //                                       .listBusiness[
                          //                                           index]
                          //                                       .businessAddress
                          //                                   : "San Fransisco, California, USA",
                          //                               AppTextStyle
                          //                                   .inter_font_family,
                          //                               AppTextStyle
                          //                                   .medium_font_weight,
                          //                               BaseColor.divider_color,
                          //                               10),
                          //                         ),
                          //                       ],
                          //                     )
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/check_ins_item_view.dart';
import 'package:trendoapp/global/view/common_gradient_button.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/standardUser/add_new_check_in_page.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/add_new_check_support_screen.dart';
import 'package:trendoapp/presentation/screens/standardUser/friendsTabs/feeds_description_screen.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/category_utils.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class BusinessDetailsScreen extends StatefulWidget {
  int? businessId;
  BusinessDetailsScreen({required this.businessId});
  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  List<String> listImages = [
    AppImages.photo3,
    AppImages.photo3,
    AppImages.photo3,
  ];
  TextEditingController reasonEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    Provider.of<SearchByBusinessProvider>(context, listen: false).businessDetails(context, widget.businessId);
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // Provider.of<SearchByBusinessProvider>(context, listen: false)
    //     .businessDetailsResponse = null;
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Container(
      color: BaseColor.pure_white_color,
      child: SafeArea(
        top: false,
        bottom: true,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: WillPopScope(
            onWillPop: () async {
              Provider.of<SearchByBusinessProvider>(context, listen: false).businessDetailsResponse = null;
              return true;
            },
            child: Scaffold(
              backgroundColor: BaseColor.pure_white_color,
              body: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.background_image1), fit: BoxFit.cover),
                ),
                child: Consumer<SearchByBusinessProvider>(builder: (_, provider, child) {
                  if (!provider.isLoading) {
                    // print(
                    //     "is website valid-> ${Uri.parse(provider.businessDetailsResponse.business.businessWebsite).isAbsolute}");
                    // print(
                    //     "is website valid2-> ${Uri.parse("https://test.com").isAbsolute}");
                    return Stack(
                      children: [
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              automaticallyImplyLeading: false,
                              backgroundColor: BaseColor.pure_white_color,
                              expandedHeight: DeviceSize().deviceWidth(context) / 2 + 50,
                              // pinned: true,
                              // floating: false,
                              /// TOP IMAGES IS RENDER FROM HERE,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Container(
                                  child: provider.listMediaImages.length == 1
                                      ? GestureDetector(
                                          onTap: () {
                                            if (provider.listMediaImages.isNotEmpty || provider.listMediaImages != null) {
                                              if (provider.businessDetailsResponse!.business!.linkAd != '' &&
                                                  provider.businessDetailsResponse!.business!.linkAd != null &&
                                                  provider.businessDetailsResponse!.business!.linkAd!.isNotEmpty) {
                                                if (provider.businessDetailsResponse!.business!.linkAd!.contains('http') || provider.businessDetailsResponse!.business!.linkAd!.contains('https')) {
                                                  UrlLauncher().launchUrl(provider.businessDetailsResponse!.business!.linkAd!);
                                                } else if (provider.businessDetailsResponse!.business!.linkAd!.toLowerCase().contains('www')) {
                                                  UrlLauncher().launchUrl('https://${provider.businessDetailsResponse!.business!.linkAd!}');
                                                } else if (provider.businessDetailsResponse!.business!.linkAd!.contains(RegExp(r'^[0-9]+$'))) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) => BusinessDetailsScreen(businessId: int.parse(provider.businessDetailsResponse!.business!.linkAd!)),
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          child: FadeInImage.assetNetwork(
                                            placeholder: AppImages.loader_gif_removeBG,
                                            image: provider.listMediaImages[0]!,
                                            fit: BoxFit.cover,
                                            height: DeviceSize().deviceWidth(context) / 2 + 50,
                                            width: DeviceSize().deviceWidth(context),
                                          ),
                                        )
                                      : CarouselSlider(
                                          items: provider.listMediaImages
                                              .map(
                                                (item) => GestureDetector(
                                                  onTap: () {
                                                    if (provider.listMediaImages.isNotEmpty || provider.listMediaImages != null) {
                                                      if (provider.businessDetailsResponse!.business!.linkAd != '' &&
                                                          provider.businessDetailsResponse!.business!.linkAd != null &&
                                                          provider.businessDetailsResponse!.business!.linkAd!.isNotEmpty) {
                                                        if (provider.businessDetailsResponse!.business!.linkAd!.contains('http') ||
                                                            provider.businessDetailsResponse!.business!.linkAd!.contains('https')) {
                                                          UrlLauncher().launchUrl(provider.businessDetailsResponse!.business!.linkAd!);
                                                        } else if (provider.businessDetailsResponse!.business!.linkAd!.toLowerCase().contains('www')) {
                                                          UrlLauncher().launchUrl('https://${provider.businessDetailsResponse!.business!.linkAd!}');
                                                        } else if (provider.businessDetailsResponse!.business!.linkAd!.contains(RegExp(r'^[0-9]+$'))) {
                                                          Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) => BusinessDetailsScreen(businessId: int.parse(provider.businessDetailsResponse!.business!.linkAd!)),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: AppImages.loader_gif_removeBG,
                                                    image: item!,
                                                    fit: BoxFit.cover,
                                                    height: DeviceSize().deviceWidth(context) / 2 + 50,
                                                    width: DeviceSize().deviceWidth(context),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          //       CachedNetworkImage(
                                          //     placeholder: (context, url) => Container(
                                          //       color: Colors.red,
                                          //       height: 50,
                                          //       width: 50,
                                          //       child: Lottie.asset(
                                          //           AppImages.loader_gif_json,
                                          //           height: 50,
                                          //           width: 50),
                                          //     ),
                                          //     imageUrl: item,
                                          //     fit: BoxFit.cover,
                                          //     height: 300,
                                          //     width: ScreenSize().screenWidth(context),
                                          //   ),
                                          // )
                                          // .toList(),
                                          options: CarouselOptions(
                                            viewportFraction: 1,
                                            aspectRatio: 1,
                                            autoPlay: true,
                                            autoPlayAnimationDuration: Duration(milliseconds: 1500),
                                            autoPlayInterval: Duration(seconds: 5),
                                            autoPlayCurve: Curves.ease,
                                            onPageChanged: (index, season) {
                                              provider.setCurrentIndex(index);
                                            },
                                          ),
                                        ),
                                ),
                              ),
                              leading: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Provider.of<SearchByBusinessProvider>(context, listen: false).businessDetailsResponse = null;
                                  },
                                  child: Container(
                                    child: Image.asset(
                                      AppImages.ic_back_filled,
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
                                      provider.businessDetailsResponse != null &&
                                              provider.businessDetailsResponse!.business != null &&
                                              provider.businessDetailsResponse!.business!.businessName!.length > 0
                                          ? provider.businessDetailsResponse!.business!.businessName!
                                          : "ChoxBlast Cafe",
                                      // "ChoxBlast Cafe",
                                      AppTextStyle.inter_font_family,
                                      AppTextStyle.bold_font_weight,
                                      BaseColor.black_color,
                                      20),
                                  GlobalView().sizedBoxView(5),
                                  GlobalView().textViewWithCenterAlign(
                                      provider.businessDetailsResponse != null || provider.businessDetailsResponse!.business!.categories != null
                                          ? CategoryUtils().getCategoryName(provider.businessDetailsResponse!.business!.categories!)
                                          : "Restaurant",
                                      // "Restaurant",
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
                                  // GlobalView().sizedBoxView(10),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Column(
                                  //         children: [
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               provider.
                                  // .totalViews
                                  //                           .toString() !=
                                  //                       null
                                  //                   ? provider
                                  //                       .selectedBusinessResponse.totalViews
                                  //                       .toString()
                                  //                   : "0",
                                  //               // "0",
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.bold_font_weight,
                                  //               BaseColor.black_color,
                                  //               20),
                                  //           GlobalView().sizedBoxView(5),
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               AppMessages.views_text,
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.medium_font_weight,
                                  //               BaseColor.selected_tab_color,
                                  //               12),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Column(
                                  //         children: [
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               provider.selectedBusinessResponse.totalLikes
                                  //                           .toString() !=
                                  //                       null
                                  //                   ? provider
                                  //                       .selectedBusinessResponse.totalLikes
                                  //                       .toString()
                                  //                   : "0",
                                  //               // "0",
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.bold_font_weight,
                                  //               BaseColor.black_color,
                                  //               20),
                                  //           GlobalView().sizedBoxView(5),
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               AppMessages.likes_text,
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.medium_font_weight,
                                  //               BaseColor.selected_tab_color,
                                  //               12),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Column(
                                  //         children: [
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               provider.selectedBusinessResponse.totalClick
                                  //                           .toString() !=
                                  //                       null
                                  //                   ? provider
                                  //                       .selectedBusinessResponse.totalClick
                                  //                       .toString()
                                  //                   : "0",
                                  //               // "0",
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.bold_font_weight,
                                  //               BaseColor.black_color,
                                  //               20),
                                  //           GlobalView().sizedBoxView(5),
                                  //           GlobalView().textViewWithCenterAlign(
                                  //               AppMessages.click_text,
                                  //               AppTextStyle.inter_font_family,
                                  //               AppTextStyle.medium_font_weight,
                                  //               BaseColor.selected_tab_color,
                                  //               12),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  GlobalView().sizedBoxView(15),
                                  GlobalView().dividerView(),
                                  Visibility(
                                    visible: provider.businessDetailsResponse!.business!.isMobile == 0 && provider.businessDetailsResponse!.business!.isOnline == 0,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      child: GlobalView().textViewWithCenterAlign(AppMessages.thisPlaceIsWithin + provider.businessDetailsResponse!.business!.distance! + AppMessages.miles_from_text,
                                          AppTextStyle.inter_font_family, AppTextStyle.semi_bold_font_weight, BaseColor.forgot_pass_txt_color, 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              print("Like clicked");
                                              if (provider.businessDetailsResponse!.business!.isLiked == 0) {
                                                provider.likeBusiness(context, provider.businessDetailsResponse!.business!);
                                              }
                                              // else {
                                              //   DialogUtils().onClickLikedBusiness(
                                              //       context,
                                              //       provider,
                                              //       0,
                                              //       "details",
                                              //       provider.businessDetailsResponse.business.id);
                                              // }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 0),
                                              child: AbsorbPointer(
                                                absorbing: provider.businessDetailsResponse!.business!.isLiked == 1 ? true : false,
                                                child: GlobalView().wrappedButtonViewWithImage(
                                                  context,
                                                  Image.asset(
                                                    provider.businessDetailsResponse!.business!.isLiked == 1 ? AppImages.thumbs_up_filled : AppImages.thumbs_up,
                                                    height: 40,
                                                    width: 40,
                                                    // ? GlobalView().buttonRoundedBorder(
                                                    //     context, AppMessages.liked_text)
                                                    // : GlobalView().smallSizeButtonFilled(
                                                    //     context,
                                                    //     // AppMessages.follow_text.substring(1),
                                                    //     AppMessages.like_text
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //    GlobalView().textViewWithCenterAlign(
                                        //  AppMessages.like_text,
                                        //   // "Restaurant",
                                        //   AppTextStyle.inter_font_family,
                                        //   AppTextStyle.medium_font_weight,
                                        //   BaseColor.forgot_pass_txt_color,
                                        //   16),
                                        SizedBox(width: 20),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (provider.businessDetailsResponse!.business!.isDisliked == 0) {
                                                DialogUtils.displayDislikeDialog(
                                                  context,
                                                  reasonEditingController,
                                                  () {
                                                    if (reasonEditingController.text.isNotEmpty) {
                                                      provider.dislikeBusiness(context, provider.businessDetailsResponse!.business!, reasonEditingController.text, 1, "");
                                                    } else if (reasonEditingController.text.isEmpty) {
                                                      GlobalView().showToast(AppToastMessages.valid_reason_message);
                                                    }
                                                  },
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 0),
                                              child: AbsorbPointer(
                                                absorbing: provider.businessDetailsResponse!.business!.isDisliked == 1 ? true : false,
                                                child: GlobalView().wrappedButtonViewWithImage(
                                                  context,
                                                  Image.asset(
                                                    provider.businessDetailsResponse!.business!.isDisliked == 1 ? AppImages.thumbs_down_filled : AppImages.thumbs_down,
                                                    height: 40,
                                                    width: 40,
                                                    // ? GlobalView().buttonRoundedBorder(
                                                    //     context, AppMessages.disliked_text)
                                                    // : GlobalView().smallSizeButtonFilled(
                                                    //     context, AppMessages.dislike_text),
                                                    // GlobalView().smallSizeButtonFilled(
                                                    //     context,
                                                    //     AppMessages.has_bad_experience_msg
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(20),
                                  // support button
                                  GestureDetector(
                                    onTap: () {
                                      print(provider.businessDetailsResponse!.business!.businessName);
                                      print(CategoryUtils().getCategoryName(provider.businessDetailsResponse!.business!.categories!));
                                      print(provider.businessDetailsResponse!.business!.id);
                                      print(CategoryUtils().getCategoryId(provider.businessDetailsResponse!.business!.categories!));
                                      print(provider.businessDetailsResponse!.business!.latitude);
                                      print(provider.businessDetailsResponse!.business!.longitude);
                                      print(provider.businessDetailsResponse!.business!.locationName);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddNewCheckSupportScreen(
                                            businessId: provider.businessDetailsResponse!.business!.id ?? 0,
                                            categoriesId: CategoryUtils().getCategoryId(provider.businessDetailsResponse!.business!.categories!),
                                            businessLatitude: provider.businessDetailsResponse!.business!.latitude!,
                                            businessLongitude: provider.businessDetailsResponse!.business!.longitude!,
                                            businessLocationName: provider.businessDetailsResponse!.business!.locationName ?? '',
                                            businessName: provider.businessDetailsResponse!.business!.businessName ?? '',
                                            categoriesName: CategoryUtils().getCategoryName(provider.businessDetailsResponse!.business!.categories!),
                                            isScreenChange: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: GlobalView().wrappedButtonFilledView(context, AppMessages.supportText),
                                  ),
                                  GlobalView().sizedBoxView(20),
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(horizontal: 30),
                                  //   child: GestureDetector(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (_) => DislikedReviewCommentScreen(
                                  //             businessId: provider
                                  //                 .businessDetailsResponse.business.id,
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //     child: GlobalView().smallSizeButtonFilled(
                                  //         context, AppMessages.review_commnets_text),
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
                                  //        provider.selectedBusinessResponse
                                  //                       .toString() !=
                                  //                   null
                                  //               ? provider.profileResponse.user.totalLikes
                                  //                   .toString()
                                  //               : "0",
                                  //         // "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut… See more",
                                  //         AppTextStyle.interFontFamily,
                                  //         AppTextStyle.mediumFontWeight,
                                  //         BaseColor.blackColor,
                                  //         12),
                                  //   ),
                                  // ),
                                  // GlobalView().sizedBoxView(20),
                                  Visibility(
                                    visible: provider.businessDetailsResponse!.business!.businessWebsite != null && provider.businessDetailsResponse!.business!.businessWebsite != "" ? true : false,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: GlobalView().textViewWithStartAlign(
                                                AppMessages.hint_business_website, AppTextStyle.inter_font_family, AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 16),
                                          ),
                                          GlobalView().sizedBoxView(5),
                                          GestureDetector(
                                            // onTap: () async {
                                            //   String url = provider
                                            //       .businessDetailsResponse
                                            //       .business
                                            //       .businessWebsite;
                                            //   UrlLauncher().launchUrl(url);
                                            // },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: GlobalView().textViewWithStartAlign(
                                                  provider.businessDetailsResponse!.business!.businessWebsite != null ? provider.businessDetailsResponse!.business!.businessWebsite! : "0",
                                                  AppTextStyle.inter_font_family,
                                                  AppTextStyle.medium_font_weight,
                                                  BaseColor.black_color,
                                                  14),
                                            ),
                                          ),
                                          GlobalView().sizedBoxView(10),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint('*-*-*${provider.businessDetailsResponse!.business!.currentPlan}');
                                              if (provider.businessDetailsResponse!.business!.currentPlan!.toLowerCase() == AppMessages.freeText) {
                                                DialogUtils.displayDialogCallBack(context, "", "", AppMessages.featureNotAvailableMsg, "", AppMessages.ok_text, "");
                                              } else {
                                                String url = provider.businessDetailsResponse!.business!.businessWebsite!;
                                                UrlLauncher().launchUrl(url);
                                              }
                                            },
                                            child: GlobalView().wrappedButtonFilledView(context, AppMessages.visit_site_text),
                                          ),
                                          GlobalView().sizedBoxView(20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GlobalView().textViewWithStartAlign(
                                          AppMessages.hint_business_phone_number, AppTextStyle.inter_font_family, AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 16),
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GlobalView().textViewWithStartAlign(
                                          provider.businessDetailsResponse!.business!.businessPhone != null
                                              ? provider.businessDetailsResponse!.business!.businessPhone!.replaceAll("-", "")
                                              : "+1 (525) 6564 8914",
                                          // "+1 (525) 6564 8914",
                                          AppTextStyle.inter_font_family,
                                          AppTextStyle.medium_font_weight,
                                          BaseColor.black_color,
                                          14),
                                  
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(10),
                                  GestureDetector(
                                    onTap: () async {
                                      if (provider.businessDetailsResponse!.business!.currentPlan!.toLowerCase() == AppMessages.freeText) {
                                        DialogUtils.displayDialogCallBack(context, "", "", AppMessages.featureNotAvailableMsg, "", AppMessages.ok_text, "");
                                      } else {
                                        print("Call now called");
                                        // =-=-=-=-=-=-=-=-=-=
                                        // String phoneNumber = '${provider.businessDetailsResponse!.business!.businessPhone}';
                                        // PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber,'US');
                                        // String parsableNumber = number.parseNumber();
                                        //`controller reference`.text = parsableNumber
                                        // =-=-=-=-=-=-=-=-=-==-=

                                        String url = 'tel:' + provider.businessDetailsResponse!.business!.businessPhone!.replaceAll("-", "");
                                        //print("_+_+_+_+_+==-=-=-=-=-=-=-=-=-=.,.,.,.,.,${provider.businessDetailsResponse!.business!.businessPhone }");
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: GlobalView().wrappedButtonFilledView(
                                          context,
                                          AppMessages.call_now_text,
                                        ),
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
                                        16,
                                      ),
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(10),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              height: 16,
                                              width: 16,
                                              child: Image.asset(
                                                AppImages.ic_location_black,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 7),
                                              child: GlobalView().textViewWithStartAlign(
                                                  provider.businessDetailsResponse!.business!.isMobile == 1
                                                      ? AppMessages.mobile_business_text
                                                      : provider.businessDetailsResponse!.business!.isOnline == 0
                                                          ? provider.businessDetailsResponse!.business!.businessAddress.toString() != null
                                                              ? provider.businessDetailsResponse!.business!.businessAddress.toString()
                                                              : "Abix Street, Main Road, San Fransisco, California"
                                                          : AppMessages.online_business_text,
                                                  // "Abix Street, Main Road, San Fransisco, California",
                                                  AppTextStyle.inter_font_family,
                                                  AppTextStyle.medium_font_weight,
                                                  BaseColor.black_color,
                                                  14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: provider.businessDetailsResponse!.business!.isOnline == 1 || provider.businessDetailsResponse!.business!.isMobile == 1
                                        //||
                                        // provider.selectedBusinessResponse.cityName == ""
                                        ? false
                                        : true,
                                    child: Column(
                                      children: [
                                        GlobalView().sizedBoxView(20),
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
                                                  provider.businessDetailsResponse!.business!.city != null && provider.businessDetailsResponse!.business!.city!.name != ""
                                                      ? provider.businessDetailsResponse!.business!.city!.name!
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
                                    visible:
                                        // provider.businessDetailsResponse
                                        //                 .business.isOnline ==
                                        //             1 ||
                                        provider.businessDetailsResponse!.business!.isMobile == 1 ? false : true,
                                    child: Column(
                                      children: [
                                        GlobalView().sizedBoxView(20),
                                        GestureDetector(
                                          onTap: () async {
                                            // String query = Uri.encodeComponent(
                                            //   provider.selectedBusinessResponse.latitude,
                                            //   provider.selectedBusinessResponse.longitude);
                                            String? lat = provider.businessDetailsResponse!.business!.latitude;
                                            String? long = provider.businessDetailsResponse!.business!.longitude;
                                            String googleUrl = Platform.isAndroid ? "https://www.google.com/maps/search/?api=1&query=" : "https://maps.apple.com/?q=" + lat! + "," + long!;
                                            if (await canLaunch(googleUrl)) {
                                              await launch(googleUrl);
                                            }
                                          },
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: Container(
                                                width: DeviceSize().deviceWidth(context) - 180,
                                                child: GlobalView().wrappedButtonFilledView(context, AppMessages.get_direction_text),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GlobalView().sizedBoxView(40),

                                  // Padding(
                                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                                  //     child: businessCheckInsView()),
                                  // Visibility(
                                  //     visible: provider.businessDetailsResponse
                                  //                 .business.feed.isNotEmpty &&
                                  //             provider.businessDetailsResponse
                                  //                     .business.feed.length >
                                  //                 0
                                  //         ? true
                                  //         : false,
                                  //     // child: businessCheckInsView(provider),
                                  //     child: CommonGradientButton(
                                  //         onPressed: () {
                                  //           // Navigator.push(
                                  //           //     context,
                                  //           //     MaterialPageRoute(
                                  //           //         builder: (_) => CategorySelectionScreen(userType: 0,)));
                                  //         },
                                  //         title:
                                  //             AppMessages.business_checkins_title)),
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
                        Positioned(
                          bottom: 0,
                          child: Visibility(
                              visible: provider.businessDetailsResponse!.business!.feed!.isNotEmpty && provider.businessDetailsResponse!.business!.feed!.length > 0 ? true : false,
                              // child: businessCheckInsView(provider),
                              child: CommonGradientButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FeedsDescriptionScreen(
                                                  businessUserId: provider.businessDetailsResponse!.business!.id.toString(),
                                                )));
                                  },
                                  title: AppMessages.business_checkins_title)),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Container(
                        // color: BaseColor.loader_bg_color,
                        child: GlobalView().loaderView(),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget businessCheckInsView(SearchByBusinessProvider provider) {
    // print("FEED-> ${provider.businessDetailsResponse.business.feed}");
    if (provider.businessDetailsResponse!.business!.feed!.isNotEmpty && provider.businessDetailsResponse!.business!.feed!.length > 0) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      GlobalView().textViewWithStartAlign(AppMessages.business_checkins_title, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                      // GlobalView().textViewWithStartAlign(
                      //     provider.businessDetailsResponse.business
                      //                 .totalFeeds ==
                      //             null
                      //         ? " (" + "0" + ")"
                      //         : " (" +
                      //             provider.businessDetailsResponse.business
                      //                 .totalFeeds
                      //                 .toString() +
                      //             ")",
                      //     // " (" + "0" + ")",
                      //     AppTextStyle.inter_font_family,
                      //     AppTextStyle.bold_font_weight,
                      //     BaseColor.count_color,
                      //     12),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // print(
                //     //     "TOTAL FEED ${user.profileResponse.user.totalFeed}");
                //     Navigator.pushNamed(
                //         context, AppRoutes.my_all_check_ins_route_name);
                //   },
                //   child: Container(
                //     child: GlobalView().textViewWithStartAlign(
                //         AppMessages.see_all_text,
                //         AppTextStyle.inter_font_family,
                //         AppTextStyle.medium_font_weight,
                //         BaseColor.forgot_pass_txt_color,
                //         12),
                //   ),
                // ),
              ],
            ),
          ),
          GlobalView().sizedBoxView(15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CheckInsItemView(
              feedResponse: provider.businessDetailsResponse!.business!.feed![0],
              isVisibleDeleteIcon: false,
              isVisibleLikePanel: false,
              onClickDelete: () {},
              verifiedUserResponse: provider.businessDetailsResponse!.business,
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

// Widget businessCheckInsView(
  //         BuildContext context, SearchByBusinessProvider provider) =>
  //     Column(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 20),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Row(
  //                   children: [
  //                     GlobalView().textViewWithStartAlign(
  //                         AppMessages.business_checkins_title,
  //                         AppTextStyle.inter_font_family,
  //                         AppTextStyle.bold_font_weight,
  //                         BaseColor.black_color,
  //                         18),
  //                     GlobalView().textViewWithStartAlign(
  //                         provider.selectedBusinessResponse.totalFeeds == null
  //                             ? " (" + "0" + ")"
  //                             : " (" +
  //                                 provider.selectedBusinessResponse.totalFeeds
  //                                     .toString() +
  //                                 ")",
  //                         // " (" + "0" + ")",
  //                         AppTextStyle.inter_font_family,
  //                         AppTextStyle.bold_font_weight,
  //                         BaseColor.count_color,
  //                         12),
  //                   ],
  //                 ),
  //               ),
  //               // GestureDetector(
  //               //   onTap: () {
  //               //     // print(
  //               //     //     "TOTAL FEED ${user.profileResponse.user.totalFeed}");
  //               //     Navigator.pushNamed(
  //               //         context, AppRoutes.my_all_check_ins_route_name);
  //               //   },
  //               //   child: Container(
  //               //     child: GlobalView().textViewWithStartAlign(
  //               //         AppMessages.see_all_text,
  //               //         AppTextStyle.inter_font_family,
  //               //         AppTextStyle.medium_font_weight,
  //               //         BaseColor.forgot_pass_txt_color,
  //               //         12),
  //               //   ),
  //               // ),
  //             ],
  //           ),
  //         ),
  //         GlobalView().sizedBoxView(15),
  //         Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 20),
  //           child: Card(
  //               elevation: 2,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 10),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Padding(
  //                       // padding: EdgeInsets.symmetric(horizontal: 10),
  //                       padding: EdgeInsets.only(right: 10),
  //                       child: Row(
  //                         children: [
  //                           // Container(
  //                           //   height: 32,
  //                           //   width: 32,
  //                           //   decoration: BoxDecoration(
  //                           //     shape: BoxShape.circle,
  //                           //     color: Colors.grey,
  //                           //     image: DecorationImage(
  //                           //         image: user.profileResponse.user
  //                           //                     .avatar !=
  //                           //                 ""
  //                           //             ? NetworkImage(user
  //                           //                 .profileResponse
  //                           //                 .user
  //                           //                 .avatar)
  //                           //             : AssetImage(AppImages
  //                           //                 .default_profile_Pic),
  //                           //         fit: BoxFit.cover),
  //                           //   ),
  //                           // ),
  //                           Expanded(
  //                             child: Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 10),
  //                               child: Container(
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   children: [
  //                                     GlobalView().textViewWithStartAlign(
  //                                         provider.selectedBusinessResponse
  //                                                         .firstName ==
  //                                                     null &&
  //                                                 provider.selectedBusinessResponse
  //                                                         .lastName ==
  //                                                     null
  //                                             ? "John Doe"
  //                                             : provider
  //                                                     .selectedBusinessResponse
  //                                                     .firstName +
  //                                                 " " +
  //                                                 provider
  //                                                     .selectedBusinessResponse
  //                                                     .lastName,
  //                                         // "John Doe",
  //                                         AppTextStyle.metropolis_font_family,
  //                                         AppTextStyle.semi_bold_font_weight,
  //                                         BaseColor.black_color,
  //                                         12),
  //                                     GlobalView().textViewWithStartAlign(
  //                                         "15 min ago",
  //                                         AppTextStyle.metropolis_font_family,
  //                                         AppTextStyle.medium_font_weight,
  //                                         BaseColor.black_color,
  //                                         10),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Container(
  //                               height: 24,
  //                               width: 24,
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   // user.changeIsVisibleValue();
  //                                 },
  //                                 child:
  //                                     //  Text(
  //                                     //   user.isVisible.toString(),
  //                                     // ),
  //                                     Image.asset(AppImages.ic_menu),
  //                               ))
  //                         ],
  //                       ),
  //                     ),
  //                     GlobalView().sizedBoxView(10),
  //                     Divider(
  //                       color: BaseColor.home_divider_color,
  //                       height: 2,
  //                       thickness: 1,
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(top: 10, left: 10, right: 10),
  //                       child: GlobalView().textViewWithStartAlign(
  //                           provider.selectedBusinessResponse != null &&
  //                                   provider.selectedBusinessResponse.feed !=
  //                                       null &&
  //                                   provider.selectedBusinessResponse.feed[0]
  //                                           .category.name !=
  //                                       null
  //                               ? provider.selectedBusinessResponse.feed[0]
  //                                   .category.name
  //                               : "Cafe",
  //                           // "Cafe",
  //                           AppTextStyle.metropolis_font_family,
  //                           AppTextStyle.semi_bold_font_weight,
  //                           BaseColor.forgot_pass_txt_color,
  //                           10),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       child: GlobalView().textViewWithStartAlign(
  //                           provider.selectedBusinessResponse != null &&
  //                                   provider.selectedBusinessResponse.feed !=
  //                                       null &&
  //                                   provider.selectedBusinessResponse
  //                                           .businessName ==
  //                                       null
  //                               ? "ChoxBlast Cafe"
  //                               : provider
  //                                   .selectedBusinessResponse.businessName,
  //                           // "ChoxBlast Cafe",
  //                           AppTextStyle.metropolis_font_family,
  //                           AppTextStyle.bold_font_weight,
  //                           BaseColor.black_color,
  //                           16),
  //                     ),
  //                     GlobalView().sizedBoxView(5),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 10),
  //                       child: Row(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             height: 16,
  //                             width: 16,
  //                             child: Image.asset(
  //                               AppImages.ic_location_black,
  //                               color: Colors.grey,
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: Container(
  //                               padding: EdgeInsets.only(left: 7, top: 2),
  //                               alignment: Alignment.centerLeft,
  //                               child: GlobalView().textViewWithStartAlign(
  //                                   provider.selectedBusinessResponse != null &&
  //                                           provider.selectedBusinessResponse
  //                                                   .feed !=
  //                                               null &&
  //                                           provider.selectedBusinessResponse
  //                                                   .businessAddress ==
  //                                               null
  //                                       ? "Abix Street, Main Road, San Fransisco, California"
  //                                       : provider.selectedBusinessResponse
  //                                           .businessAddress,
  //                                   // "Abix Street, Main Road, San Fransisco, California",
  //                                   AppTextStyle.metropolis_font_family,
  //                                   AppTextStyle.medium_font_weight,
  //                                   BaseColor.black_color.withOpacity(0.6),
  //                                   12),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     GlobalView().sizedBoxView(15),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 10, right: 10),
  //                       child: Container(
  //                         alignment: Alignment.centerLeft,
  //                         child: GlobalView().textViewWithStartAlign(
  //                             provider.selectedBusinessResponse != null &&
  //                                     provider.selectedBusinessResponse.feed !=
  //                                         null &&
  //                                     provider.selectedBusinessResponse.feed[0]
  //                                             .description !=
  //                                         null
  //                                 ? provider.selectedBusinessResponse.feed[0]
  //                                     .description
  //                                 : "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut…",
  //                             // "Lorem ipsum dolor sit amet, consetetur sadipscing elitr",
  //                             AppTextStyle.inter_font_family,
  //                             AppTextStyle.medium_font_weight,
  //                             BaseColor.black_color,
  //                             12),
  //                       ),
  //                     ),
  //                     // Padding(
  //                     //   padding: EdgeInsets.only(left: 10, right: 10),
  //                     //   child: Container(
  //                     //       alignment: Alignment.centerLeft,
  //                     //       child: Text(
  //                     //         "See more",
  //                     //         style: TextStyle(
  //                     //           decoration: TextDecoration.underline,
  //                     //           fontFamily: AppTextStyle.interFontFamily,
  //                     //           fontWeight: FontWeight.w600,
  //                     //           fontSize: 12,
  //                     //           color: BaseColor.blackColor.withOpacity(0.5),
  //                     //         ),
  //                     //       )),
  //                     // ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 16, right: 16, top: 10),
  //                       child: Container(
  //                         child: Row(
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () {
  //                                 //   print(
  //                                 //       "LIKED>> ${user.profileResponse.user.feed[0].isLiked}");
  //                                 //   print(
  //                                 //       "TOTAL LIKES>> ${user.profileResponse.user.feed[0].totalLikes}");
  //                                 //   print(
  //                                 //       "User Response===-->> ${user.profileResponse.user.feed[0].toJson()}");

  //                                 provider.checkInsLike(
  //                                     context,
  //                                     provider
  //                                         .selectedBusinessResponse.feed[0].id,
  //                                     provider.selectedBusinessResponse.feed[0]
  //                                                 .isLiked ==
  //                                             1
  //                                         ? 0
  //                                         : 1,
  //                                     0);

  //                                 //   print(
  //                                 //       "LIKED=-=-=>> ${user.profileResponse.user.feed[0].isLiked}");
  //                               },
  //                               child: Image.asset(
  //                                 provider.selectedBusinessResponse.feed[0]
  //                                             .isLiked ==
  //                                         1
  //                                     ? AppImages.thumbs_up_filled
  //                                     : AppImages.thumbs_up,
  //                                 // AppImages.thumbs_up_filled,
  //                                 height: 24,
  //                                 width: 24,
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Container(
  //                                 margin: EdgeInsets.only(left: 10),
  //                                 child: GlobalView().textViewWithStartAlign(
  //                                     provider.selectedBusinessResponse !=
  //                                                 null &&
  //                                             provider.selectedBusinessResponse
  //                                                     .feed !=
  //                                                 null &&
  //                                             provider.selectedBusinessResponse
  //                                                     .feed[0].totalLikes
  //                                                     .toString() ==
  //                                                 null
  //                                         ? "0"
  //                                         : provider.selectedBusinessResponse
  //                                             .feed[0].totalLikes
  //                                             .toString(),
  //                                     // "0",
  //                                     AppTextStyle.metropolis_font_family,
  //                                     AppTextStyle.medium_font_weight,
  //                                     BaseColor.black_color.withOpacity(0.5),
  //                                     12),
  //                               ),
  //                             ),
  //                             // SizedBox(
  //                             //   width: 30,
  //                             // ),
  //                             // GestureDetector(
  //                             //   onTap: () {
  //                             //     print(
  //                             //         "DIS LIKED>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                             //     print(
  //                             //         "TOTAL DIS LIKES>> ${user.profileResponse.user.feed[0].totalDislikes}");
  //                             //     // home.feed_detail_like_dislike(
  //                             //     //   context,
  //                             //     //   user.profileResponse.user.feed[0].id
  //                             //     //       .toString(),
  //                             //     // "0",
  //                             //     // user.profileResponse.user.feed[0]
  //                             //     //             .isDisliked ==
  //                             //     //         1
  //                             //     //     ? "0"
  //                             //     //     : "1",
  //                             //     //   // user.profileResponse.user.feed[0],
  //                             //     //   "dislike",
  //                             //     // );
  //                             //     // profile.checkIns_like_dislike(
  //                             //     //     context,
  //                             //     //     user.profileResponse.user.feed[0]
  //                             //     //         .id
  //                             //     //         .toString(),
  //                             //     //     "dislike",
  //                             //     //     "0",
  //                             //     //     user.profileResponse.user.feed[0]
  //                             //     //                 .isDisliked ==
  //                             //     //             1
  //                             //     //         ? "0"
  //                             //     //         : "1",
  //                             //     //     0);
  //                             //     print(
  //                             //         "DIS LIKED=-=-=>> ${user.profileResponse.user.feed[0].isDisliked}");
  //                             //   },
  //                             //   child: Image.asset(
  //                             //     user.profileResponse.user.feed[0]
  //                             //                 .isDisliked ==
  //                             //             1
  //                             //         ? AppImages.thumbs_down_filled
  //                             //         : AppImages.thumbs_down,
  //                             //     height: 24,
  //                             //     width: 24,
  //                             //   ),
  //                             // ),
  //                             // Expanded(
  //                             //   child: Container(
  //                             //     margin: EdgeInsets.only(left: 10),
  //                             //     child: GlobalView()
  //                             //         .textViewWithStartAlign(
  //                             //             user.profileResponse.user ==
  //                             //                         null &&
  //                             //                     user.profileResponse
  //                             //                             .user.feed ==
  //                             //                         null &&
  //                             //                     user
  //                             //                             .profileResponse
  //                             //                             .user
  //                             //                             .feed[0]
  //                             //                             .totalDislikes
  //                             //                             .toString() ==
  //                             //                         null
  //                             //                 ? "0"
  //                             //                 : user
  //                             //                     .profileResponse
  //                             //                     .user
  //                             //                     .feed[0]
  //                             //                     .totalDislikes
  //                             //                     .toString(),
  //                             //             AppTextStyle
  //                             //                 .metropolisFontFamily,
  //                             //             AppTextStyle.mediumFontWeight,
  //                             //             BaseColor.blackColor
  //                             //                 .withOpacity(0.5),
  //                             //             12),
  //                             //   ),
  //                             // ),
  //                             SizedBox(
  //                               width: 30,
  //                             ),
  //                             Image.asset(
  //                               AppImages.ic_comments,
  //                               height: 24,
  //                               width: 24,
  //                             ),
  //                             Expanded(
  //                               child: Container(
  //                                 margin: EdgeInsets.only(left: 10),
  //                                 child: GlobalView().textViewWithStartAlign(
  //                                     provider.selectedBusinessResponse !=
  //                                                 null &&
  //                                             provider.selectedBusinessResponse
  //                                                     .feed !=
  //                                                 null &&
  //                                             provider.selectedBusinessResponse
  //                                                     .feed[0].totalComments
  //                                                     .toString() !=
  //                                                 null
  //                                         ? provider.selectedBusinessResponse
  //                                             .feed[0].totalComments
  //                                             .toString()
  //                                         : "0",
  //                                     // "0",
  //                                     AppTextStyle.metropolis_font_family,
  //                                     AppTextStyle.medium_font_weight,
  //                                     BaseColor.black_color.withOpacity(0.5),
  //                                     12),
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               width: 30,
  //                             ),
  //                             // Image.asset(
  //                             //   AppImages.ic_share,
  //                             //   height: 24,
  //                             //   width: 24,
  //                             // ),
  //                             // Expanded(
  //                             //   child: Container(
  //                             //  margin: EdgeInsets.only(left: 10),
  //                             //     child: GlobalView()
  //                             //         .textViewWithStartAlign(
  //                             //             user.profileResponse.user !=
  //                             //                         null &&
  //                             //                     user.profileResponse
  //                             //                             .user.feed !=
  //                             //                         null &&
  //                             //                     user
  //                             //                             .profileResponse
  //                             //                             .user
  //                             //                             .feed[0]
  //                             //                             .totalShares
  //                             //                             .toString() !=
  //                             //                         null
  //                             //                 ? user
  //                             //                     .profileResponse
  //                             //                     .user
  //                             //                     .feed[0]
  //                             //                     .totalShares
  //                             //                     .toString()
  //                             //                 : "0",
  //                             //             AppTextStyle
  //                             //                 .metropolisFontFamily,
  //                             //             AppTextStyle.mediumFontWeight,
  //                             //             BaseColor.blackColor
  //                             //                 .withOpacity(0.5),
  //                             //             12),
  //                             //   ),
  //                             // ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               )),
  //         ),
  //       ],
  //     );

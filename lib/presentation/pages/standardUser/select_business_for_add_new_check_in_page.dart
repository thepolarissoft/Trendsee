import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/business_selection_view.dart';
import 'package:trendoapp/global/view/common_gradient_button.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/screens/businessUser/category_selection_screen.dart';
import 'package:trendoapp/presentation/screens/online_business_check_in_screen.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/utils/storage_utils.dart';

class SelectBusinessForAddNewCheckInPage extends StatefulWidget {
  @override
  _SelectBusinessForAddNewCheckInPageState createState() =>
      _SelectBusinessForAddNewCheckInPageState();
}

class _SelectBusinessForAddNewCheckInPageState
    extends State<SelectBusinessForAddNewCheckInPage> {
  TextEditingController searchLocationTextEditingController =
      new TextEditingController();
  TextEditingController businessNameTextEditingController =
      new TextEditingController();
  List<String> listLocation = [];
  ScrollController scrollController = new ScrollController();

  // VerifiedUserResponse verifiedUserResponse = new VerifiedUserResponse();

  @override
  void initState() {
    super.initState();
    print(
        "RADIUS-> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    var businessListProvider =
        Provider.of<BusinessListProvider>(context, listen: false);
    businessListProvider.businessListResponse = null;
    businessListProvider.getBusinessList(
        context,
        StorageUtils.readStringValue(StorageUtils.keyLatitude),
        StorageUtils.readStringValue(StorageUtils.keyLongitude),
        // "0.02",
        "5"
        // Provider.of<FilterProvider>(context, listen: false).distanceRadius,
        // "100000000000000000000",
        );
    print(
        "RADIUS==-> ${Provider.of<FilterProvider>(context, listen: false).distanceRadius}");
    businessListProvider.isChecked = false;
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (businessListProvider.businessListResponse.business.currentPage <
            businessListProvider.businessListResponse.business.lastPage) {
          businessListProvider.getBusinessList(
            context,
            StorageUtils.readStringValue(StorageUtils.keyLatitude),
            StorageUtils.readStringValue(StorageUtils.keyLongitude),
            Provider.of<FilterProvider>(context, listen: false).distanceRadius,
          );
        } else {
          // GlobalView().showToast(AppMessages.no_more_data_text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.background_image1,
              ),
              fit: BoxFit.cover,
              // alignment: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Consumer<BusinessListProvider>(
                            builder: (_, location, child) {
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GlobalView().sizedBoxView(
                                  DeviceSize().deviceHeight(context) * 0.052),
                              Container(
                                alignment: Alignment.topCenter,
                                child: GlobalView().textViewWithCenterAlign(
                                    AppMessages.select_location_title,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.bold_font_weight,
                                    BaseColor.black_color,
                                    18),
                              ),
                              GlobalView().sizedBoxView(
                                  DeviceSize().deviceHeight(context) * 0.02),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: DeviceSize().deviceHeight(context) -
                                        300,
                                    child: locationsList(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                    bottom: DeviceSize().deviceHeight(context) *
                                        0.01,
                                    top: DeviceSize().deviceHeight(context) *
                                        0.02),
                                child: Provider.of<BusinessListProvider>(
                                            context)
                                        .listBusinessLiked
                                        .isNotEmpty
                                    ? Provider.of<BusinessListProvider>(context)
                                            .isChecked
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  AppRoutes
                                                      .add_new_checkin_route_name);
                                            },
                                            child: GlobalView().buttonFilled(
                                                context, AppMessages.next_text),
                                          )
                                        : GlobalView().buttonFilledDisabled(
                                            context, AppMessages.next_text)
                                    : Container(),
                              ),
                              // GlobalView().sizedBoxView(
                              //     DeviceSize().deviceHeight(context) * 0.02),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  CommonGradientButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => OnlineBusinessCheckInScreen()));
                      },
                      title: AppMessages.online_business_check_in_text),
                  GlobalView().sizedBoxView(5),
                  GlobalView().dividerView(),
                  GlobalView().sizedBoxView(5),
                  CommonGradientButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategorySelectionScreen(
                                      userType: 0,
                                    )));
                      },
                      title: AppMessages.add_unregistered_business_title),
                ],
              ),
              Positioned(
                child: Visibility(
                  visible: Provider.of<BusinessListProvider>(context).isLoading,
                  child: Container(
                    // color: BaseColor.loader_bg_color,
                    child: GlobalView().loaderView(),
                  ),
                ),
              ),
              Positioned(
                top: 57,
                left: 21,
                child: Container(
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
          ),
          // );
          // }
        ),
      ),
    );
  }

  Widget textfieldViewForSearchLocation(
          String image,
          TextEditingController controller,
          String hintText,
          TextAlign textAlign) =>
      Material(
        shadowColor: BaseColor.shadow_color,
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: TextField(
          controller: controller,
          cursorColor: BaseColor.border_txtfield_color,
          style: TextStyle(
            color: BaseColor.hint_color,
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
          textAlign: textAlign,
          decoration: InputDecoration(
            isDense: true,
            focusColor: BaseColor.pure_white_color,
            contentPadding: EdgeInsets.only(left: 60, right: -30),
            prefixIcon: Container(
              // height: 50,
              // width: 58,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 13, bottom: 13, left: 13, right: 13),
                child: Image.asset(
                  image,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: BaseColor.border_txtfield_color),
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
            hintText: hintText,
            hintStyle: TextStyle(
              color: BaseColor.hint_color.withOpacity(0.6),
              fontFamily: AppTextStyle.inter_font_family,
              fontSize: 14,
            ),
          ),
        ),
      );

  Widget locationsList(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer<BusinessListProvider>(
          builder: (_, provider, child) {
            print("isAvailableData -> ${provider.isAvailableData}");
            if (provider.listBusinessLiked.isNotEmpty) {
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: provider.listBusinessLiked.length,
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (_, index) => BusinessSelectionView(
                  verifiedUserResponse: provider.listBusinessLiked[index],
                  index: index,
                  // checkBoxView:

                  // onClickCheckbox: () {},
                ),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 10, top: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Container(
                //               child: GlobalView().textViewWithStartAlign(
                //                   provider
                //                       .listBusinessLiked[index].businessName,
                //                   AppTextStyle.inter_font_family,
                //                   AppTextStyle.bold_font_weight,
                //                   BaseColor.black_color,
                //                   18),
                //             ),
                //             Container(
                //               child: GlobalView().textViewWithStartAlign(
                //                   provider.listBusinessLiked[index]
                //                               .isMobile ==
                //                           1
                //                       ? AppMessages.mobile_business_text
                //                       : provider.listBusinessLiked[index]
                //                                   .isOnline ==
                //                               0
                //                           ? provider.listBusinessLiked[index]
                //                               .businessAddress
                //                           : AppMessages.online_business_text,
                //                   AppTextStyle.inter_font_family,
                //                   AppTextStyle.normal_font_weight,
                //                   BaseColor.black_color.withOpacity(0.5),
                //                   16),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Container(
                //         height: 25,
                //         padding: EdgeInsets.zero,
                //         // color: Colors.green,
                //         child: Theme(
                //           data: ThemeData(
                //               unselectedWidgetColor:
                //                   BaseColor.btn_gradient_end_color1,
                //               backgroundColor:
                //                   BaseColor.btn_gradient_end_color1),
                //           child: Checkbox(
                //               value:
                //                   provider.listBusinessLiked[index].isChecked,
                //               checkColor: BaseColor.pure_white_color,
                //               activeColor: BaseColor.btn_gradient_end_color1,
                //               onChanged: (bool value) {
                //                 provider.changeCheckBoxValue(index, value);
                //                 print(
                //                     "CHECKED value-->> ${Provider.of<BusinessListProvider>(context, listen: false).businessListResponse.business.data[index].isChecked = value}");
                //                 // setState(() {
                //                 //   checkValue = value;
                //                 // });
                //               }),
                //           // CheckboxGroup(
                //           //     labels: listLocation,
                //           //     onSelected: (List<String> checked) =>
                //           //         print(checked.toString())),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              );
            } else {
              return Visibility(
                visible: !provider.isAvailableData,
                child: Container(
                    // color: Colors.red,
                    child: Center(
                  child: GlobalView().textViewWithCenterAlign(
                      AppMessages.no_nearby_locations_available_text,
                      AppTextStyle.inter_font_family,
                      AppTextStyle.semi_bold_font_weight,
                      BaseColor.black_color,
                      18),
                )),
              );
            }
          },
        ),
      ),
    );
  }
}

//business address
//business name

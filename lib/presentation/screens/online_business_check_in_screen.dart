import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/business_selection_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_list_provider.dart';

class OnlineBusinessCheckInScreen extends StatefulWidget {
  OnlineBusinessCheckInScreen({Key? key}) : super(key: key);

  @override
  State<OnlineBusinessCheckInScreen> createState() => _OnlineBusinessCheckInScreenState();
}

class _OnlineBusinessCheckInScreenState extends State<OnlineBusinessCheckInScreen> {
  TextEditingController searchTextEditingController = new TextEditingController();
  ScrollController scrollController = new ScrollController();

  void initOnlineData() {
    var businessListProvider = Provider.of<BusinessListProvider>(context, listen: false);
    businessListProvider.businessListResponse = null;
    businessListProvider.getBusinessListByName(context, searchTextEditingController.text);
    businessListProvider.isChecked = false;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (businessListProvider.businessListResponse!.business!.currentPage! < businessListProvider.businessListResponse!.business!.lastPage!) {
          businessListProvider.getBusinessListByName(context, searchTextEditingController.text);
        } else {
          // GlobalView().showToast(AppMessages.no_more_data_text);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initOnlineData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.052),
                    Container(
                      alignment: Alignment.topCenter,
                      child: GlobalView().textViewWithCenterAlign(AppMessages.do_not_see_your_location, AppTextStyle.inter_font_family, AppTextStyle.bold_font_weight, BaseColor.black_color, 18),
                    ),
                    GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.02),
                    searchTextFieldView(),
                    GlobalView().sizedBoxView(DeviceSize().deviceHeight(context) * 0.02),
                    Expanded(
                      child: autoCompleteListView(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5, bottom: DeviceSize().deviceHeight(context) * 0.02, top: DeviceSize().deviceHeight(context) * 0.02),
                      child:
                          // Provider.of<BusinessListProvider>(context)
                          //         .businessListResponse
                          //         .isNotEmpty
                          //     ?
                          Provider.of<BusinessListProvider>(context).isChecked!
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.add_new_checkin_route_name);
                                  },
                                  child: GlobalView().buttonFilled(context, AppMessages.next_text),
                                )
                              : GlobalView().buttonFilledDisabled(context, AppMessages.next_text),
                      // : Container(),
                    ),
                  ],
                ),
              ),
              // Consumer<BusinessListProvider>(builder: (_, provider, child) {
              //   return Positioned(
              //     child: Visibility(
              //       visible:
              //           provider.isLoading,
              //       child: Container(
              //         // color: BaseColor.loader_bg_color,
              //         child: GlobalView().loaderView(),
              //       ),
              //     ),
              //   );
              // }),
              Positioned(
                top: 57,
                left: 21,
                child: Container(
                  height: 25,
                  width: 25,
                  child: GestureDetector(
                      onTap: () {
                        Provider.of<BusinessListProvider>(context, listen: false).listBusinessLikedByName.clear();
                        Navigator.pop(context);
                      },
                      child: GlobalView().assetImageView(AppImages.ic_back)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchTextFieldView() {
    return Material(
      shadowColor: BaseColor.shadow_color,
      elevation: 4,
      borderRadius: BorderRadius.circular(25),
      child: TextField(
        controller: searchTextEditingController,
        cursorColor: BaseColor.border_txtfield_color,
        onChanged: (String value) {
          Provider.of<BusinessListProvider>(context, listen: false).isChecked = false;
          Provider.of<BusinessListProvider>(context, listen: false).businessListResponse = null;
          Provider.of<BusinessListProvider>(context, listen: false).listBusinessLikedByName.clear();
          print("Screen listBusinessLikedByName length-> ${Provider.of<BusinessListProvider>(context, listen: false).listBusinessLikedByName.length}");
          Provider.of<BusinessListProvider>(context, listen: false).getBusinessListByName(context, searchTextEditingController.text);
        },
        style: TextStyle(
          color: BaseColor.hint_color,
          fontFamily: AppTextStyle.inter_font_family,
          fontSize: 14,
        ),
        textAlign: AppTextStyle.start_text_align,
        decoration: InputDecoration(
          isDense: true,
          focusColor: BaseColor.pure_white_color,
          contentPadding: EdgeInsets.only(left: 60, right: -40),
          prefixIcon: GlobalView().prefixIconView(AppImages.ic_business),
          //  prefixIconConstraints:BoxConstraints(minWidth: 23, maxHeight: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: BaseColor.border_txtfield_color),
          ),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: BaseColor.border_txtfield_color)),
          hintText: AppMessages.online_business_hint_text,
          hintStyle: TextStyle(
            color: BaseColor.hint_color.withOpacity(0.6),
            fontFamily: AppTextStyle.inter_font_family,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget autoCompleteListView() {
    return Container(
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer<BusinessListProvider>(
          builder: (_, provider, child) {
            return Stack(
              children: [
                if (provider.listBusinessLikedByName.isNotEmpty)
                  ListView.builder(
                    // shrinkWrap: true,
                    itemCount: provider.listBusinessLikedByName.length,
                    controller: scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => BusinessSelectionView(
                      verifiedUserResponse: provider.listBusinessLikedByName[index],
                      index: index,
                      // checkBoxView:
                      // onClickCheckbox: () {},
                    ),
                  )
                else
                  Visibility(
                    visible: !provider.isAvailableOnlineData,
                    child: Container(
                      child: Center(
                        child:
                            GlobalView().textViewWithCenterAlign(AppMessages.no_business_available_text, AppTextStyle.inter_font_family, AppTextStyle.semi_bold_font_weight, BaseColor.black_color, 18),
                      ),
                    ),
                  ),
                Positioned(
                  child: Visibility(
                    visible: provider.isLoading,
                    child: Container(
                      // color: Colors.red,
                      // color: BaseColor.loader_bg_color,
                      child: GlobalView().loaderView(),
                    ),
                  ),
                ),
              ],
            );
            // if (provider.listBusinessLikedByName.isNotEmpty) {
            //   return ListView.builder(
            //     // shrinkWrap: true,
            //     itemCount: provider.listBusinessLikedByName.length,
            //     controller: scrollController,
            //     physics: AlwaysScrollableScrollPhysics(),
            //     itemBuilder: (_, index) => BusinessSelectionView(
            //       verifiedUserResponse: provider.listBusinessLikedByName[index],
            //       index: index,
            //       // checkBoxView:

            //       // onClickCheckbox: () {},
            //     ),
            //   );
            // } else {
            //   return Visibility(
            //     visible: !provider.isAvailableOnlineData,
            //     child: Container(
            //         child: Center(
            //       child: GlobalView().textViewWithCenterAlign(
            //           AppMessages.no_nearby_locations_available_text,
            //           AppTextStyle.inter_font_family,
            //           AppTextStyle.semi_bold_font_weight,
            //           BaseColor.black_color,
            //           18),
            //     )),
            //   );
            // }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/business_list_provider.dart';
import 'package:trendoapp/providers/business_user_provider.dart';
import 'package:trendoapp/router/app_router.dart';
import 'package:trendoapp/utils/storage_utils.dart';

// ignore: must_be_immutable
class AddMoreLocationsScreen extends StatefulWidget {
  AddMoreLocationsScreen({Key key}) : super(key: key);

  @override
  State<AddMoreLocationsScreen> createState() => _AddMoreLocationsScreenState();
}

class _AddMoreLocationsScreenState extends State<AddMoreLocationsScreen> {
  ScrollController scrollController = new ScrollController();
  String businessUserType = "";
  // void updateLatLongData(String moreLatitude, String moreLongitude) {
  //   Provider.of<BusinessUserProvider>(context, listen: false)
  //       .updateBusinessLatlong(context, moreLatitude, moreLongitude, 0);
  // }

  @override
  void initState() {
    businessUserType =
        StorageUtils.readStringValue(StorageUtils.keyBusinessType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
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
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GlobalView().sizedBoxView(
                          DeviceSize().deviceHeight(context) * 0.055),
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
                        child: Container(
                            // height: DeviceSize().deviceHeight(context) - 200,
                            child: locationsList(context)),
                      ),
                      Consumer<BusinessUserProvider>(
                          builder: (_, provider, child) {
                        return Visibility(
                          visible:
                              businessUserType == AppMessages.mobile_text &&
                                      provider.listLatLong.length >= 1
                                  ? false
                                  : true,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                                bottom:
                                    DeviceSize().deviceHeight(context) * 0.02,
                                top: DeviceSize().deviceHeight(context) * 0.02),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.map_route_name,
                                  arguments: TempLocationsArgs(true),
                                );
                              },
                              child: GlobalView()
                                  .buttonFilled(context, AppMessages.add_text),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
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
                left: 16,
                child: Container(
                  height: 25,
                  width: 25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: GlobalView().assetImageView(AppImages.ic_back),
                  ),
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

  bool isVisibleDeleteIcon(BusinessUserProvider provider) {
    if (provider.businessUserProfileResponse.user.isMobile == 0 &&
        provider.businessUserProfileResponse.user.isOnline == 0) {
      if (provider.listLatLong.length <= 1) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Widget locationsList(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Consumer<BusinessUserProvider>(
          builder: (_, provider, child) {
            if (provider.listLatLong != null &&
                provider.listLatLong.isNotEmpty) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: provider.listLatLong.length,
                      controller: scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) => Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GlobalView().textViewWithStartAlign(
                                    provider.listLatLong[index].locationName ==
                                                null ||
                                            provider.listLatLong[index]
                                                    .locationName ==
                                                ""
                                        ? "Anonymous"
                                        : provider
                                            .listLatLong[index].locationName,
                                    AppTextStyle.inter_font_family,
                                    AppTextStyle.semi_bold_font_weight,
                                    BaseColor.black_color,
                                    18),
                                GlobalView().sizedBoxView(6),
                                Row(
                                  children: [
                                    Image.asset(
                                      AppImages.ic_location_black,
                                      height: 22,
                                      width: 22,
                                      color: BaseColor.btn_gradient_end_color1,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: GlobalView()
                                            .textViewWithStartAlign(
                                                provider.listLatLong[index]
                                                        .latitude +
                                                    " / " +
                                                    provider.listLatLong[index]
                                                        .longitude,
                                                AppTextStyle.inter_font_family,
                                                AppTextStyle
                                                    .semi_bold_font_weight,
                                                BaseColor.black_color,
                                                16),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 25,
                                    //   padding: EdgeInsets.zero,
                                    //   // color: Colors.green,
                                    //   child: Theme(
                                    //     data: ThemeData(
                                    //         unselectedWidgetColor:
                                    //             BaseColor.btn_gradient_end_color1,
                                    //         backgroundColor:
                                    //             BaseColor.btn_gradient_end_color1),
                                    //     child: Checkbox(
                                    //         value:
                                    //             provider.listLatLong[index].isDefault ==
                                    //                     0
                                    //                 ? false
                                    //                 : true,
                                    //         checkColor: BaseColor.pure_white_color,
                                    //         activeColor:
                                    //             BaseColor.btn_gradient_end_color1,
                                    //         onChanged: (bool value) {
                                    //           provider.changeCheckBoxValue(
                                    //               provider.listLatLong[index].id,
                                    //               value,
                                    //               context);
                                    //           // updateLatLongData(
                                    //           //     provider.listLatLong[index].latitude,
                                    //           //     provider.listLatLong[index].longitude);
                                    //         }),
                                    //     // CheckboxGroup(
                                    //     //     labels: listLocation,
                                    //     //     onSelected: (List<String> checked) =>
                                    //     //         print(checked.toString())),
                                    //   ),
                                    // ),
                                    Visibility(
                                      visible: isVisibleDeleteIcon(provider),
                                      child: GestureDetector(
                                        onTap: () {
                                          provider.deleteBusinessLatlong(
                                              context,
                                              provider.listLatLong[index]);
                                        },
                                        child: Image.asset(
                                          AppImages.icon_finder_delete,
                                          height: 22,
                                          width: 22,
                                          color:
                                              BaseColor.btn_gradient_end_color1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Visibility(
                      visible: provider.isLoading,
                      child: Container(
                        // color: BaseColor.loader_bg_color,
                        child: GlobalView().loaderView(),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                  child: Center(
                child: GlobalView().textViewWithCenterAlign(
                    AppMessages.no_locations_available_text,
                    AppTextStyle.inter_font_family,
                    AppTextStyle.semi_bold_font_weight,
                    BaseColor.black_color,
                    18),
              ));
            }
          },
        ),
      ),
    );
  }
}

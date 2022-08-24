import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_constants.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/constants/device_size.dart';
import 'package:trendoapp/global/view/category_view.dart';
import 'package:trendoapp/global/view/filter/city_filter_view.dart';
import 'package:trendoapp/global/view/filter/common.dart';
import 'package:trendoapp/global/view/filter/distance_filter_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/filter_provider.dart';

void openFilterBottomSheet({
  required BuildContext context,
  required String route,
  required FilterProvider? filterProvider,
  required int? selectedFilterValue,
  required String? distanceRadius,
}) {
  showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(builder:
          (BuildContext context, void Function(void Function()) setState) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                    // height: ScreenSize().screenHeight(context) - 600,
                    decoration: BoxDecoration(
                      color: BaseColor.pure_white_color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            titleView(context),
                            GlobalView().sizedBoxView(10),
                            CategoryView(route),
                            GlobalView().sizedBoxView(20),
                            route == "search"
                                ? Container(
                                    padding: EdgeInsets.all(2),
                                    width: DeviceSize().deviceWidth(context),
                                    decoration: BoxDecoration(
                                      color: BaseColor.grey_color,
                                      borderRadius: BorderRadius.circular(12),
                                      // border: Border.all(color: BaseColor.grey_color),
                                    ),
                                    child: CupertinoSlidingSegmentedControl(
                                      padding: EdgeInsets.all(0),
                                      groupValue: selectedFilterValue,
                                      children: {
                                        0: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: GlobalView()
                                              .textViewWithCenterAlign(
                                            AppMessages.by_city_text,
                                            AppTextStyle.inter_font_family,
                                            AppTextStyle.semi_bold_font_weight,
                                            selectedFilterValue == 0
                                                ? BaseColor.pure_white_color
                                                : BaseColor.grey_color,
                                            16,
                                          ),
                                        ),
                                        1: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: GlobalView()
                                              .textViewWithCenterAlign(
                                            AppMessages.by_distance_text,
                                            AppTextStyle.inter_font_family,
                                            AppTextStyle.semi_bold_font_weight,
                                            selectedFilterValue == 1
                                                ? BaseColor.pure_white_color
                                                : BaseColor.grey_color,
                                            16,
                                          ),
                                        ),
                                      },
                                      backgroundColor:
                                          BaseColor.pure_white_color,
                                      thumbColor:
                                          BaseColor.forgot_pass_txt_color,
                                      onValueChanged: (dynamic i) {
                                        setState(
                                          () {
                                            selectedFilterValue = i;
                                            // print("Value-> ${myTabs[i]}");
                                            Text list = myFilterTabs[i] as Text;
                                            distanceRadius = list.data;
                                            // print("Distance Radius-> $distanceRadius");
                                            // Provider.of<FilterProvider>(context,
                                            //         listen: false)
                                            //     .setDistanceRadius(distanceRadius);
                                            Provider.of<FilterProvider>(context,
                                                    listen: false)
                                                .changeSegmentValue(
                                                    route: i == 0
                                                        ? AppMessages.city_text
                                                        : AppMessages
                                                            .radius_text);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Container(),
                            // categoriesView(),
                            GlobalView().sizedBoxView(20),
                            selectedFilterValue == 0
                                ? CityFilterView(
                                    filterProvider: filterProvider,
                                    // citySearchController:
                                    //     citySearchController,
                                  )
                                : DistanceFilterView(),
                            // cityAutoCompleteTextFieldView(),
                            // cityTextFieldView(),
                            // GlobalView().sizedBoxView(20),
                            // distanceRadiusView(setState, context),
                            GlobalView().sizedBoxView(25),
                            ResetApplyView(
                              distanceRadius: distanceRadius,
                              route: route,
                            ),
                            GlobalView().sizedBoxView(20),
                          ],
                        ),
                      ),
                    ))));
      });
    },
  );
}

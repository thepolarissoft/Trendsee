import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/providers/filter_provider.dart';

import '../global_view.dart';

class DistanceFilterView extends StatelessWidget {
  DistanceFilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: distanceRadiusView(context),
        ),
      ],
    );
  }

  Widget distanceRadiusView(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalView().textViewWithStartAlign(
              AppMessages.distance_radius_text,
              AppTextStyle.inter_font_family,
              AppTextStyle.normal_font_weight,
              BaseColor.forgot_pass_txt_color,
              18),
          GlobalView().sizedBoxView(14),
          Consumer<FilterProvider>(builder: (_, provider, child) {
            return Container(
              // color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.listDistances.length,
                  itemBuilder: (_, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.setDistanceRadius(
                                provider.listDistances[index]);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  child: GlobalView().textViewWithStartAlign(
                                      provider.listDistances[index] +
                                          (provider.listDistances[index]
                                                      .length ==
                                                  1
                                              ? AppMessages.mile_text
                                              : AppMessages.miles_text),
                                      AppTextStyle.inter_font_family,
                                      provider.listDistances[index] ==
                                              provider.distanceRadius
                                          ? AppTextStyle.bold_font_weight
                                          : AppTextStyle.normal_font_weight,
                                      provider.listDistances[index] ==
                                              provider.distanceRadius
                                          ? BaseColor.forgot_pass_txt_color
                                          : BaseColor.black_color,
                                      16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GlobalView().sizedBoxView(3),
                        Divider(
                          color: BaseColor.divider_color,
                        ),
                        GlobalView().sizedBoxView(3),
                      ],
                    );
                  },
                ),
              ),
            );
          })
        ],
      );
}

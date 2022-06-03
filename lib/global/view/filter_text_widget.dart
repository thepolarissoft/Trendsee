// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/providers/categories_list_provider.dart';
import 'package:trendoapp/providers/filter_provider.dart';

class FilterTextWidget extends StatelessWidget {
  FilterTextWidget({Key key, this.isHome = true}) : super(key: key);
  bool isHome = true;
  FilterProvider filterProvider;
  CategoriesListProvider catProvider;
  TextStyle textStyle = TextStyle(
      color: BaseColor.black_color, fontSize: 16, fontWeight: FontWeight.w600);

  TextStyle textValueStyle = TextStyle(
      color: BaseColor.btn_gradient_end_color1,
      fontSize: 16,
      fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    filterProvider = Provider.of<FilterProvider>(context);
    catProvider = Provider.of<CategoriesListProvider>(context);

// “Searching____ (selected category) within ____ miles near me”
// “ Searching ____ within _____ (selected location) or ( distance “ miles near me”)”
    print(
        "filterProvider.cityValue-->> ${filterProvider.selectedMetropolitanCityInfo}");
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          text: TextSpan(children: [
            TextSpan(
              text: AppMessages.searching_text,
              style: textStyle,
            ),
            TextSpan(
              text: catProvider.selectedCategoryResponse.name,
              style: textValueStyle,
            ),
            TextSpan(
              text: AppMessages.within_text,
              style: textStyle,
            ),
            TextSpan(
              text: (!isHome &&
                      filterProvider.selectedMetropolitanCityInfo != null &&
                      filterProvider.selectedMetropolitanCityInfo.length > 0)
                  ? filterProvider.selectedMetropolitanCityInfo
                  : "",
              style: textValueStyle,
            ),
            // TextSpan(
            //   text: (!isHome &&
            //           filterProvider.selectedMetropolitanCityInfo.length > 0
            //       ? " and "
            //       : ""),
            //   style: textStyle,
            // ),
            TextSpan(
              text: filterProvider.distanceRadius != "0"
                  ? filterProvider.distanceRadius +
                      (filterProvider.distanceRadius == "1"
                          ? AppMessages.mile_text
                          : AppMessages.miles_text)
                  : "",
              style: textValueStyle,
            ),
            TextSpan(
              text: filterProvider.distanceRadius != "0"
                  ? AppMessages.near_me_text2
                  : "",
              style: textStyle,
            ),
          ])),
    );
  }
}

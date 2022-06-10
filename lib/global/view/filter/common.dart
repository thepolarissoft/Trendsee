// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/global/home_list_data.dart';
import 'package:trendoapp/data/global/search_list_data.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';

Widget titleView(BuildContext context) => Row(
      children: [
        Expanded(
          child: GlobalView().textViewWithStartAlign(
              AppMessages.filter_text,
              AppTextStyle.inter_font_family,
              AppTextStyle.semi_bold_font_weight,
              BaseColor.black_color,
              18),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            size: 20,
          ),
        ),
      ],
    );

class ResetApplyView extends StatefulWidget {
  ResetApplyView({Key key, @required this.route, @required this.distanceRadius})
      : super(key: key);
  String route;
  String distanceRadius;
  @override
  State<ResetApplyView> createState() => _ResetApplyViewState();
}

class _ResetApplyViewState extends State<ResetApplyView> {
  FilterProvider filterProvider;
  int selectedRadiusValue;
  @override
  Widget build(BuildContext context) {
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              print("Reset Clicked");
              setState(() {
                selectedRadiusValue = 1;
              });
              onClickResetButton();
            },
            child: GlobalView().buttonFilled2(context, AppMessages.reset_text),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: GestureDetector(
              onTap: () {
                onClickApplyButton();
              },
              child:
                  GlobalView().buttonFilled(context, AppMessages.apply_text)),
        ),
      ],
    );
  }

  void onClickApplyButton() {
    print("Apply Clicked");

    if (widget.route.toLowerCase() == "search") {
      if (filterProvider.isCitySelected) {
        selectedRadiusValue = 0;
        filterProvider.setDistanceRadius('0');
      } else {
        filterProvider.citySearchController.text = "";
        filterProvider.setCityValue("");
      }
    }

    filterProvider.setCityValue(filterProvider.citySearchController.text);
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    print(filterProvider);
    print("City-> ${filterProvider.selectedMetropolitanCityInfo}");

    if (widget.route.toLowerCase() == "home") {
      HomeListData().applyHomeData(context);
      Navigator.pop(context);
    } else if (widget.route.toLowerCase() == "search") {
      print("IS CITY SELECTED ${filterProvider.isCitySelected}");
      if (filterProvider.isCitySelected &&
          // filterProvider.citySearchController.text == "" &&
          filterProvider.selectedMetropolitanCityInfo == "") {
        print("Toast called");
        GlobalView().showToast(AppToastMessages.enter_city_for_filter_message);
      } else {
        SearchListData()
            .applySearchDataForDistance(context, widget.distanceRadius);
        Navigator.pop(context);
      }
    }
  }

  void onClickResetButton() {
    filterProvider.citySearchController.text = "";
    filterProvider.setCityValue(filterProvider.citySearchController.text);
    Provider.of<HomeFeedResponseProvider>(context, listen: false)
        .homeFeedResponse = null;
    filterProvider.setDistanceRadius("5");
    if (widget.route.toLowerCase() == "home") {
      HomeListData().resetHomeData(context);
    } else if (widget.route.toLowerCase() == "search") {
      SearchListData().resetSearchDataForDistance(context);
    }

    Navigator.pop(context);
    Provider.of<FilterProvider>(context, listen: false)
        .selectedMetropolitanCityInfo = "";
    filterProvider.citySearchController.text = "";
  }
}

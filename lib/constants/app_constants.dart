import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';

const List<String> listOfTimeZone = [
  "GMT-12",
  "GMT-11",
  "GMT-10",
  "GMT-9",
  "GMT-8",
  "GMT-7",
  "GMT-6",
  "GMT-5",
  "GMT-4",
  "GMT-3",
  "GMT-2",
  "GMT-1",
  "GMT+1",
  "GMT+2",
  "GMT+3",
  "GMT+4",
  "GMT+5",
  "GMT+6",
  "GMT+7",
  "GMT+8",
  "GMT+9",
  "GMT+10",
  "GMT+11",
  "GMT+12",
];

final Map<int, Widget> myFilterTabs = <int, Widget>{
  0: GlobalView().textViewWithCenterAlign(
    AppMessages.by_city_text,
    AppTextStyle.inter_font_family,
    AppTextStyle.medium_font_weight,
    BaseColor.grey_color,
    14,
  ),
  1: GlobalView().textViewWithCenterAlign(
    AppMessages.by_distance_text,
    AppTextStyle.inter_font_family,
    AppTextStyle.medium_font_weight,
    BaseColor.grey_color,
    14,
  ),
};

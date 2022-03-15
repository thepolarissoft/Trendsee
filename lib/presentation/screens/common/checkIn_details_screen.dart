import 'package:flutter/material.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/checkIn_details_page.dart';

class CheckInDetailsScreen extends StatelessWidget {

  // FeedResponse feedResponse = new FeedResponse();
  //   CheckInDetailsScreen(this.feedResponse);
  @override
  Widget build(BuildContext context) {
    return Container(
        color: BaseColor.pure_white_color,
        child: SafeArea(
            child:
                GlobalView().safeAreaView(CheckInDetailsPage())));
    // return CheckInDetailsPage();
  }
}

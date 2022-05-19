// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

class FeedsDescriptionScreen extends StatefulWidget {
  FeedsDescriptionScreen({Key key, @required this.businessUserId})
      : super(key: key);
  String businessUserId;

  @override
  State<FeedsDescriptionScreen> createState() => _FeedsDescriptionScreenState();
}

class _FeedsDescriptionScreenState extends State<FeedsDescriptionScreen> {
  int page = 1;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SearchByBusinessProvider>(context, listen: false)
          .getFeedListbyBusinessID(context, widget.businessUserId, page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.pure_white_color,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: BaseColor.pure_white_color,
          body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Colors.red,
                image: DecorationImage(
                    image: AssetImage(
                      AppImages.background_image1,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GlobalView().sizedBoxView(10),
                      Align(
                        alignment: Alignment.center,
                        child: GlobalView().textViewWithCenterAlign(
                            AppMessages.business_checkins_title,
                            AppTextStyle.inter_font_family,
                            AppTextStyle.bold_font_weight,
                            BaseColor.black_color,
                            18),
                      ),
                      Expanded(child: Consumer<SearchByBusinessProvider>(
                          builder: (context, provider, widget) {
                        return ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: provider.listFeedInfo.length,
                            itemBuilder: (_, index) {
                              return Card(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GlobalView().textViewWithStartAlign(
                                        provider
                                            .listFeedInfo[index].description,
                                        AppTextStyle.inter_font_family,
                                        AppTextStyle.semi_bold_font_weight,
                                        BaseColor.black_color,
                                        18),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GlobalView().textViewWithEndAlign(
                                          DayTimeUtils().convertToAgo(provider
                                              .listFeedInfo[index].createdAt),
                                          AppTextStyle.inter_font_family,
                                          AppTextStyle.medium_font_weight,
                                          BaseColor.count_color,
                                          10),
                                    ),
                                  ],
                                ),
                              ));
                            });
                      })),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        AppImages.ic_back,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Visibility(
                      visible: Provider.of<HomeFeedResponseProvider>(context)
                          .isLoading,
                      child: Container(
                        // color: BaseColor.loader_bg_color,
                        child: GlobalView().loaderView(),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

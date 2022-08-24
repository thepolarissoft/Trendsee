import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/disliked_comments_response.dart';
import 'package:trendoapp/global/view/comments_view.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/providers/search_by_business_provider.dart';

// ignore: must_be_immutable
class DislikedReviewCommentScreen extends StatefulWidget {
  int? businessId;
  DislikedReviewCommentScreen({Key? key, required this.businessId})
      : super(key: key);

  @override
  State<DislikedReviewCommentScreen> createState() =>
      _DislikedReviewCommentScreenState();
}

class _DislikedReviewCommentScreenState
    extends State<DislikedReviewCommentScreen> {
  int page = 1;
  ScrollController scrollController = new ScrollController();
  void getDislikedData() {
    Provider.of<SearchByBusinessProvider>(context, listen: false)
        .dislikedCommentList(context, page, widget.businessId);
  }

  void getMoreData() {
    var provider =
        Provider.of<SearchByBusinessProvider>(context, listen: false);
    DislikedCommentsResponse dislikedCommentsResponse =
        provider.dislikedCommentsResponse;
    if (dislikedCommentsResponse != null &&
        dislikedCommentsResponse.dislike!.nextPageUrl != null) {
      page++;
      getDislikedData();
    } else {
      // GlobalView().showToast(AppMessages.no_more_data_text);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getDislikedData();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.home_bg_color,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          backgroundColor: BaseColor.home_bg_color,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalView().sizedBoxView(20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                        height: 22,
                        width: 22,
                        child: GlobalView().buttonBack(context)),
                  ),
                  GlobalView().sizedBoxView(20),
                  Expanded(
                    child: GlobalView().textViewWithCenterAlign(
                        AppMessages.review_commnets_text,
                        AppTextStyle.inter_font_family,
                        AppTextStyle.bold_font_weight,
                        BaseColor.black_color,
                        18),
                  ),
                ],
              ),
              GlobalView().sizedBoxView(10),
              Expanded(
                child: dislikedCommentListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dislikedCommentListView() => Consumer<SearchByBusinessProvider>(
        builder: (_, provider, child) {
          if (!provider.isLoading) {
            return Container(
              // color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: scrollController,
                      itemCount: provider.listDislikedComments.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemBuilder: (context, itemIndex) {
                        return CommentsView(
                          commentResponse:
                              provider.listDislikedComments[itemIndex],
                        );
                      },
                    ),
                    Visibility(
                      visible: !provider.isAvailableComment,
                      child: Center(
                        child: GlobalView().textViewWithCenterAlign(
                          AppMessages.no_more_data_text,
                          AppTextStyle.inter_font_family,
                          AppTextStyle.semi_bold_font_weight,
                          BaseColor.black_color,
                          16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                // color: BaseColor.loader_bg_color,
                child: GlobalView().loaderView(),
              ),
            );
          }
        },
      );
}

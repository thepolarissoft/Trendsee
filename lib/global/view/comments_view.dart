// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trendoapp/constants/app_text_style.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/data/models/comment_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/utils/day_time_utils.dart';

class CommentsView extends StatelessWidget {
  CommentResponse commentResponse = new CommentResponse();
  CommentsView({Key key, @required this.commentResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Container(
          // color: Colors.grey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 36,
              //   width: 36,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     // color: BaseColor.btnGradientEndColor1,
              //     image: DecorationImage(
              //         image: commentProvider
              //                         .listComments[
              //                             itemIndex]
              //                         .user !=
              //                     null &&
              //                 commentProvider
              //                         .listComments[
              //                             itemIndex]
              //                         .user
              //                         .avatar !=
              //                     null
              //             ? NetworkImage(commentProvider
              //                 .listComments[itemIndex]
              //                 .user
              //                 .avatar)
              //             : AssetImage(AppImages.photo3),
              //         fit: BoxFit.cover),
              //   ),
              // ),
              // SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GlobalView().textViewWithStartAlign(
                                commentResponse.user != null &&
                                        commentResponse.user.username != null
                                    ? commentResponse.user.username
                                    //  +
                                    // " " +
                                    // commentResponse.user.lastName
                                    : "John",
                                AppTextStyle.inter_font_family,
                                AppTextStyle.semi_bold_font_weight,
                                BaseColor.commented_user_txt_color,
                                14),
                          ),
                          GlobalView().textViewWithEndAlign(
                              commentResponse != null &&
                                      commentResponse.createdAt != null
                                  ? DayTimeUtils()
                                      .convertToAgo(commentResponse.createdAt)
                                  //  provider
                                  //     .listDislikedComments[
                                  //         itemIndex]
                                  //     .createdAt
                                  //     .toLocal()
                                  //     .toString()
                                  : "10 March, 2020, 10:30 am",
                              AppTextStyle.inter_font_family,
                              AppTextStyle.medium_font_weight,
                              BaseColor.box_border_color,
                              10)
                        ],
                      ),
                      GlobalView().sizedBoxView(8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GlobalView().textViewWithStartAlign(
                            commentResponse != null &&
                                    commentResponse.comment != null
                                ? commentResponse.comment
                                : "comment",
                            AppTextStyle.inter_font_family,
                            AppTextStyle.medium_font_weight,
                            BaseColor.comment_txt_color,
                            12),
                      ),
                      // Divider(color:BaseColor.btn_gradient_end_color1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

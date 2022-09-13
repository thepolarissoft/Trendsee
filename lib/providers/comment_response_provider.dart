import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_toast_messages.dart';
import 'package:trendoapp/data/models/comment_list_response.dart';
import 'package:trendoapp/data/models/comment_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/providers/home_feed_response_provider.dart';

class CommentResponseProvider extends ChangeNotifier {
  CommentListResponse? commentListResponse;
  List<CommentResponse> listComments = [];
  bool isLoading = false;

  void getCommentList(BuildContext context, int? feedId) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).getCommentList(feedId.toString()).then((response) {
      commentListResponse = response;
      if (commentListResponse!.statuscode == 200) {
        if (commentListResponse != null &&
            commentListResponse!.feed != null &&
            commentListResponse!.feed!.categories!.isNotEmpty) {
          isLoading = false;
          listComments.clear();
          listComments.addAll(commentListResponse!.feed!.comments!);
          // GlobalView().showToast(AppToastMessages.sucessfullyDataFetchMessage);
        } else {
          isLoading = false;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getCommentList(context, feedId);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void createComment(BuildContext context, int? feedId, String comment) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context)
        .createComment(feedId.toString(), comment)
        .then((response) {
      commentListResponse = response;
      if (commentListResponse!.statuscode == 200) {
        if (commentListResponse != null &&
            commentListResponse!.feed != null &&
            commentListResponse!.feed!.categories!.isNotEmpty != null) {
          isLoading = false;
          Provider.of<HomeFeedResponseProvider>(context, listen: false)
              .feedResponse
              .totalComments = commentListResponse!.feed!.totalComments;
          print(
              "TOTAL COMMENTS-->> ${Provider.of<HomeFeedResponseProvider>(context, listen: false).feedResponse.totalComments}");
          listComments.clear();
          listComments.addAll(commentListResponse!.feed!.comments!);
          GlobalView().showToast(AppToastMessages.comment_posted_message);
        } else {
          isLoading = false;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          createComment(context, feedId, comment);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }
}

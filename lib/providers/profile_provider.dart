import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trendoapp/api/api_manager.dart';
import 'package:trendoapp/constants/app_messages.dart';
import 'package:trendoapp/data/models/base_response.dart';
import 'package:trendoapp/data/models/like_dislike_response.dart';
import 'package:trendoapp/data/models/profile_response.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/global/view/show_alert_view.dart';
import 'package:trendoapp/presentation/screens/common/email_verification_screen.dart';
import 'package:trendoapp/utils/dialog_utils.dart';
import 'package:trendoapp/utils/preference_utils.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileResponse profileResponse;
  bool isLoading = false;
  bool isVisible = false;
  LikeDislikeResponse likeDislikeResponse;
  int current = 0;
  // List<String> listMediaImages = [];
  Baseresponse baseresponse;

  void getProfile(BuildContext context) async {
    isLoading = true;
    // notifyListeners();
    ApiManager(context).getProfile().then((response) {
      if (response.statuscode == 200) {
        profileResponse = response;
        PreferenceUtils.setObject(PreferenceUtils.keyStandardUserProfileObject,
            json.encode(profileResponse));
        if (response != null) {
          isLoading = false;
          if (response.user.businessMedia.isNotEmpty) {}
          // notifyListeners();
          print("PROFILE RESPONSE-->> ${response.user.avatar}");
        } else {
          isLoading = true;
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> $onError");
      ShowAlertView(
              context: context,
              onCallBack: () {
                getProfile(context);
              },
              exception: onError)
          .showAlertDialog();
      notifyListeners();
    });
  }

  void setCurrentIndex(int index) {
    current = index;
    notifyListeners();
  }

  void deleteMycheckIns(BuildContext context, int feedId) async {
    ApiManager(context).deleteMyCheckIns(feedId.toString()).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        // isLoading = false;
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200) {
          GlobalView().showToast(baseresponse.msg);
          profileResponse.user.totalFeeds = profileResponse.user.totalFeeds - 1;
          profileResponse.user.feed.removeAt(0);
        } else {
          print("baseresponse-> ${baseresponse.statuscode}");
          GlobalView().showToast(baseresponse.msg);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          deleteMycheckIns(context, feedId);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }
  // void checkIns_like_dislike(BuildContext context, String feed_id, String event,
  //     String is_like, String is_dislike, int index) async {
  //   // isLoading = true;
  //   // notifyListeners();
  //   print("Like-->> $is_like" + "DisLike-->> $is_dislike");
  //   likeDislikeResponse = await ApiManager(context)
  //       .homeFeedLikeDislike(feed_id, is_like, is_dislike);
  //   if (likeDislikeResponse != null) {
  //     // isLoading = false;
  //     print("likeDislikeResponse--->>== ${likeDislikeResponse.msg}");
  //     if (likeDislikeResponse.statuscode == 200) {
  //       changeCheckInsikeDislikeValue(event, is_like, is_dislike, index);
  //       GlobalView().showToast(likeDislikeResponse.msg);
  //     } else {
  //       print("baseresponse-> ${likeDislikeResponse.statuscode}");
  //       GlobalView().showToast(likeDislikeResponse.msg);
  //     }
  //   } else {
  //     // isLoading = true;
  //   }
  // }

  void checkInsLike(
      BuildContext context, int feedId, int isLike, int index) async {
    print("feed_id->> $feedId");
    ApiManager(context).homeFeedLike(feedId, isLike).then((response) {
      baseresponse = response;
      if (baseresponse != null) {
        print("baseresponse--->>== ${baseresponse.msg}");
        if (baseresponse.statuscode == 200 || baseresponse.statuscode == 201) {
          if (isLike == 1) {
            profileResponse.user.feed[index].isLiked = 1;
            profileResponse.user.feed[index].totalLikes =
                profileResponse.user.feed[index].totalLikes + 1;
          } else {
            profileResponse.user.feed[index].isLiked = 0;
            profileResponse.user.feed[index].totalLikes =
                profileResponse.user.feed[index].totalLikes - 1;
          }
          GlobalView().showToast(AppMessages.like_business_text);
        } else {
          print("baseresponse-> ${baseresponse.statuscode}");
          GlobalView().showToast(baseresponse.msg);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          checkInsLike(context, feedId, isLike, index);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void changeCheckInsikeDislikeValue(
      String event, String isLike, String isDislike, int index) {
    profileResponse.user.feed[index].totalLikes = 0;
    profileResponse.user.feed[index].totalDislikes = 0;
    if (event.toLowerCase() == "like") {
      if (isLike == "1") {
        profileResponse.user.feed[index].isLiked = 1;
        profileResponse.user.feed[index].isDisliked = 0;
      } else {
        profileResponse.user.feed[index].isLiked = 0;
        profileResponse.user.feed[index].isDisliked = 0;
      }
      profileResponse.user.feed[index].totalLikes =
          likeDislikeResponse.feed.totalLikes;
      profileResponse.user.feed[index].totalDislikes =
          likeDislikeResponse.feed.totalDislikes;
    } else if (event.toLowerCase() == "dislike") {
      if (isDislike == "1") {
        profileResponse.user.feed[index].isLiked = 0;
        profileResponse.user.feed[index].isDisliked = 1;
      } else {
        profileResponse.user.feed[index].isLiked = 0;
        profileResponse.user.feed[index].isDisliked = 0;
      }
      profileResponse.user.feed[index].totalDislikes =
          likeDislikeResponse.feed.totalDislikes;
      profileResponse.user.feed[index].totalLikes =
          likeDislikeResponse.feed.totalLikes;
    }
    notifyListeners();
  }

  void changeIsVisibleValue() {
    if (isVisible) {
      isVisible = false;
    } else {
      isVisible = true;
    }
    notifyListeners();
  }

  void signIn(BuildContext context, String userInput) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).signIn(userInput).then((response) {
      profileResponse = response;
      print("STATUS CODE-> ${profileResponse.statuscode}");
      print("MSG-> ${profileResponse.msg}");
      if (profileResponse != null) {
        isLoading = false;
        if (profileResponse.statuscode == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EmailVerificationScreen(profileResponse.user.email)));
        } else if ((profileResponse.statuscode == 403 &&
                profileResponse.msg == "User is suspended") ||
            (profileResponse.statuscode == 405 &&
                profileResponse.msg == "User is deactivated")) {
          DialogUtils().showSupportAlertDialog(context, "deactivate");
        } else if (profileResponse.statuscode == 406 &&
            profileResponse.msg == "User is deleted") {
          DialogUtils().showSupportAlertDialog(context, "delete");
        } else if (profileResponse.statuscode == 402 &&
            profileResponse.msg == "Business needs approval by admin") {
          DialogUtils().showSupportAlertDialog(context, "approval");
        } else {
          isLoading = false;
          GlobalView().showToast(profileResponse.msg);
        }
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          signIn(context, userInput);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }

  void getUserByIdToken(BuildContext context, int userId) async {
    isLoading = true;
    notifyListeners();
    ApiManager(context).getUserByIdToken(userId).then((response) {
      profileResponse = response;
      print("STATUS CODE-> ${profileResponse.statuscode}");
      print("MSG-> ${profileResponse.msg}");
      if (profileResponse != null) {
        isLoading = false;
        if (profileResponse.statuscode == 200) {}
      }
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      print("ONERROR->> ${onError.toString()}");
      ShowAlertView(
        context: context,
        onCallBack: () {
          getUserByIdToken(context, userId);
        },
        exception: onError,
      ).showAlertDialog();
      notifyListeners();
    });
  }
}


// isLoading = true;
    // // notifyListeners();
    // profileResponse = await ApiManager(context).getProfile();
    // if (profileResponse.statuscode == 200) {
    //   if (profileResponse != null) {
    //     isLoading = false;
    //     if (profileResponse.user.businessMedia.isNotEmpty) {
    //       // listMediaImages.clear();
    //       // for (var i = 0; i < profileResponse.user.businessMedia.length; i++) {
    //       //   listMediaImages.add(profileResponse.user.businessMedia[i].media);
    //       //   // print("listMediaImages-->> ${listMediaImages[i]}");
    //       // }
    //     }
    //     notifyListeners();
    //     print("PROFILE RESPONSE-->> ${profileResponse.user.avatar}");
    //     // GlobalView().showToast(AppToastMessages.sucessfullyDataFetchMessage);
    //   } else {
    //     isLoading = true;
    //   }
    // }